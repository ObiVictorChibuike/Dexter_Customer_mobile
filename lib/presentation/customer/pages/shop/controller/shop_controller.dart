import 'dart:convert';
import 'dart:developer';

import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/widgets/custom_snack.dart';
import 'package:dexter_mobile/app/shared/widgets/progress_indicator.dart';
import 'package:dexter_mobile/data/cart/cart_by_shop_response_model.dart';
import 'package:dexter_mobile/data/cart/clear_cart_by_shop.dart';
import 'package:dexter_mobile/data/cart/remove_cartItem_response_model.dart';
import 'package:dexter_mobile/data/products/product_category_response_model.dart';
import 'package:dexter_mobile/data/products/product_under_category_response_model.dart';
import 'package:dexter_mobile/data/shops_model/shop_by_services_response_model.dart';
import 'package:dexter_mobile/data/shops_model/shop_response_model.dart';
import 'package:dexter_mobile/domain/local/local_storage.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dexter_mobile/presentation/message/controller/contact_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopController extends GetxController{
  int selectedPageIndex = 0;
  void changeIndex(int index){
    selectedPageIndex = index;
    update();
    getProductsUnderCategoryWithStateStatus(categoryId: categoryResponseModel!.data![selectedPageIndex].id.toString());
  }

  ShopByServicesResponse? shopByServicesResponse;
  CartByShopResponse? cartByShopResponse;
  bool? shopByServicesLoadingState;
  bool? shopByServicesErrorState;
  Future<void> getShopByServices({required String serviceId})async{
    shopByServicesLoadingState = true;
    shopByServicesErrorState = false;
    update();
    try{
      final response = await NetworkProvider().call(path: "/services/$serviceId/shops", method: RequestMethod.get);
      shopByServicesResponse = ShopByServicesResponse.fromJson(response!.data);
      shopByServicesLoadingState = false;
      shopByServicesErrorState = false;
      update();
    }on DioError catch (err) {
      shopByServicesLoadingState = false;
      shopByServicesErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar("Error", err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      shopByServicesLoadingState = false;
      shopByServicesErrorState = true;
      update();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }

  ShopResponseModel? shopResponseModel;
  CategoryResponseModel? categoryResponseModel;
  List<String?>? categoryName;
  ProductUnderCategoryResponseModel? productUnderCategoryResponseModel;
  bool? shopLoadingState;
  bool? shopErrorState;
  var totalItemInCart = 0.obs;

  Future<void> getAShop({required String shopId})async{
    totalItemInCart = 0.obs;
    shopLoadingState = true;
    shopErrorState = false;
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final _controller = Get.put(ContactController());
    await LocalCachedData.instance.cacheUserShopId(shopId: shopId);
    try{
      final response = await NetworkProvider().call(path: "/shops/$shopId", method: RequestMethod.get);
      shopResponseModel = ShopResponseModel.fromJson(response!.data);
      if(shopResponseModel?.data != null){
        _controller.asyncLoadSingleUserData(vendorId: shopResponseModel!.data!.vendorId!.toString());
        await getAShopCategory(shopId: shopId).then((value) async {
          categoryResponseModel = value;
          if(categoryResponseModel != null && categoryResponseModel!.data!.isNotEmpty != []){
            categoryName = categoryResponseModel!.data!.map((e) => e.name).toList();
            await getProductsUnderCategory(categoryId: categoryResponseModel!.data!.first.id.toString()).then((value){
              productUnderCategoryResponseModel = value;
              update();
            });
          }else{
            categoryResponseModel = null;
            update();
          }
          await cartByAShop(shopId: shopId).then((value) async {
            cartByShopResponse = value;
            if(value.data!.isNotEmpty){
              Get.put<LocalCachedData>(await LocalCachedData.create());
              await LocalCachedData.instance.cacheUserCartId(cartId: value.data!.first.shopId.toString());
              totalItemInCart = value.data!.first.cartItems!.length.obs;
            }
          });
          shopLoadingState = false;
          shopErrorState = false;
          update();
        });
      }
    }on DioError catch (err) {
      shopLoadingState = false;
      shopErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.response?.data['message'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      shopLoadingState = false;
      shopErrorState = true;
      update();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.toString());
      throw err.toString();
    }
  }

  double? summation;
  late int quantity = 1;
  void incrementQuantity({required String price}){
    quantity++;
    summation = double.parse(price) * quantity;
    update();
  }



  Future<void> clearCartByShop({required BuildContext context})async{
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final shopCartId = await LocalCachedData.instance.getUserCartId();
    progressIndicator(context);
    try{
      final response = await NetworkProvider().call(path: "/shops/$shopCartId/cart", method: RequestMethod.delete);
      final clearCartByShopResponse = ClearCartByShopResponseModel.fromJson(response!.data);
      await cartByAShop(shopId: shopCartId!).then((value) async {
        cartByShopResponse = value;
        totalItemInCart = 0.obs;
        await LocalCachedData.instance.clearUserCartId();
        Get.back();
        Get.snackbar("Success", clearCartByShopResponse.message ?? "Cart Cleared Successfully", colorText: white, backgroundColor: greenPea);
      });
    }on DioError catch (err) {
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error",err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      update();
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }


  Future<CartByShopResponse> cartByAShop({required String shopId})async{
    try{
      final response = await NetworkProvider().call(path: "/shops/$shopId/cart", method: RequestMethod.get);
      final data = CartByShopResponse.fromJson(response!.data);
      cartByShopResponse = data;
      update();
      return data;
    }on DioError catch (err) {
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error", err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      update();
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }


  Future<CategoryResponseModel> getAShopCategory({required String shopId})async{
    try{
      final response = await NetworkProvider().call(path: "/shops/$shopId/categories", method: RequestMethod.get);
      final categoryResponseModel = CategoryResponseModel.fromJson(response!.data);
      return categoryResponseModel;
    }on DioError catch (err) {
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error", err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      update();
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }

  Future<ProductUnderCategoryResponseModel> getProductsUnderCategory({required String categoryId})async{
    try{
      final response = await NetworkProvider().call(path: "/categories/$categoryId/products", method: RequestMethod.get);
      final productUnderCategoryResponseModel = ProductUnderCategoryResponseModel.fromJson(response!.data);
      return productUnderCategoryResponseModel;
    }on DioError catch (err) {
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error", err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      update();
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }

  bool? productUnderCategoryLoadingState;
  bool? productUnderCategoryErrorState;

  Future<void> getProductsUnderCategoryWithStateStatus({required String categoryId})async{
    productUnderCategoryLoadingState = true;
    productUnderCategoryErrorState = false;
    try{
      final response = await NetworkProvider().call(path: "/categories/$categoryId/products", method: RequestMethod.get);
      final payload = ProductUnderCategoryResponseModel.fromJson(response!.data);
      productUnderCategoryResponseModel = payload;
      productUnderCategoryLoadingState = false;
      update();
    }on DioError catch (err) {
      productUnderCategoryLoadingState = false;
      productUnderCategoryErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error", err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      productUnderCategoryLoadingState = false;
      productUnderCategoryErrorState = true;
      update();
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }

  Future<void> deleteItemFromCart({required String shopId, required String productId, required String cartId})async{
    progressIndicator(Get.context!);
    try{
      var postBody = jsonEncode({
        "product_id":  productId,
        "cart_id": cartId,
      });
      final response = await NetworkProvider().call(path: "/shops/$shopId/remove-from-cart", method: RequestMethod.post, body: postBody);
      final data = RemoveItemFromCartResponseModel.fromJson(response!.data);
      await cartByAShop(shopId: shopId).then((value) async {
        cartByShopResponse = value;
        totalItemInCart = 0.obs;
        await LocalCachedData.instance.clearUserCartId();
        Get.back();
        Get.snackbar("Success", data.message ?? "Item Successfully Deleted", backgroundColor: greenPea, colorText: white);
        update();
      });
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      throw errorMessage;
    } catch (err) {
      Get.back();
      throw err.toString();
    }
  }
}
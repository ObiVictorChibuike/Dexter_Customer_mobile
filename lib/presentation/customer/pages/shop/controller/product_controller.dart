import 'dart:convert';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/widgets/custom_snack.dart';
import 'package:dexter_mobile/app/shared/widgets/progress_indicator.dart';
import 'package:dexter_mobile/data/products/add_product_to_cart_response_model.dart';
import 'package:dexter_mobile/data/products/product_review_response_model.dart';
import 'package:dexter_mobile/domain/local/local_storage.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/controller/shop_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  ProductReviewsResponse? productReviewsResponse;
  bool? productReviewsLoadingState;
  bool? productReviewsErrorState;
  Future<void> getProductId({required String productId})async{
    productReviewsLoadingState = true;
    productReviewsErrorState = false;
    update();
    try{
      final response = await NetworkProvider().call(path: "/products/$productId/reviews", method: RequestMethod.get);
      productReviewsResponse = ProductReviewsResponse.fromJson(response!.data);
      productReviewsLoadingState = false;
      update();
    }on DioError catch (err) {
      productReviewsLoadingState = false;
      productReviewsErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error",err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      productReviewsLoadingState = false;
      productReviewsErrorState = true;
      update();
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }
  final shopController = Get.put(ShopController());
  Future<void> addProductToCart({required String shopId, required int productId, required int quantity})async{
    progressIndicator(Get.context);
    final controller = Get.put(ShopController());
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final shopId = await LocalCachedData.instance.getUserShopId();
    try{
      var postBody = jsonEncode({
        "product_id":  productId,
        "quantity": quantity,
      });
      final response = await NetworkProvider().call(path: "/shops/$shopId/add-to-cart", method: RequestMethod.post, body: postBody);
      final value = AddProductToCartResponse.fromJson(response!.data);
      await LocalCachedData.instance.cacheUserCartId(cartId: shopId);
      await controller.cartByAShop(shopId: shopId!.toString()).then((value){
        controller.totalItemInCart = value.data!.first.cartItems!.length.obs;
        controller.update();
        update();
      });
      Get.back();
      Get.snackbar("Success", value.message ?? "Product added to cart", colorText: white, backgroundColor: greenPea);
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error",err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }

  Future<void> incrementProductQuantityFromCart({required String shopId, required int productId, required int quantity})async{
    progressIndicator(Get.context);
    final controller = Get.put(ShopController());
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final shopId = await LocalCachedData.instance.getUserShopId();
    try{
      var postBody = jsonEncode({
        "product_id":  productId,
        "quantity": quantity,
      });
      final response = await NetworkProvider().call(path: "/shops/$shopId/add-to-cart", method: RequestMethod.post, body: postBody);
      final value = AddProductToCartResponse.fromJson(response!.data);
      await LocalCachedData.instance.cacheUserCartId(cartId: shopId);
      await controller.cartByAShop(shopId: shopId!.toString()).then((value){
        controller.totalItemInCart = value.data!.first.cartItems!.length.obs;
        controller.update();
        update();
      });
      Get.back();
      //Get.snackbar("Success", "Item successfully removed from cart", colorText: white, backgroundColor: greenPea);
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error",err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }

  Future<void> decrementProductQuantityFromCart({required String shopId, required int productId, required int quantity})async{
    progressIndicator(Get.context);
    final controller = Get.put(ShopController());
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final shopId = await LocalCachedData.instance.getUserShopId();
    try{
      var postBody = jsonEncode({
        "product_id":  productId,
        "quantity": quantity,
      });
      final response = await NetworkProvider().call(path: "/shops/$shopId/remove-from-cart", method: RequestMethod.post, body: postBody);
      final value = AddProductToCartResponse.fromJson(response!.data);
      await LocalCachedData.instance.cacheUserCartId(cartId: shopId);
      await controller.cartByAShop(shopId: shopId!.toString()).then((value){
        controller.totalItemInCart = value.data!.first.cartItems!.length.obs;
        controller.update();
        update();
      });
      Get.back();
      //Get.snackbar("Success", value.message ?? "Product added to cart", colorText: white, backgroundColor: greenPea);
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error",err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }
}
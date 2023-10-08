import 'dart:convert';
import 'dart:developer';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/utils/flush_bar.dart';
import 'package:dexter_mobile/core/state/view_state.dart';
import 'package:dexter_mobile/data/checkout/check_model_response.dart';
import 'package:dexter_mobile/datas/model/shop_response/cart_response.dart';
import 'package:dexter_mobile/datas/model/shop_response/clear_cart_response.dart';
import 'package:dexter_mobile/datas/model/shop_response/decrement_cart_item_response.dart';
import 'package:dexter_mobile/datas/model/shop_response/delete_cart_item_response.dart';
import 'package:dexter_mobile/datas/model/shop_response/increment_cart_item_response.dart';
import 'package:dexter_mobile/datas/repository/dashboard_repository/restaurant_food_cart_respository.dart';
import 'package:dexter_mobile/datas/services/dashboard_services/restaurant_food_cart_services.dart';
import 'package:dexter_mobile/domain/local/local_storage.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_data_state.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dexter_mobile/domain/repository/restaurant_cart/restaurant_food_cart_impl.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/controller/shop_controller.dart';
import 'package:dexter_mobile/presentation/customer/widget/order_and_booking_succcess_page.dart';
import 'package:dexter_mobile/presentation/customer/widget/progress_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;

class RestaurantCartController extends GetxController{
  final getUserFoodCart = Get.put(GetRestaurantFoodCartImpl(RestaurantFoodCartRepository(RestaurantFoodCartService())));
  final addToCart = Get.put(AddFoodToCartImpl(RestaurantFoodCartRepository(RestaurantFoodCartService())));
  final removeFromCart = Get.put(RemoveFoodFromCartImpl(RestaurantFoodCartRepository(RestaurantFoodCartService())));
  final reduceFoodQuantityFromCart = Get.put(ReduceFoodQuantityFromCartImpl(RestaurantFoodCartRepository(RestaurantFoodCartService())));
  final shopController = Get.put(ShopController());
  String? errorMessage;
  ViewState<CartResponse> getRestaurantFoodCartViewState = ViewState(state: ResponseState.EMPTY);

  void _setGetRestaurantFoodCartViewState(ViewState<CartResponse> getRestaurantFoodCartViewState) {
    this.getRestaurantFoodCartViewState = getRestaurantFoodCartViewState;
  }

  ViewState<IncrementCartItemResponse> incrementCartItemViewState = ViewState(state: ResponseState.EMPTY);

  void _setIncrementCartItemViewState(ViewState<IncrementCartItemResponse> incrementCartItemViewState) {
    this.incrementCartItemViewState = incrementCartItemViewState;
  }

  ViewState<IncrementCartItemResponse> addItemToCartViewState = ViewState(state: ResponseState.EMPTY);

  void _setAddItemToCartViewState(ViewState<IncrementCartItemResponse> addItemToCartViewState) {
    this.addItemToCartViewState = addItemToCartViewState;
  }

  ViewState<DeleteCartItemResponse> removeFromCartViewState = ViewState(state: ResponseState.EMPTY);

  void _setRemoveFromCartViewState(ViewState<DeleteCartItemResponse> removeFromCartViewState) {
    this.removeFromCartViewState = removeFromCartViewState;
  }

  ViewState<DecrementCartItemResponse> reduceFoodQuantityFromCartViewState = ViewState(state: ResponseState.EMPTY);

  void _setIncrementItemQuantityInCartViewState(ViewState<DecrementCartItemResponse> reduceQuantityFromCartViewState) {
    this.reduceFoodQuantityFromCartViewState = reduceQuantityFromCartViewState;
  }


  // Future<void> getShopCart() async {
  //   _setGetRestaurantFoodCartViewState(ViewState.loading());
  //   update();
  //   await getUserFoodCart.noParamCall().then((value) async {
  //     if(value is DataSuccess || value.data != null) {
  //       _setGetRestaurantFoodCartViewState(ViewState.complete(value.data!));
  //       update();
  //     }if (value is DataFailed || value.data == null) {
  //       if (kDebugMode) {
  //         print(value.error);
  //       }errorMessage = value.error.toString();
  //       _setGetRestaurantFoodCartViewState(ViewState.error(value.error.toString()));
  //       update();
  //     }}
  //   );
  // }

  Future<void> addFoodToCart({required String id, required BuildContext context}) async {
    _setAddItemToCartViewState(ViewState.loading());
    Get.put<LocalCachedData>(await LocalCachedData.create());
    update();
    await addToCart.execute(params: AddFoodToCartParam(id)).then((value) async {
      if(value is DataSuccess || value.data != null) {
        final shopId = await LocalCachedData.instance.getUserShopId();
        await shopController.cartByAShop(shopId: shopId.toString());
        Get.back();
        FlushBarHelper(context, value.data?.message ?? "Item added to cart").showSuccessBar;
        _setAddItemToCartViewState(ViewState.complete(value.data!));
        update();
      }if (value is DataFailed || value.data == null) {
        log(value.error.toString());
        if (kDebugMode) {
          print(value.error);
        }errorMessage = value.error.toString();
        _setAddItemToCartViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }


  // Future<CartResponse> incrementItemInCart({required String? id}) async {
  //   try{
  //     var response = await NetworkProvider().call(path: "/api/cart/add-to-cart/$id", method: RequestMethod.post);
  //     final payLoad = CartResponse.fromJson(response!.data);
  //     return payLoad;
  //   }on dio.DioError catch (err) {
  //     final errorMessage = Future.error(ApiError.fromDio(err));
  //     Get.back();
  //     update();
  //     throw errorMessage;
  //   } catch (err) {
  //     Get.back();
  //     update();
  //     throw err.toString();
  //   }
  // }

  Future<void> incrementItemInCart({required String id}) async {
    log("message");
    _setGetRestaurantFoodCartViewState(ViewState.loading());
    progressIndicator(Get.context);
    Get.put<LocalCachedData>(await LocalCachedData.create());
    update();
    await addToCart.execute(params: AddFoodToCartParam(id)).then((value) async {
      if(value is DataSuccess || value.data != null) {
        final shopId = await LocalCachedData.instance.getUserShopId();
        await shopController.cartByAShop(shopId: shopId.toString());
        Get.back();
        _setIncrementCartItemViewState(ViewState.complete(value.data!));
      }if (value is DataFailed || value.data == null) {
        log(value.error.toString());
        if (kDebugMode) {
          print(value.error);
        }
        errorMessage = value.error.toString();
        Get.back();
        _setGetRestaurantFoodCartViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }

  Future<void> checkOut({required String cartId, required String addressId, String? notes}) async {
    progressIndicator(Get.context);
    Get.put<LocalCachedData>(await LocalCachedData.create());
    try{
      var postBody = jsonEncode({
        "cart_id":  cartId,
        "address_id": addressId,
        "notes": notes
      });
      var response = await NetworkProvider().call(path: "/checkout", method: RequestMethod.post, body: postBody);
      final payLoad = CheckoutResponseModel.fromJson(response!.data);
      final shopId = await LocalCachedData.instance.getUserShopId();
      await shopController.cartByAShop(shopId: shopId.toString()).then((value){
        Get.back();
        Get.offAll(()=> BookingAndOrderSuccessPage(title:'Order Place',
          body: 'Your order has been Successfully placed, Progress of the order can be followed up in the booking section.',));
      });
      // return payLoad;
    }on dio.DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error",err.response?.data["error"] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      // FlushBarHelper(Get.context, err.response?.data["error"] ?? errorMessage).showErrorBar;
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      // FlushBarHelper(Get.context, err.toString()).showErrorBar;
      update();
      throw err.toString();
    }
  }

  Future<ClearCartResponse> clearCart() async {
    progressIndicator(Get.context);
    Get.put<LocalCachedData>(await LocalCachedData.create());
    try{
      var response = await NetworkProvider().call(path: "/cart/clear-cart", method: RequestMethod.delete,);
      final payLoad = ClearCartResponse.fromJson(response!.data);
      final shopId = await LocalCachedData.instance.getUserShopId();
      await shopController.cartByAShop(shopId: shopId.toString()).then((value){
        Get.back();
        FlushBarHelper(Get.context, response.data["message"] ?? "Cart cleared").showSuccessBar;
      });
      return payLoad;
    }on dio.DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      FlushBarHelper(Get.context, err.response?.data["error"] ?? errorMessage).showErrorBar;
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      FlushBarHelper(Get.context, err.toString()).showErrorBar;
      update();
      throw err.toString();
    }
  }

  Future<void> deleteItemInCart({required String id}) async {
    _setGetRestaurantFoodCartViewState(ViewState.loading());
    progressIndicator(Get.context);
    Get.put<LocalCachedData>(await LocalCachedData.create());
    update();
    await removeFromCart.execute(params: RemoveFoodFromCartParam(id)).then((value) async {
      if(value is DataSuccess || value.data != null) {
        final shopId = await LocalCachedData.instance.getUserShopId();
        await shopController.cartByAShop(shopId: shopId.toString());
        _setRemoveFromCartViewState(ViewState.complete(value.data!));
        Get.back();
        update();
      }if (value is DataFailed || value.data == null) {
        if (kDebugMode) {
          log(value.error.toString());
        }errorMessage = value.error.toString();
        Get.back();
        _setGetRestaurantFoodCartViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }

  Future<void> decrementFoodQuantityFromCart({required String id}) async {
    _setGetRestaurantFoodCartViewState(ViewState.loading());
    progressIndicator(Get.context);
    Get.put<LocalCachedData>(await LocalCachedData.create());
    update();
    await reduceFoodQuantityFromCart.execute(params: ReduceFoodQuantityFromCartParam(id)).then((value) async {
      if(value is DataSuccess || value.data != null) {
        final shopId = await LocalCachedData.instance.getUserShopId();
        await shopController.cartByAShop(shopId: shopId.toString());
        Get.back();
        _setIncrementItemQuantityInCartViewState(ViewState.complete(value.data!));
        update();
      }if (value is DataFailed || value.data == null) {
        if (kDebugMode) {
          log(value.error.toString());
        }errorMessage = value.error.toString();
        Get.back();
        _setGetRestaurantFoodCartViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }
}
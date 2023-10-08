import 'dart:developer';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/widgets/custom_snack.dart';
import 'package:dexter_mobile/core/state/view_state.dart';
import 'package:dexter_mobile/data/shops_model/shop_by_services_response_model.dart';
import 'package:dexter_mobile/datas/location/get_location.dart';
import 'package:dexter_mobile/datas/model/shop_response/product_in_shop_response.dart';
import 'package:dexter_mobile/datas/model/shop_response/shop_response.dart';
import 'package:dexter_mobile/datas/repository/dashboard_repository/restaurant_repository.dart';
import 'package:dexter_mobile/datas/services/dashboard_services/restaurant_services.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_data_state.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dexter_mobile/domain/repository/dashboard/food_in_restaurant_impl.dart';
import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class RestaurantController extends GetxController{

  // int? selectedIndex;
  String? errorMessage;
  final _getFoodInRestaurants = Get.put(GetFoodInRestaurantImpl(RestaurantRepository(RestaurantServices())));


  @override
  void onInit() {
    update();
    super.onInit();
  }

  int initialFoodPackageQuantity = 1;
  int? selectedCheckOutIndex;

  incrementQuantity(int selectedIndex) {
    // final indexList = checkOut!.map((element) => element.index);
    selectedIndex++;
    log(selectedIndex.toString());
    update();
  }

  decrementQuantity() {
    initialFoodPackageQuantity--;
    update();
  }

  ShopsAroundYouResponse? shopsAroundYouResponse;
  bool? restaurantAroundYouLoadingState;
  bool? restaurantAroundYouErrorState;
  Future<void> getRestaurantsAroundYou()async{
    restaurantAroundYouLoadingState = true;
    update();
    final location = await GetLocation.instance!.checkLocation;
    try{
      final response = await NetworkProvider().call(path: "/services/1/around?latitude=${location.latitude}&longitude=${location.longitude}", method: RequestMethod.get);
      final value = ShopsAroundYouResponse.fromJson(response!.data);
      shopsAroundYouResponse = value;
      restaurantAroundYouLoadingState = false;
      update();
    }on DioError catch (err) {
      restaurantAroundYouLoadingState = false;
      restaurantAroundYouErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      throw errorMessage;
    } catch (err) {
      restaurantAroundYouLoadingState = false;
      restaurantAroundYouErrorState = true;
      update();
      throw err.toString();
    }
  }

  // navigateToNextPage({ required int index}) {
  //   selectedIndex = index;
  // }
  //
  // getSelectedItem() {
  //   return controller.viewState.data!.data!.elementAt(selectedIndex!);
  // }

  ViewState<ProductsInShop> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<ProductsInShop> viewState) {
    this.viewState = viewState;
  }
  List<Products>? listFoodInRestaurants;

  Future<void> getFoodInRestaurants({required String id}) async {
    _setViewState(ViewState.loading());
    await _getFoodInRestaurants.execute(params: GetFoodInRestaurantParam(id)).then((value) async {
      if(value is DataSuccess || value.data != null) {
        listFoodInRestaurants = value.data?.data;
        _setViewState(ViewState.complete(value.data!));
        update();
      }if (value is DataFailed || value.data == null) {
        if (kDebugMode) {
          print(value.error);
        }errorMessage = value.error.toString();
        _setViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }

  ShopByServicesResponse? shopByServicesResponse;
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
      update();
    }on DioError catch (err) {
      shopByServicesLoadingState = false;
      shopByServicesErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      throw errorMessage;
    } catch (err) {
      shopByServicesLoadingState = false;
      shopByServicesErrorState = true;
      update();
      Get.back();
      throw err.toString();
    }
  }
}
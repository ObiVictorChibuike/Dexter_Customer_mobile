import 'dart:developer';
import 'package:dexter_mobile/core/state/view_state.dart';
import 'package:dexter_mobile/datas/model/shop_response/get_all_category_response.dart';
import 'package:dexter_mobile/datas/model/shop_response/get_product_in_category_response.dart';
import 'package:dexter_mobile/datas/model/shop_response/product_in_shop_response.dart';
import 'package:dexter_mobile/datas/model/vendor/review_response.dart';
import 'package:dexter_mobile/datas/repository/dashboard_repository/restaurant_repository.dart';
import 'package:dexter_mobile/datas/repository/dashboard_repository/vendor_respoitory.dart';
import 'package:dexter_mobile/datas/services/dashboard_services/restaurant_services.dart';
import 'package:dexter_mobile/datas/services/dashboard_services/vendor_services.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_data_state.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dexter_mobile/domain/repository/dashboard/all_product_category_impl.dart';
import 'package:dexter_mobile/domain/repository/dashboard/food_in_restaurant_impl.dart';
import 'package:dexter_mobile/domain/repository/dashboard/get_product_in_category_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class VendorController extends GetxController{
  final _getAllProductCategory = Get.put(GetAllProductCategoryImpl(VendorRepository(VendorServices())));
  final _getFoodInRestaurants = Get.put(GetFoodInRestaurantImpl(RestaurantRepository(RestaurantServices())));
  final _getProductsInCategory = Get.put(GetProductInCategoryImpl(VendorRepository(VendorServices())));
  var selectedPageIndex = 0.obs;

  void changeIndex(int index){
    selectedPageIndex.value = index;
    update();
  }


  GetAllCategoryResponse? getAllCategoryResponse;
  List<String?>? categoryNames;
  String? errorMessage;
  Future<void> getAllProductCategory({required String shopId})async{
    await _getAllProductCategory.execute(params: GetAllProductCategoryParam(shopId)).then((value) async {
      if(value is DataSuccess || value.data != null) {
        getAllCategoryResponse = value.data;
        final myArray = getAllCategoryResponse!.categories!.map((e) => e.name).toList();
        categoryNames = myArray.toSet().toList();
        update();
      }
      if (value is DataFailed || value.data == null) {
        if (kDebugMode) {
          print(value.error.toString());
        }
        errorMessage = value.error.toString();
        update();
      }}
    );
  }

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


  // ViewState<ProductsInCategoryResponse> productsInCategoryState = ViewState(state: ResponseState.EMPTY);
  //
  // void _setProductsInCategoryState(ViewState<ProductsInCategoryResponse> productsInCategoryStateState) {
  //   this.productsInCategoryState = productsInCategoryStateState;
  // }

  // Future<void> getProductsInCategory({String? categoryId})async{
  //   await _getProductsInCategory.execute(params: GetProductInCategoryParam(categoryId)).then((value) async {
  //     if(value is DataSuccess || value.data != null) {
  //       productsInCategoryResponse = value.data;
  //       categoryId = null;
  //       update();
  //     }
  //     if (value is DataFailed || value.data == null) {
  //       if (kDebugMode) {
  //         print(value.error.toString());
  //       }
  //       errorMessage = value.error.toString();
  //       _setProductsInCategoryState(ViewState.error(value.error.toString()));
  //       update();
  //     }}
  //   );
  // }


  bool? onLoadingProductsInCategory;
  bool? onLoadingProductsInCategoryHasError;
  ProductsInCategoryResponse? productsInCategoryResponse;

  Future<void> getProductsInCategory({String? categoryId}) async {
    onLoadingProductsInCategory = true;
    update();
    try{
      var response = await NetworkProvider().call(path: "/products/products-in-category/$categoryId", method: RequestMethod.get,);
      productsInCategoryResponse = ProductsInCategoryResponse.fromJson(response!.data);
      onLoadingProductsInCategory = false;
      update();
    }on DioError catch (err) {
      onLoadingProductsInCategoryHasError = true;
      final errorMessage = Future.error(ApiError.fromDio(err));
      update();
      throw errorMessage;
    } catch (err) {
      log(err.toString());
      onLoadingProductsInCategoryHasError = true;
      update();
      throw err.toString();
    }
  }

  bool? isLoadingReview;
  bool? isLoadingReviewHasError;
  ReviewResponse? reviewResponse;

  Future<void> getReview({required int shopId}) async {
    isLoadingReview = true;
    update();
    try{
      var response = await NetworkProvider().call(path: "/reviews/vendor/$shopId", method: RequestMethod.get,);
      reviewResponse = ReviewResponse.fromJson(response!.data);
      log("This is the lenght of review ${reviewResponse?.data?.length}");
      isLoadingReview = false;
      update();
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      isLoadingReview = false;
      isLoadingReviewHasError = true;
      update();
      throw errorMessage;
    } catch (err) {
      isLoadingReview = false;
      isLoadingReviewHasError = true;
      update();
      throw err.toString();
    }
  }

  @override
  void onInit() {

    super.onInit();
  }
}
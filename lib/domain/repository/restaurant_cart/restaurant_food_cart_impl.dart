import 'package:dexter_mobile/app/shared/constants/http_status.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/core/use_cases/use_cases.dart';
import 'package:dexter_mobile/datas/model/shop_response/cart_response.dart';
import 'package:dexter_mobile/datas/model/shop_response/decrement_cart_item_response.dart';
import 'package:dexter_mobile/datas/model/shop_response/delete_cart_item_response.dart';
import 'package:dexter_mobile/datas/model/shop_response/increment_cart_item_response.dart';
import 'package:dexter_mobile/datas/repository/dashboard_repository/restaurant_food_cart_respository.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_data_state.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


class GetRestaurantFoodCartImpl implements noParamUseCases<DataState<CartResponse>> {
  final RestaurantFoodCartRepository _restaurantFoodCartRepository;

  GetRestaurantFoodCartImpl(this._restaurantFoodCartRepository);

  Future<DataState<CartResponse>> noParamCall() async{
    try {
      final response = await _restaurantFoodCartRepository.getRestaurantFoodCart();
      if (response!.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {
        return DataSuccess(CartResponse.fromJson(response.data!));
      }
      return DataFailed(response.statusMessage);
    } on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      return DataFailed(err.response?.data[Strings.error] ?? errorMessage);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return DataFailed(err.toString());
    }
  }
}


class AddFoodToCartImpl implements useCase<DataState<IncrementCartItemResponse>, AddFoodToCartParam> {
  final RestaurantFoodCartRepository _restaurantFoodCartRepository;

  AddFoodToCartImpl(this._restaurantFoodCartRepository);

  @override
  Future<DataState<IncrementCartItemResponse>> execute({required AddFoodToCartParam params}) async{
    try {
      final response = await _restaurantFoodCartRepository.incrementOrAddItemInCart(id: params.id!);
      if (response!.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {
        return DataSuccess(IncrementCartItemResponse.fromJson(response.data));
      }
      return DataFailed(response.statusMessage);
    } on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      return DataFailed(err.response?.data[Strings.error] ?? errorMessage);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return DataFailed(err.toString());
    }
  }
}

class AddFoodToCartParam{
  final String? id;
  AddFoodToCartParam(this.id);
}



class RemoveFoodFromCartImpl implements useCase<DataState<DeleteCartItemResponse>, RemoveFoodFromCartParam> {
  final RestaurantFoodCartRepository _restaurantFoodCartRepository;

  RemoveFoodFromCartImpl(this._restaurantFoodCartRepository);

  @override
  Future<DataState<DeleteCartItemResponse>> execute({required RemoveFoodFromCartParam params}) async{
    try {
      final response = await _restaurantFoodCartRepository.removeRestaurantFoodFromCart(id: params.id!,);
      if (response!.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {
        return DataSuccess(DeleteCartItemResponse.fromJson(response.data));
      }
      return DataFailed(response.statusMessage);
    } on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      return DataFailed(err.response?.data[Strings.error] ?? errorMessage);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return DataFailed(err.toString());
    }
  }
}

class RemoveFoodFromCartParam{
  final String? id;
  RemoveFoodFromCartParam(this.id,);
}

class ReduceFoodQuantityFromCartImpl implements useCase<DataState<DecrementCartItemResponse>, ReduceFoodQuantityFromCartParam> {
  final RestaurantFoodCartRepository _restaurantFoodCartRepository;

  ReduceFoodQuantityFromCartImpl(this._restaurantFoodCartRepository);

  @override
  Future<DataState<DecrementCartItemResponse>> execute({required ReduceFoodQuantityFromCartParam params}) async{
    try {
      final response = await _restaurantFoodCartRepository.decrementItemQuantityInCart(id: params.id!,);
      if (response!.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {
        return DataSuccess(DecrementCartItemResponse.fromJson(response.data!));
      }
      return DataFailed(response.statusMessage);
    } on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      return DataFailed(err.response?.data[Strings.error] ?? errorMessage);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return DataFailed(err.toString());
    }
  }
}

class ReduceFoodQuantityFromCartParam{
  final String? id;
  ReduceFoodQuantityFromCartParam(this.id,);
}



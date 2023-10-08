import 'package:dexter_mobile/app/shared/constants/http_status.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/core/use_cases/use_cases.dart';
import 'package:dexter_mobile/datas/model/shop_response/shop_response.dart';
import 'package:dexter_mobile/datas/repository/dashboard_repository/restaurant_repository.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_data_state.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


class RestaurantRepositoryImpl implements useCase<DataState<ShopsAroundYouResponse>, ShopsAroundYouResponseParam> {
  final RestaurantRepository _restaurantRepository;

  RestaurantRepositoryImpl(this._restaurantRepository);

  Future<DataState<ShopsAroundYouResponse>> execute({required ShopsAroundYouResponseParam params}) async{
    try {
      final response = await _restaurantRepository.getShop(serviceId: params.serviceId!, longitude: params.longitude!, latitude: params.latitude!);
      if (response!.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {;
      return DataSuccess(ShopsAroundYouResponse.fromJson(response.data));
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

class ShopsAroundYouResponseParam{
  final String? serviceId;
  final double? longitude;
  final double? latitude;
  ShopsAroundYouResponseParam(this.longitude, this.latitude, this.serviceId);
}
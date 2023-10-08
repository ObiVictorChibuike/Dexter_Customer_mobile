import 'package:dexter_mobile/app/shared/constants/http_status.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/core/use_cases/use_cases.dart';
import 'package:dexter_mobile/datas/model/location_and_address/add_address_response.dart';
import 'package:dexter_mobile/datas/model/location_and_address/get_address_response.dart';
import 'package:dexter_mobile/datas/repository/dashboard_repository/address_and_location_repository.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_data_state.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class GetAddressImpl implements  useCase<DataState<GetAddressResponse>, GetAddressParam> {
  final AddressAndLocationRepository _addressAndLocationRepository;

  GetAddressImpl(this._addressAndLocationRepository);

  @override
  Future<DataState<GetAddressResponse>> execute({required GetAddressParam params}) async{
    try {
      final response = await _addressAndLocationRepository.getAddress(id: params.id!,);
      if (response!.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {
      return DataSuccess(GetAddressResponse.fromJson(response.data!));
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

class GetAddressParam{
  final String? id;
  GetAddressParam(this.id);
}


class AddAddressImpl implements useCase<DataState<AddAddressResponse>, AddAddressParam> {
  final AddressAndLocationRepository _addressAndLocationRepository;

  AddAddressImpl(this._addressAndLocationRepository);

  @override
  Future<DataState<AddAddressResponse>> execute({required AddAddressParam params}) async{
    try {
      final response = await _addressAndLocationRepository.addAddress(address: params.address!);
      if (response!.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {
        return DataSuccess(AddAddressResponse.fromJson(response.data));
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

class AddAddressParam{
  final String? address;
  AddAddressParam(this.address);
}

class RemoveAddressImpl implements useCase<DataState<Response>, RemoveAddressParam> {
  final AddressAndLocationRepository _addressAndLocationRepository;

  RemoveAddressImpl(this._addressAndLocationRepository);

  @override
  Future<DataState<Response>> execute({required RemoveAddressParam params}) async{
    try {
      final response = await _addressAndLocationRepository.removeAddress(id: params.id!,);
      if (response!.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {
        return DataSuccess(response.data);
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

class RemoveAddressParam{
  final String? id;
  RemoveAddressParam(this.id,);
}
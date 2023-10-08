import 'package:dexter_mobile/app/shared/constants/http_status.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/core/use_cases/use_cases.dart';
import 'package:dexter_mobile/datas/repository/user_repository/user_repository.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_data_state.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

//
// class UserRepositoryImpl implements noParamUseCases<DataState<AuthUserResponse>> {
//   final UserRepository _userRepository;
//
//   UserRepositoryImpl(this._userRepository);

  // Future<DataState<AuthUserResponse>> noParamCall() async{
  //   try {
  //     final response = await _userRepository.getUser();
  //     if (response!.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {;
  //     return DataSuccess(AuthUserResponse.fromJson(response.data));
  //     }
  //     return DataFailed(response.statusMessage);
  //   } on DioError catch (err) {
  //     final errorMessage = Future.error(ApiError.fromDio(err));
  //     if (kDebugMode) {
  //       print(errorMessage);
  //     }
  //     return DataFailed(err.response?.data[Strings.error] ?? errorMessage);
  //   } catch (err) {
  //     if (kDebugMode) {
  //       print(err);
  //     }
  //     return DataFailed(err.toString());
  //   }
  // }
// }
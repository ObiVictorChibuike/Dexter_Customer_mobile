import 'dart:convert';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/app_config.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dio/dio.dart';


class UserServices{
  Future<Response?> getUser() async {
    final response = await NetworkProvider().call(path: AppConfig.user, method: RequestMethod.get,);
    return response;
  }
  Future<Response?> updateUser({required String email, required String firstName, required String lastName,}) async {
    var postBody = jsonEncode({
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
    });
    final response = await NetworkProvider().call(path: AppConfig.updateUser, method: RequestMethod.put, body: postBody);
    return response;
  }

  Future<Response?> sendUserFcmToken({required String fcmToken}) async {
    var postBody = jsonEncode({
      "token": fcmToken,
      "type": "notification"
    });
    final response = await NetworkProvider().call(path: "/api/update-fcm-token", method: RequestMethod.put, body: postBody);
    return response;
  }
}
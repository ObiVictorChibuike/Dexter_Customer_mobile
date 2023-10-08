import 'package:dexter_mobile/datas/services/user_services/user_services.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final UserServices _userServices;
  UserRepository(this._userServices);
  Future<Response?> getUser() => _userServices.getUser();
  Future<Response?> updateUser({required String email, required String firstName, required String lastName})
  => _userServices.updateUser(email: email, firstName: firstName, lastName: lastName,);
  Future<Response?> sendUserFcmToken({required String fcmToken,})
  => _userServices.sendUserFcmToken(fcmToken: fcmToken);

}
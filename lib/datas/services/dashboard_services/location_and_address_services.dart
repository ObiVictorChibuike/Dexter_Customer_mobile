import 'dart:convert';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/app_config.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dio/dio.dart';

class LocationAndAddressServices{
  Future<Response?> getAddress({required String id}) async {
    final response = await NetworkProvider().call(path: "/api/address/$id", method: RequestMethod.get,);
    return response;
  }
  Future<Response?> addAddress({required String address}) async {
    var postBody = jsonEncode({
      "address":  address,
    });
    final response = await NetworkProvider().call(path: "/api/address/store", method: RequestMethod.post, body: postBody);
    return response;
  }
  Future<Response?> removeAddress({required String id}) async {
    final response = await NetworkProvider().call(path: "/api/address/remove-address/$id", method: RequestMethod.delete,);
    return response;
  }
}
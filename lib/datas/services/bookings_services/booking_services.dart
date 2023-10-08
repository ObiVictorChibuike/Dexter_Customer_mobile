import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dio/dio.dart';

class BookingServices{
  Future<Response?> getActiveRequest() async {
    final response = await NetworkProvider().call(path: "/api/order/pending", method: RequestMethod.get,);
    return response;
  }
  Future<Response?> getCompletedRequest() async {
    final response = await NetworkProvider().call(path: "/api/vendor/order/active", method: RequestMethod.get,);
    return response;
  }
  Future<Response?> getPendingRequest() async {
    final response = await NetworkProvider().call(path: "/api/order/completed", method: RequestMethod.get,);
    return response;
  }
}
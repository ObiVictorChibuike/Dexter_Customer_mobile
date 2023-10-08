import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/app_config.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dio/dio.dart';


class RestaurantServices{
  Future<Response?> getShop({required String serviceId, required double longitude, required double latitude}) async {
    final response = await NetworkProvider().call(path: "/services/$serviceId/around?latitude=$latitude&longitude=$longitude", method: RequestMethod.get,);
    return response;
  }

  Future<Response?> getFoodInRestaurants({required String id}) async {
    final response = await NetworkProvider().call(path: "/products/products-of-shop/$id", method: RequestMethod.get,);
    return response;
  }
}
import 'package:dexter_mobile/datas/services/dashboard_services/restaurant_services.dart';
import 'package:dio/dio.dart';

class RestaurantRepository {
  final RestaurantServices _restaurantServices;
  RestaurantRepository(this._restaurantServices);
  Future<Response?> getShop({required String serviceId, required double longitude, required double latitude}) => _restaurantServices.getShop(serviceId: serviceId, latitude: latitude, longitude: longitude);
  Future<Response?> getFoodInRestaurants({required String id}) => _restaurantServices.getFoodInRestaurants(id: id);
}
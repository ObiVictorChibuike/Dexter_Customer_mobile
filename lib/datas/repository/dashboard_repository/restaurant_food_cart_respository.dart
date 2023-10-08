import 'package:dexter_mobile/datas/services/dashboard_services/restaurant_food_cart_services.dart';
import 'package:dio/dio.dart';

class RestaurantFoodCartRepository {
  final RestaurantFoodCartService _restaurantFoodCartService;
  RestaurantFoodCartRepository(this._restaurantFoodCartService);
  Future<Response?> getRestaurantFoodCart() => _restaurantFoodCartService.getRestaurantFoodCart();
  Future<Response?> incrementOrAddItemInCart({required String id}) => _restaurantFoodCartService.incrementOrAddItemInCart(id: id);
  Future<Response?> removeRestaurantFoodFromCart({required String id}) => _restaurantFoodCartService.removeRestaurantFoodFromCart(id: id);
  Future<Response?> decrementItemQuantityInCart({required String id}) => _restaurantFoodCartService.decrementItemQuantityInCart(id: id);
}
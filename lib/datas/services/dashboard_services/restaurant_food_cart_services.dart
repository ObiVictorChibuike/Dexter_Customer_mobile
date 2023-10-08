import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dio/dio.dart';

class RestaurantFoodCartService{
  Future<Response?> getRestaurantFoodCart() async {
    final response = await NetworkProvider().call(path: "/api/cart/my-cart", method: RequestMethod.get,);
    return response;
  }
  Future<Response?> removeRestaurantFoodFromCart({required String id}) async {
    final response = await NetworkProvider().call(path: "/api/cart/delete-from-cart/$id", method: RequestMethod.delete,);
    return response;
  }
  Future<Response?> decrementItemQuantityInCart({required String id}) async {
    final response = await NetworkProvider().call(path: "/api/cart/reduce-from-cart/$id", method: RequestMethod.post,);
    return response;
  }
  Future<Response?> incrementOrAddItemInCart({required String id}) async {
    final response = await NetworkProvider().call(path: "/api/cart/add-to-cart/$id", method: RequestMethod.post,);
    return response;
  }
}
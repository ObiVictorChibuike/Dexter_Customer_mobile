import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dio/dio.dart';

class ShopServices{
  Future<Response?> getProductsInShop({required String shopId}) async {
    final response = await NetworkProvider().call(path: "/api/products/products-of-shop/$shopId", method: RequestMethod.get,);
    return response;
  }
}
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/app_config.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dio/dio.dart';

class VendorServices{
  Future<Response?> getTopRatedVendors() async {
    final response = await NetworkProvider().call(path: AppConfig.topRatedVendor, method: RequestMethod.get,);
    return response;
  }
  Future<Response?> getAllProductCategory({required String shopId}) async {
    final response = await NetworkProvider().call(path: "/api/categories/categories-in-shop/$shopId", method: RequestMethod.get,);
    return response;
  }
  Future<Response?> getProductInCategory({required String categoryId}) async {
    final response = await NetworkProvider().call(path: "/api/products/products-in-category/$categoryId", method: RequestMethod.get,);
    return response;
  }
}
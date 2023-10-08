import 'package:dexter_mobile/datas/services/dashboard_services/vendor_services.dart';
import 'package:dio/dio.dart';

class VendorRepository {
  final VendorServices _vendorServices;
  VendorRepository(this._vendorServices);
  Future<Response?> getTopRatedVendors() => _vendorServices.getTopRatedVendors();
  Future<Response?> getAllProductCategory({required String shopId}) => _vendorServices.getAllProductCategory(shopId: shopId);
  Future<Response?> getProductInCategory({required String categoryId}) => _vendorServices.getProductInCategory(categoryId: categoryId);
}
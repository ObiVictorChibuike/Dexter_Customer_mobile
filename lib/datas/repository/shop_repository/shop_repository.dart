import 'package:dexter_mobile/datas/services/shop_services/shop_services.dart';
import 'package:dio/dio.dart';

class ShopRepository{
  final ShopServices _shopServices;
  ShopRepository(this._shopServices);
  Future<Response?> getProductsInShop({required String shopId}) => _shopServices.getProductsInShop(shopId: shopId);
}
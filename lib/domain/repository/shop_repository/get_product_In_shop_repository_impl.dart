import 'package:dexter_mobile/app/shared/constants/http_status.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/core/use_cases/use_cases.dart';
import 'package:dexter_mobile/datas/model/shop_response/product_in_shop_response.dart';
import 'package:dexter_mobile/datas/repository/shop_repository/shop_repository.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_data_state.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class GetAllProductInShopsImpl implements useCase<DataState<ProductsInShop>, GetAllProductInShopParam> {
  final ShopRepository _shopRepository;

  GetAllProductInShopsImpl(this._shopRepository);

  @override
  Future<DataState<ProductsInShop>> execute({required GetAllProductInShopParam params}) async{
    try {
      final response = await _shopRepository.getProductsInShop(shopId: params.shopId!,);
      if (response!.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {
        return DataSuccess(ProductsInShop.fromJson(response.data));
      }
      return DataFailed(response.statusMessage);
    } on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      return DataFailed(err.response?.data[Strings.error] ?? errorMessage);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return DataFailed(err.toString());
    }
  }

}

class GetAllProductInShopParam{
  final String? shopId;
  GetAllProductInShopParam(this.shopId,);
}
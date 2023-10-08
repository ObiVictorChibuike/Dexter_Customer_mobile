

import 'dart:developer';

import 'package:dexter_mobile/core/state/view_state.dart';
import 'package:dexter_mobile/datas/model/shop_response/product_in_shop_response.dart';
import 'package:dexter_mobile/datas/repository/shop_repository/shop_repository.dart';
import 'package:dexter_mobile/datas/services/shop_services/shop_services.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_data_state.dart';
import 'package:dexter_mobile/domain/repository/shop_repository/get_product_In_shop_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ShopProductController extends GetxController{
  final _getProductsInShop = Get.put(GetAllProductInShopsImpl(ShopRepository(ShopServices())));
  ViewState<ProductsInShop> productsInShopViewState = ViewState(state: ResponseState.EMPTY);

  void _setProductsInShopState(ViewState<ProductsInShop> productsInShopViewState) {
    this.productsInShopViewState = productsInShopViewState;
  }
  List<Products>? productsInShop;
  String? errorMessage;

  Future<void> onGetAllProductsInShop({required String shopId})async{
    _setProductsInShopState(ViewState.loading());
    update();
    await _getProductsInShop.execute(params: GetAllProductInShopParam(shopId)).then((value) async {
      if(value is DataSuccess || value.data != null) {
        productsInShop = value.data?.data;
        _setProductsInShopState(ViewState.complete(value.data!));
        update();
      }
      if (value is DataFailed || value.data == null) {
        log("3");
        if (kDebugMode) {
          log(value.error.toString());
        }
        errorMessage = value.error.toString();
        _setProductsInShopState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }
}
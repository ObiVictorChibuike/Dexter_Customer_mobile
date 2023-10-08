import 'package:dexter_mobile/app/shared/constants/http_status.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/core/use_cases/use_cases.dart';
import 'package:dexter_mobile/datas/model/shop_response/get_product_in_category_response.dart';
import 'package:dexter_mobile/datas/repository/dashboard_repository/vendor_respoitory.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_data_state.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class GetProductInCategoryImpl implements useCase<DataState<ProductsInCategoryResponse>, GetProductInCategoryParam> {
  final VendorRepository _vendorRepository;

  GetProductInCategoryImpl(this._vendorRepository);

  @override
  Future<DataState<ProductsInCategoryResponse>> execute({required GetProductInCategoryParam params}) async{
    try {
      final response = await _vendorRepository.getProductInCategory(categoryId: params.categoryId!,);
      if (response!.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {
        return DataSuccess(ProductsInCategoryResponse.fromJson(response.data));
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

class GetProductInCategoryParam{
  final String? categoryId;
  GetProductInCategoryParam(this.categoryId,);
}
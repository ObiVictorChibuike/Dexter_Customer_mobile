import 'dart:convert';

import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/widgets/progress_indicator.dart';
import 'package:dexter_mobile/data/address/add_address_response_model.dart';
import 'package:dexter_mobile/data/address/address_model_responsible.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/app_config.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AddressController extends GetxController{

  bool? isLoadingAddress;
  bool? isLoadingAddressHasError;
  List<Datum>? addressResponseModel = <Datum>[].obs;

  List<String> state = [
    "Abia",
    "Adamawa",
    "Akwa Ibom",
    "Anambra",
    "Bauchi",
    "Bayelsa",
    "Benue",
    "Borno",
    "CrossRiver",
    "Delta",
    "Ebonyi",
    "Edo",
    "Ekiti",
    "Enugu",
    "Gombe",
    "Imo",
    "Jigawa",
    "Kaduna",
    "Kano",
    "Katsina",
    "Kebbi",
    "Kogi",
    "Kwara",
    "Lagos",
    "Nasarawa",
    "Niger",
    "Ogun",
    "Ondo",
    "Osun",
    "Oyo",
    "Plateau",
    "Rivers",
    "Sokoto",
    "Taraba",
    "Yobe",
    "Zamfara",
    "Abuja FCT"
  ];
  List<String> country = [
    "Nigeria",
  ];
  Future<void> getUserAddress()async{
    isLoadingAddress = true;
    isLoadingAddressHasError = false;
    addressResponseModel = null;
    update();
    try{
      final response = await NetworkProvider().call(path: "/addresses", method: RequestMethod.get);
      addressResponseModel = AddressResponseModel.fromJson(response!.data).data;
      isLoadingAddress = false;
      isLoadingAddressHasError = false;
      update();
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      isLoadingAddress = false;
      isLoadingAddressHasError = true;
      update();
      throw errorMessage;
    } catch (err) {
      isLoadingAddress = false;
      isLoadingAddressHasError = true;
      update();
      throw err.toString();
    }
  }

  Future<void> getUserAddressWithoutLoader()async{
    update();
    try{
      final response = await NetworkProvider().call(path: "/addresses", method: RequestMethod.get);
      addressResponseModel = AddressResponseModel.fromJson(response!.data).data;
      update();
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      update();
      throw errorMessage;
    } catch (err) {
      update();
      throw err.toString();
    }
  }

  Future<void> editAddress({required String street,required String city,required String state,required String country, required String addressId})async{
    progressIndicator(Get.context!);
    try{
      var postBody = jsonEncode({
        "street":  street,
        "city": city,
        "state": state,
        "country": country,
      });
      final response = await NetworkProvider().call(path: "/addresses/$addressId", method: RequestMethod.post, body: postBody);
      final data = AddAddressResponseModel.fromJson(response!.data);
      update();
      await getUserAddressWithoutLoader().then((value){
        Get.back();
        update();
        Get.snackbar("Success", data.message ?? "Withdrawal Successful", colorText: white, backgroundColor: greenPea);
        update();
      });
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error", err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Something Went Wrong", err.toString(), colorText: white, backgroundColor: persianRed);
      update();
      throw err.toString();
    }
  }

  Future<void> addAddress({required String street,required String city,required String state,required String country })async{
    progressIndicator(Get.context!);
    try{
      var postBody = jsonEncode({
        "street":  street,
        "city": city,
        "state": state,
        "country": country,
      });
      final response = await NetworkProvider().call(path: "/addresses", method: RequestMethod.post, body: postBody);
      final data = AddAddressResponseModel.fromJson(response!.data);
      update();
      await getUserAddressWithoutLoader().then((value){
        Get.back();
        update();
        Get.snackbar("Success", data.message ?? "Withdrawal Successful", colorText: white, backgroundColor: greenPea);
        update();
      });
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error", err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Something Went Wrong", err.toString(), colorText: white, backgroundColor: persianRed);
      update();
      throw err.toString();
    }
  }

  @override
  void onInit() {
    getUserAddressWithoutLoader();
    super.onInit();
  }

// Future<void> deleteAddressAccount({required String bankAccountId})async{
  //   try{
  //     final response = await NetworkProvider().call(path: "/vendor/bank-accounts/$bankAccountId", method: RequestMethod.delete, context: Get.context);
  //     final data = DeleteBankAccountResponse.fromJson(response!.data);
  //     await getAllBankAccountNoState().then((value){
  //       Get.back();
  //       Get.snackbar("Success", data.message ?? "Account Successfully Deleted", backgroundColor: greenPea, colorText: white);
  //       update();
  //     });
  //   }on DioError catch (err) {
  //     final errorMessage = Future.error(ApiError.fromDio(err));
  //     Get.back();
  //     throw errorMessage;
  //   } catch (err) {
  //     Get.back();
  //     throw err.toString();
  //   }
  // }
}
import 'dart:convert';

import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/widgets/custom_snack.dart';
import 'package:dexter_mobile/data/booking/create_booking_model_response.dart';
import 'package:dexter_mobile/data/business_services/business_by_services_response_model.dart';
import 'package:dexter_mobile/data/business_services/business_details_model_response.dart';
import 'package:dexter_mobile/data/payment/paywithpaystack_response_model.dart';
import 'package:dexter_mobile/data/success/success_response_model.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dexter_mobile/presentation/customer/widget/order_and_booking_succcess_page.dart';
import 'package:dexter_mobile/presentation/customer/widget/progress_indicator.dart';
import 'package:dexter_mobile/presentation/message/controller/contact_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class BookableServicesController extends GetxController{
  BusinessByServicesResponse? businessByServicesResponse;
  bool? businessByServicesLoadingState;
  bool? businessByServicesErrorState;
  Future<void> getBusinessByServices({required String serviceId})async{
    businessByServicesLoadingState = true;
    businessByServicesErrorState = false;
    update();
    try{
      final response = await NetworkProvider().call(path: "/services/$serviceId/businesses", method: RequestMethod.get);
      businessByServicesResponse = BusinessByServicesResponse.fromJson(response!.data);
      businessByServicesLoadingState = false;
      businessByServicesErrorState = false;
      update();
    }on DioError catch (err) {
      businessByServicesLoadingState = false;
      businessByServicesErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      throw errorMessage;
    } catch (err) {
      businessByServicesLoadingState = false;
      businessByServicesErrorState = true;
      update();
      throw err.toString();
    }
  }

  GetBusinessDetailsResponseModel? getBusinessDetailsResponseModel;
  bool? businessDetailsLoadingState;
  bool? businessDetailsErrorState;
  Future<void> getBusinessDetailsByServices({required String businessId})async{
    final _controller = Get.put(ContactController());
    businessDetailsLoadingState = true;
    businessDetailsErrorState = false;
    try{
      final response = await NetworkProvider().call(path: "/businesses/$businessId", method: RequestMethod.get);
      getBusinessDetailsResponseModel = GetBusinessDetailsResponseModel.fromJson(response!.data);
      _controller.asyncLoadSingleUserData(vendorId: getBusinessDetailsResponseModel!.data!.vendorId.toString());
      businessDetailsLoadingState = false;
      businessDetailsErrorState = false;
      update();
    }on DioError catch (err) {
      businessDetailsLoadingState = false;
      businessDetailsErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.response?.data['message'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      businessDetailsLoadingState = false;
      businessDetailsErrorState = true;
      update();
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.toString());
      throw err.toString();
    }
  }

  List<XFile>? imageFiles;
  final ImagePicker imgPicker = ImagePicker();
  final dateOfAppointment = TextEditingController();
  String? selectedItems;
  String? selectedPeriod;
  final otherItemsController = TextEditingController();
  final messageController = TextEditingController();

  void onUploadImage() async {
    try {
      final pickedFile = await imgPicker.pickMultiImage();
      imageFiles = pickedFile;
     update();
    } catch (e) {
      final pickImageError = e;
      update();
    }
  }

  List<String> item = [
    "AC Unit",
    "Fridge",
    "Washing Machine",
    "Gas Cooker",
    "Television",
    "Power plant",
    "Electric Cooker",
  ];

  List<String> period = [
    "Morning",
    "Afternoon",
    "Evening",
  ];

  Future<void> createBooking({required String businessId, required String addressId, required String scheduleDate, required String notes})async{
    progressIndicator(Get.context);
    try{
      var postBody = jsonEncode({
        "business_id":  businessId,
        "address_id": addressId,
        "scheduled_date": scheduleDate,
        "notes": notes
      });
      final response = await NetworkProvider().call(path: "/bookings", method: RequestMethod.post, body: postBody);
      final data = CreateBookingResponseModel.fromJson(response!.data);
      Get.offAll(()=> BookingAndOrderSuccessPage(title: data.message ?? 'Success',
        body: 'Schedule Successful. Kindly follow up the progress in the booking section. Thank you for choosing Dexter',));
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error",err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }

  Future<void> payWithPayStack({required String bookingId})async{
    progressIndicator(Get.context);
    try{
      final response = await NetworkProvider().call(path: "/bookings/$bookingId/pay", method: RequestMethod.post);
      final data = PayWithPayStackResponseModel.fromJson(response!.data);
      Get.offAll(()=> BookingAndOrderSuccessPage(title: data.message ?? 'Success',
        body: 'You checkout is Successful. Kindly follow can follow up the progress in the booking section',));
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error",err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }

  Future<void> payOnDelivery({required String bookingId})async{
    progressIndicator(Get.context);
    try{
      final response = await NetworkProvider().call(path: "/bookings/$bookingId/pay", method: RequestMethod.post);
      final data = SuccessResponseModel.fromJson(response!.data);
      Get.offAll(()=> BookingAndOrderSuccessPage(title: data.message ?? 'Success',
        body: 'You checkout is Successful. Kindly follow can follow up the progress in the booking section of the app thank you',));
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error",err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }

  Future<void> cancelBooking({required String bookingId})async{
    progressIndicator(Get.context);
    try{
      final response = await NetworkProvider().call(path: "/bookings/$bookingId/cancel", method: RequestMethod.post,);
      final data = SuccessResponseModel.fromJson(response!.data);
      Get.back();
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error",err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }
}
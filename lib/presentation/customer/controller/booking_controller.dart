import 'dart:convert';
import 'dart:developer';

import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/data/paystack_payment_response_model/paystack_payment_response_model.dart';
import 'package:dexter_mobile/data/success/success_response_model.dart';
import 'package:dexter_mobile/datas/model/bookings/booking_details_response.dart';
import 'package:dexter_mobile/datas/model/bookings/bookings_response_model.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dexter_mobile/presentation/customer/widget/progress_indicator.dart';
import 'package:dexter_mobile/presentation/customer/widget/web_view.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class BookingController extends GetxController{
  List<Bookings>? pendingBookingsResponseModel = <Bookings>[].obs;
  bool? getPendingBookingLoadingState;
  bool? getPendingBookingErrorState;


  Future<void> getPendingBookings()async{
    getPendingBookingLoadingState = true;
    getPendingBookingErrorState = false;
    pendingBookingsResponseModel = null;
    // update();
    try{
      final response = await NetworkProvider().call(path: "/bookings?status=pending", method: RequestMethod.get);
      pendingBookingsResponseModel = BookingResponseModel.fromJson(response!.data).data;
      getPendingBookingLoadingState = false;
      getPendingBookingErrorState = false;
      log("done");
      update();
    }on DioError catch (err) {
      getPendingBookingLoadingState = false;
      getPendingBookingErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.response?.data['message'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      getPendingBookingLoadingState = false;
      getPendingBookingErrorState = true;
      update();
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.toString());
      throw err.toString();
    }
  }

  List<Bookings>? processingBookingsResponseModel = <Bookings>[].obs;
  bool? getProcessingBookingLoadingState;
  bool? getProcessingBookingErrorState;
  Future<void> getFulfilledBookings()async{
    getProcessingBookingLoadingState = true;
    getProcessingBookingErrorState = false;
    processingBookingsResponseModel = null;
    // update();
    try{
      final response = await NetworkProvider().call(path: "/bookings?status=fulfilled", method: RequestMethod.get);
      processingBookingsResponseModel = BookingResponseModel.fromJson(response!.data).data;
      getProcessingBookingLoadingState = false;
      getProcessingBookingErrorState = false;
      update();
    }on DioError catch (err) {
      getProcessingBookingLoadingState = false;
      getProcessingBookingErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.response?.data['message'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      getProcessingBookingLoadingState = false;
      getProcessingBookingErrorState = true;
      update();
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.toString());
      throw err.toString();
    }
  }

  List<Bookings>? completedBookingsResponseModel = <Bookings>[].obs;
  bool? getCompletedBookingLoadingState;
  bool? getCompletedBookingErrorState;
  Future<void> getCompletedBookings()async{
    getCompletedBookingLoadingState = true;
    getCompletedBookingErrorState = false;
    completedBookingsResponseModel = null;
    // update();
    try{
      final response = await NetworkProvider().call(path: "/bookings?status=completed", method: RequestMethod.get);
      completedBookingsResponseModel = BookingResponseModel.fromJson(response!.data).data;
      getCompletedBookingLoadingState = false;
      getCompletedBookingErrorState = false;
      update();
    }on DioError catch (err) {
      getCompletedBookingLoadingState = false;
      getCompletedBookingErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.response?.data['message'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      getCompletedBookingLoadingState = false;
      getCompletedBookingErrorState = true;
      update();
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.toString());
      throw err.toString();
    }
  }

  List<Bookings>? cancelledBookingsResponseModel = <Bookings>[].obs;
  bool? getCanceledBookingLoadingState;
  bool? getCanceledBookingErrorState;
  Future<void> getCanceledBookings()async{
    getCanceledBookingLoadingState = true;
    getCanceledBookingErrorState = false;
    cancelledBookingsResponseModel = null;
    // update();
    try{
      final response = await NetworkProvider().call(path: "/bookings?status=cancelled", method: RequestMethod.get);
      cancelledBookingsResponseModel = BookingResponseModel.fromJson(response!.data).data;
      getCanceledBookingLoadingState = false;
      getCanceledBookingErrorState = false;
      update();
    }on DioError catch (err) {
      getCanceledBookingLoadingState = false;
      getCanceledBookingErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.response?.data['message'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      getCanceledBookingLoadingState = false;
      getCanceledBookingErrorState = true;
      update();
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.toString());
      throw err.toString();
    }
  }


  List<Bookings>? confirmedBookingsResponseModel = <Bookings>[].obs;
  bool? getConfirmedBookingsLoadingState;
  bool? getConfirmedBookingsErrorState;
  Future<void> getConfirmedBookings()async{
    getConfirmedBookingsLoadingState = true;
    getConfirmedBookingsErrorState = false;
    confirmedBookingsResponseModel = null;
    try{
      final response = await NetworkProvider().call(path: "/bookings?status=confirmed", method: RequestMethod.get);
      confirmedBookingsResponseModel = BookingResponseModel.fromJson(response!.data).data;
      getConfirmedBookingsLoadingState = false;
      getConfirmedBookingsErrorState = false;
      update();
    }on DioError catch (err) {
      getConfirmedBookingsLoadingState = false;
      getConfirmedBookingsErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.response?.data['message'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      getConfirmedBookingsLoadingState = false;
      getConfirmedBookingsErrorState = true;
      update();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.toString());
      throw err.toString();
    }
  }


  BookingDetailsModelResponse? bookingDetailsModelResponse;
  bool? getBookingDetailsLoadingState;
  bool? getBookingDetailsErrorState;
  Future<void> getBookingDetails({required String bookingId})async{
    getBookingDetailsLoadingState = true;
    getBookingDetailsErrorState = false;
    bookingDetailsModelResponse = null;
    // update();
    try{
      final response = await NetworkProvider().call(path: "/bookings/$bookingId", method: RequestMethod.get);
      bookingDetailsModelResponse = BookingDetailsModelResponse.fromJson(response!.data);
      getBookingDetailsLoadingState = false;
      getBookingDetailsErrorState = false;
      update();
    }on DioError catch (err) {
      getBookingDetailsLoadingState = false;
      getBookingDetailsErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.response?.data['message'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      getBookingDetailsLoadingState = false;
      getBookingDetailsErrorState = true;
      update();
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.toString());
      throw err.toString();
    }
  }

  Future<void> cancelBooking({required String bookingId})async{
    progressIndicator(Get.context!);
    try{
      final response = await NetworkProvider().call(path: "/bookings/$bookingId/cancel", method: RequestMethod.delete);
      final data = SuccessResponseModel.fromJson(response!.data);
      update();
      Get.back();
      update();
      Get.snackbar("Success", data.message ?? "Your Booking has been Cancelled", colorText: white, backgroundColor: greenPea);
      update();
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

  Future<void> cashOnDelivery({required String bookingId})async{
    progressIndicator(Get.context!);
    try{
      var postBody = jsonEncode({
        "payment_method":  "cash_on_delivery.",
      });
      final response = await NetworkProvider().call(path: "/bookings/$bookingId/pay", method: RequestMethod.post, body: postBody);
      final data = SuccessResponseModel.fromJson(response!.data);
      update();
      Get.back();
      update();
      Get.snackbar("Success", data.message ?? "Booking payment initiated successfully", colorText: white, backgroundColor: greenPea);
      update();
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

  Future<void> payWithPayStack({required String bookingId})async{
    progressIndicator(Get.context!);
    try{
      var postBody = jsonEncode({
        "payment_method":  "paystack",
      });
      final response = await NetworkProvider().call(path: "/bookings/$bookingId/pay", method: RequestMethod.post, body: postBody);
      final data = PaystackPaymentModelResponse.fromJson(response!.data);
      update();
      Get.back();
      Get.to(()=>FundWalletWebView(url: data.data!.authorizationUrl!));
      // update();
      // Get.snackbar("Success", data.message ?? "Booking payment initiated successfully", colorText: white, backgroundColor: greenPea);
      // update();
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

  int currentIndex = 0;

  void changeButtonIndex(int index){
    currentIndex = index;
    update();
  }
}
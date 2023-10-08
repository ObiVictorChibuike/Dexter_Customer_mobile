import 'dart:convert';
import 'dart:developer';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/data/paystack_payment_response_model/paystack_payment_response_model.dart';
import 'package:dexter_mobile/data/success/success_response_model.dart';
import 'package:dexter_mobile/datas/model/orders/order_details_response_model.dart';
import 'package:dexter_mobile/datas/model/orders/order_response_model.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dexter_mobile/presentation/customer/widget/progress_indicator.dart';
import 'package:dexter_mobile/presentation/customer/widget/web_view.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{
  List<Orders>? pendingOrderResponseModel = <Orders>[].obs;
  bool? getPendingOrderLoadingState;
  bool? getPendingOrderErrorState;


  Future<void> getPendingOrders()async{
    getPendingOrderLoadingState = true;
    getPendingOrderErrorState = false;
    pendingOrderResponseModel = null;
    // update();
    try{
      final response = await NetworkProvider().call(path: "/orders?status=pending", method: RequestMethod.get);
      pendingOrderResponseModel = OrderResponseModel.fromJson(response!.data).data;
      getPendingOrderLoadingState = false;
      getPendingOrderErrorState = false;
      log("done");
      update();
    }on DioError catch (err) {
      getPendingOrderLoadingState = false;
      getPendingOrderErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.response?.data['message'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      getPendingOrderLoadingState = false;
      getPendingOrderErrorState = true;
      update();
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.toString());
      throw err.toString();
    }
  }


  List<Orders>? confirmedOrderResponseModel = <Orders>[].obs;
  bool? getConfirmOrderLoadingState;
  bool? getConfirmOrderErrorState;

  Future<void> getConfirmedOrder()async{
    getConfirmOrderLoadingState = true;
    getConfirmOrderErrorState = false;
    confirmedOrderResponseModel = null;
    try{
      final response = await NetworkProvider().call(path: "/orders?status=confirmed", method: RequestMethod.get);
      confirmedOrderResponseModel = OrderResponseModel.fromJson(response!.data).data;
      getConfirmOrderLoadingState = false;
      getConfirmOrderErrorState = false;
      // log("done");
      update();
    }on DioError catch (err) {
      getConfirmOrderLoadingState = false;
      getConfirmOrderErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.response?.data['message'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      getConfirmOrderLoadingState = false;
      getConfirmOrderErrorState = true;
      update();
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.toString());
      throw err.toString();
    }
  }

  List<Orders>? processingOrderResponseModel = <Orders>[].obs;
  bool? getProcessingOrderLoadingState;
  bool? getProcessingOrderErrorState;
  Future<void> getFulfilledOrder()async{
    getProcessingOrderLoadingState = true;
    getProcessingOrderErrorState = false;
    processingOrderResponseModel = null;
    // update();
    try{
      final response = await NetworkProvider().call(path: "/orders?status=fulfilled", method: RequestMethod.get);
      processingOrderResponseModel = OrderResponseModel.fromJson(response!.data).data;
      getProcessingOrderLoadingState = false;
      getProcessingOrderErrorState = false;
      update();
    }on DioError catch (err) {
      getProcessingOrderLoadingState = false;
      getProcessingOrderErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.response?.data['message'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      getProcessingOrderLoadingState = false;
      getProcessingOrderErrorState = true;
      update();
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.toString());
      throw err.toString();
    }
  }

  List<Orders>? completedOrderResponseModel = <Orders>[].obs;
  bool? getCompletedOrderLoadingState;
  bool? getCompletedOrderErrorState;
  Future<void> getCompletedOrders()async{
    getCompletedOrderLoadingState = true;
    getCompletedOrderErrorState = false;
    completedOrderResponseModel = null;
    // update();
    try{
      final response = await NetworkProvider().call(path: "/orders?status=completed", method: RequestMethod.get);
      completedOrderResponseModel = OrderResponseModel.fromJson(response!.data).data;
      getCompletedOrderLoadingState = false;
      getCompletedOrderErrorState = false;
      update();
    }on DioError catch (err) {
      getCompletedOrderLoadingState = false;
      getCompletedOrderErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.response?.data['message'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      getCompletedOrderLoadingState = false;
      getCompletedOrderErrorState = true;
      update();
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.toString());
      throw err.toString();
    }
  }

  List<Orders>? cancelledOrderResponseModel = <Orders>[].obs;
  bool? getCanceledOrdersLoadingState;
  bool? getCanceledOrderErrorState;
  Future<void> getCanceledOrders()async{
    getCanceledOrdersLoadingState = true;
    getCanceledOrderErrorState = false;
    cancelledOrderResponseModel = null;
    // update();
    try{
      final response = await NetworkProvider().call(path: "/orders?status=cancelled", method: RequestMethod.get);
      cancelledOrderResponseModel = OrderResponseModel.fromJson(response!.data).data;
      getCanceledOrdersLoadingState = false;
      getCanceledOrderErrorState = false;
      update();
    }on DioError catch (err) {
      getCanceledOrdersLoadingState = false;
      getCanceledOrderErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.response?.data['message'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      getCanceledOrdersLoadingState = false;
      getCanceledOrderErrorState = true;
      update();
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.toString());
      throw err.toString();
    }
  }


  OrderDetailsModelResponse? orderDetailsModelResponse;
  bool? getOrdersDetailsLoadingState;
  bool? getOrderDetailsErrorState;
  Future<void> getOrderDetails({required String orderId})async{
    getOrdersDetailsLoadingState = true;
    getOrderDetailsErrorState = false;
    orderDetailsModelResponse = null;
    // update();
    try{
      final response = await NetworkProvider().call(path: "/orders/$orderId", method: RequestMethod.get);
      orderDetailsModelResponse = OrderDetailsModelResponse.fromJson(response!.data);
      getOrdersDetailsLoadingState = false;
      getOrderDetailsErrorState = false;
      update();
    }on DioError catch (err) {
      getOrdersDetailsLoadingState = false;
      getOrderDetailsErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.response?.data['message'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      getOrdersDetailsLoadingState = false;
      getOrderDetailsErrorState = true;
      update();
      // Get.back();
      // showErrorSnackBar(Get.context,
      //     title: "Something Went Wrong",
      //     content: err.toString());
      throw err.toString();
    }
  }

  Future<void> cancelOrder({required String orderId})async{
    progressIndicator(Get.context!);
    try{
      final response = await NetworkProvider().call(path: "/orders/$orderId/cancel", method: RequestMethod.delete);
      final data = SuccessResponseModel.fromJson(response!.data);
      update();
        Get.back();
        update();
        Get.snackbar("Success", data.message ?? "Your Order has been Cancelled", colorText: white, backgroundColor: greenPea);
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
      final response = await NetworkProvider().call(path: "/orders/$bookingId/pay", method: RequestMethod.post, body: postBody);
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
      final response = await NetworkProvider().call(path: "/orders/$bookingId/pay", method: RequestMethod.post, body: postBody);
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
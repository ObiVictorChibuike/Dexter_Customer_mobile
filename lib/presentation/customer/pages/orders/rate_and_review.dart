import 'dart:convert';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_primary_button.dart';
import 'package:dexter_mobile/data/rating/rate_business_model.dart';
import 'package:dexter_mobile/data/rating/rate_product_model.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dexter_mobile/presentation/customer/widget/progress_indicator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class RateAndReview extends StatefulWidget {
  final String vendorName;
  final bool isFromBusiness;
  final String id;
  const RateAndReview({super.key, required this.vendorName, required this.isFromBusiness, required this.id});

  @override
  State<RateAndReview> createState() => _RateAndReviewState();
}

class _RateAndReviewState extends State<RateAndReview> {
  final descriptionController = TextEditingController();
  Widget _businessDescriptionForm(){
    var maxLine = 11;
    return Container(height: maxLine * 18.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(13),),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.top,
        validator: (value){
          if (value!.isEmpty) {
            return 'Kindly leave a review comment';
          }
          return null;
        },
        controller: descriptionController, textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        minLines: null,
        maxLines: null,  // If this is null, there is no limit to the number of lines, and the text container will start with enough vertical space for one line and automatically grow to accommodate additional lines as they are entered.
        expands: true,
        // maxLines: 11,
        decoration: InputDecoration(
          counterText: " ",
          hintText: "Review",
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xff868484), fontSize: 14),
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xff868484), fontSize: 14),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
          fillColor: Color(0xffEFEFF0),
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.all(13),
        ),
      ),
    );
  }

  final formKey = GlobalKey <FormState>();
  int rating = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: white, extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0.0, backgroundColor: Colors.white,
            title: Text("Rate and Review", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 20, fontWeight: FontWeight.w700),),
            leading: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xffF2F2F2), shape: BoxShape.circle),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                )),
          ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 100,),
              Text("Rate your experience with ${widget.vendorName}?", textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: black, fontSize: 27, fontWeight: FontWeight.w700),),
              const SizedBox(height: 30,),
              Align(alignment: Alignment.center,
                child: RatingBar.builder(
                  itemSize: 50,
                  initialRating: 0.0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star, size: 10,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {
                    print(value);
                    rating = value.toInt();
                  },
                ),
              ),
              const SizedBox(height: 30,),
              Text('Write review',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w400, fontSize: 14, color: black),
              ),
              const SizedBox(
                height: 8,
              ),
              _businessDescriptionForm(),
              const SizedBox(height: 100,),
              DexterPrimaryButton(
                onTap: (){
                  if(formKey.currentState!.validate()){
                    widget.isFromBusiness == true ?
                    rateBusiness(businessId: widget.id, comment: descriptionController.text, rating: rating) :
                    rateProduct(productId: widget.id, comment: descriptionController.text, rating: rating);
                  }
                },
                buttonBorder: greenPea, btnTitle: "Done",
                borderRadius: 30, titleColor: white, btnHeight: 56, btnTitleSize: 16,
              ),
              const SizedBox(height: 100,),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> rateBusiness({required String businessId, required String comment, required int rating})async{
    progressIndicator(Get.context!);
    try{
      var postBody = jsonEncode({
        "rating": rating,
        "comment":  comment,
      });
      final response = await NetworkProvider().call(path: "/businesses/$businessId/reviews", method: RequestMethod.post, body: postBody);
      final data = RateBusinessResponseModel.fromJson(response!.data);
      setState(() {});
      Get.back();
      Get.snackbar("Error", data.message ?? "", colorText: white, backgroundColor: greenPea);
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error", err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      setState(() {});
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Something Went Wrong", err.toString(), colorText: white, backgroundColor: persianRed);
      setState(() {});
      throw err.toString();
    }
  }

  Future<void> rateProduct({required String productId, required String comment, required int rating})async{
    progressIndicator(Get.context!);
    try{
      var postBody = jsonEncode({
        "rating": rating,
        "comment":  comment,
      });
      final response = await NetworkProvider().call(path: "/orders/$productId/pay", method: RequestMethod.post, body: postBody);
      final data = RateProductResponseModel.fromJson(response!.data);
      setState(() {});
      Get.back();

    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error", err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      setState(() {});
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Something Went Wrong", err.toString(), colorText: white, backgroundColor: persianRed);
      setState(() {});
      throw err.toString();
    }
  }
}

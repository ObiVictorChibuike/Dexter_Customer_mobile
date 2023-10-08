import 'dart:developer';

import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_primary_button.dart';
import 'package:dexter_mobile/app/shared/widgets/error_screen.dart';
import 'package:dexter_mobile/presentation/customer/pages/repair_services/controller/bookable_services_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/repair_services/pages/service_booking.dart';
import 'package:dexter_mobile/presentation/customer/widget/Image_view.dart';
import 'package:dexter_mobile/presentation/customer/widget/animated_column.dart';
import 'package:dexter_mobile/presentation/customer/widget/circular_loading_widget.dart';
import 'package:dexter_mobile/presentation/message/controller/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';

class BookableServicesDetails extends StatefulWidget {
  final String businessId;
  const BookableServicesDetails({Key? key, required this.businessId}) : super(key: key);

  @override
  State<BookableServicesDetails> createState() => _BookableServicesDetailsState();
}

class _BookableServicesDetailsState extends State<BookableServicesDetails> {
  final _controller = Get.find<BookableServicesController>();
  final _scrollController = ScrollController();
  final cc = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookableServicesController>(
      init: BookableServicesController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
              backgroundColor: white,
              appBar: AppBar(
                centerTitle: false, elevation: 0, backgroundColor: white, scrolledUnderElevation: 0,
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
                title: Text("Service Details", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 20, fontWeight: FontWeight.w700),),),
              body:  _controller.getBusinessDetailsResponseModel == null && _controller.businessDetailsLoadingState == true && _controller.businessDetailsErrorState == false?
              CircularLoadingWidget() : _controller.getBusinessDetailsResponseModel == null && _controller.businessDetailsLoadingState == false && _controller.businessDetailsErrorState == false?
              Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AssetPath.emptyFile, height: 120, width: 120,),
                    const SizedBox(height: 40,),
                    Text("You have no completed bookings",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray, fontSize: 14, fontWeight: FontWeight.w400),),
                  ],
                ),
              ) : _controller.getBusinessDetailsResponseModel != null && _controller.businessDetailsLoadingState == false && _controller.businessDetailsErrorState == false ?
              AnimatedColumn(padding: EdgeInsets.symmetric(horizontal: 15),
              children: [
              Container(
              height: MediaQuery.of(context).size.height / 4, width: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(image:
                  NetworkImage(_controller.getBusinessDetailsResponseModel?.data?.coverImage ?? imagePlaceHolder), fit: BoxFit.cover), borderRadius: BorderRadius.circular(14))),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_controller.getBusinessDetailsResponseModel?.data?.name ?? "", overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16,color: black, fontWeight: FontWeight.w600,),),
                    Row(
                      children: [
                        Icon(Icons.timer_outlined, color: greenPea, size: 15,),
                        const SizedBox(width: 5,),
                        Text("Open from ${_controller.getBusinessDetailsResponseModel?.data?.openingTime ?? ""}Am - ${_controller.getBusinessDetailsResponseModel?.data?.closingTime ?? ""}Pm", overflow: TextOverflow.fade,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 11,color: black, fontWeight: FontWeight.w700,),),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        RatingBar.builder(
                          itemSize: 12,
                          initialRating: _controller.getBusinessDetailsResponseModel?.data?.averageRating == null ? 0.0 : double.parse(_controller.getBusinessDetailsResponseModel?.data?.averageRating ?? "0.0"),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star, size: 10,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        _controller.getBusinessDetailsResponseModel?.data?.averageRating == null || _controller.getBusinessDetailsResponseModel?.data?.averageRating == "" ?
                        Text(
                          "Rating: ${"0.0"}",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 12, fontWeight: FontWeight.w700),
                        ) : _controller.getBusinessDetailsResponseModel!.data!.averageRating.toString().length <= 2 ?
                        Text(
                          "Rating: ${_controller.getBusinessDetailsResponseModel?.data?.averageRating ?? ""}",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 12, fontWeight: FontWeight.w700),
                        ) : _controller.getBusinessDetailsResponseModel!.data!.averageRating.toString().length > 2 ?
                        Text(
                          "Rating: ${_controller.getBusinessDetailsResponseModel?.data?.averageRating!.substring(0,3) ?? ""}",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 12, fontWeight: FontWeight.w700),
                        ) : Text(
                          "Rating: ${""}",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        if(cc.singleUserChatModel.first.id != null){
                          log(cc.singleUserChatModel.first.id.toString());
                          cc.goChat(cc.singleUserChatModel.first);
                        }
                      },
                      child: Container(
                        height: 32, width: 32,
                        decoration: BoxDecoration(color: Color(0xffD9F2EA),shape: BoxShape.circle,),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(AssetPath.message),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Location: ", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w500),),
                    Text(
                      "${_controller.getBusinessDetailsResponseModel?.data?.contactAddress?.fullAddress ?? ""}", overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w300, ),
                    ),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(alignment: Alignment.centerLeft,
                      child: RichText(text: TextSpan(text: 'Average Service Charge: ', style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 10, color: greenPea), children: [
                        TextSpan(text: "NGN ${MoneyFormatter(amount: double.parse(_controller.getBusinessDetailsResponseModel?.data?.serviceCharge ?? "0.00"),).output.nonSymbol}", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 10, color: greenPea))
                      ]),),
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                const Divider(color: greenPea,),
                Align(alignment: Alignment.centerLeft,
                  child: Text("Bio",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8,),
                Text(_controller.getBusinessDetailsResponseModel?.data?.biography ?? "",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const Divider(color: greenPea,),
                const SizedBox(height: 8,),
                Align(alignment: Alignment.centerLeft,
                    child: Text("Sample", style: Theme.of(context).textTheme.bodySmall!.
                    copyWith(color: black, fontSize: 16, fontWeight: FontWeight.w600),)),
                const SizedBox(height: 8,),
                // const Divider(color: greenPea,),
                SizedBox(
                  child: GridView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1 / 1.02, crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10,),
                    itemCount: _controller.getBusinessDetailsResponseModel?.data?.businessImages!.length,
                    itemBuilder: (_,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              ImageViewer(imageCount: _controller.getBusinessDetailsResponseModel!.data!.businessImages!.length,
                                imageUrl: _controller.getBusinessDetailsResponseModel?.data?.businessImages,
                              )));
                        },
                        child: Card(elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            // height: MediaQuery.of(context).size.height * .43,
                            width: MediaQuery.of(context).size.width * .43,
                            child: Container(
                              height: 140, width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: _controller.getBusinessDetailsResponseModel?.data?.businessImages?[index].imageUrl == null || _controller.getBusinessDetailsResponseModel?.data?.businessImages?[index].imageUrl == "" ?
                                    const NetworkImage(imagePlaceHolder) :
                                    NetworkImage(_controller.getBusinessDetailsResponseModel!.data!.businessImages![index].imageUrl!),fit: BoxFit.fill, )),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30,),
                DexterPrimaryButton(
                  onTap: (){
                    Get.to(()=> ServiceBookingScreen(getBusinessDetailsResponseModel: _controller.getBusinessDetailsResponseModel,));
                  },
                  buttonBorder: greenPea, btnTitle: "Book Service",
                  borderRadius: 30, titleColor: white, btnHeight: 53, btnTitleSize: 16,
                ),
                const SizedBox(height: 100,),
          ], )]) : controller.getBusinessDetailsResponseModel == null && controller.businessDetailsLoadingState == false && controller.businessDetailsErrorState == true ?
          ErrorScreen() : CircularLoadingWidget()));
    });
  }

  @override
  void initState() {
    _controller.getBusinessDetailsByServices(businessId: widget.businessId);
    super.initState();
  }
}

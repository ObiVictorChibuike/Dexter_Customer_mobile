import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/presentation/auth/login/controller/login_controller.dart';
import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/repair_services/pages/service_booking.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/pages/restaurants.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/pages/shops.dart';
import 'package:dexter_mobile/presentation/customer/widget/circular_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AllServicesScreen extends StatefulWidget {
  const AllServicesScreen({Key? key}) : super(key: key);

  @override
  State<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  final List<Color> circleColors = [Color(0xffD9F2EA), Color(0xffFBEEDC), Color(0xffF9DFDF), Color(0xffEDF3FF)];

  Color randomGenerator() {
    return circleColors[Random().nextInt(2)];
  }
  void underConstruction(BuildContext context) async {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // Some text
                  Center(child: Text('Still Under Construction'))
                ],
              ),
            ),
          );
        });
  }
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              centerTitle: false,
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
              elevation: 0.0, backgroundColor: white,
              title: Text("Services", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16, fontWeight: FontWeight.w600, color: black),),
            ),
            body: controller.appServicesResponse == null ||
                controller.appServicesResponse!.data!.isEmpty ||
                controller.appServicesResponse!.data == [] ?
            CircularLoadingWidget() :
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ...List.generate(controller.appServicesResponse!.data!.length, (index){
                    return GestureDetector(
                      onTap: (){
                        final serviceName = controller.appServicesResponse!.data![index].name!.toLowerCase();
                        final bookableStatus = controller.appServicesResponse!.data![index].isBookable!;
                        final serviceId = controller.appServicesResponse!.data![index].id;
                        if(serviceName == "food delivery" && bookableStatus == false){
                          Get.to(()=> Restaurants(ServiceId: serviceId.toString(), ServiceName: serviceName,));
                        }else if (serviceName != "food delivery" && bookableStatus == false){
                          Get.to(()=> Shops(ServiceId: serviceId.toString(), ServiceName: serviceName,));
                        }else if (serviceName != "food delivery" && bookableStatus == true){
                          Get.to(()=> ServiceBookingScreen());
                        }else {
                          underConstruction(context);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          width: double.maxFinite, padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xffE6E6E6)),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: controller.appServicesResponse?.data?[index].coverImage ?? imagePlaceHolder,
                                imageBuilder: (context, imageProvider) => Container(
                                  height: 50, width: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)),
                                  ),
                                ),
                                placeholder: (context, url) => CupertinoActivityIndicator(),
                                errorWidget: (context, url, error) => ClipRRect(borderRadius: BorderRadius.circular(40),
                                    child: Image.network(imagePlaceHolder, height: 50, width: 50, fit: BoxFit.cover,)),
                                // errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                              // Container(
                              //   height: 50, width: 50,
                              //   child: Image.asset(
                              //       AssetPath.plug,
                              //   ),
                              // ),
                              const SizedBox(width: 12),
                              Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.appServicesResponse!.data![index].name!,
                                    style: Theme.of(context).textTheme.bodySmall!.
                                    copyWith(fontSize: 14, fontWeight: FontWeight.w600, color: black),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 115,)
                ],
              ),
            ),
          )
      );
    });
  }
}

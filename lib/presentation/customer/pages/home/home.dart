import 'dart:async';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_primary_button.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_text_field.dart';
import 'package:dexter_mobile/app/shared/widgets/empty_screen.dart';
import 'package:dexter_mobile/app/shared/widgets/error_screen.dart';
import 'package:dexter_mobile/core/state/view_state.dart';
import 'package:dexter_mobile/domain/local/local_storage.dart';
import 'package:dexter_mobile/presentation/customer/controller/address_controller.dart';
import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/home/all_top_ratedVendor.dart';
import 'package:dexter_mobile/presentation/customer/pages/home/notification.dart';
import 'package:dexter_mobile/presentation/customer/pages/home/top_rated_vendor_detail.dart';
import 'package:dexter_mobile/presentation/customer/pages/home/vendor_type.dart';
import 'package:dexter_mobile/presentation/customer/pages/repair_services/pages/bookable_services.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/controller/product_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/pages/shop_details_and_menu.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/pages/restaurants.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/pages/shops.dart';
import 'package:dexter_mobile/presentation/customer/widget/animated_column.dart';
import 'package:dexter_mobile/presentation/customer/widget/category_type_button.dart';
import 'package:dexter_mobile/presentation/customer/widget/dashboard_shimmer_loader.dart';
import 'package:dexter_mobile/presentation/customer/widget/dexter_bottom_sheet.dart';
import 'package:dexter_mobile/presentation/customer/widget/dexter_pop_up.dart';
import 'package:dexter_mobile/presentation/customer/widget/empty_screen_widget.dart';
import 'package:dexter_mobile/presentation/customer/widget/under_construction_dilaog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'location_and_address.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController(), permanent: true);
  final addressController = Get.put(AddressController());
  final pc = Get.put(ProductController());
  @override
  void initState() {
    addressController.getUserAddressWithoutLoader();
    notificationCheckStatus();
    super.initState();
  }

  void sendFcmToken(BuildContext context)async{
      Get.back();
      Get.back();
      await homeController.sendUserFcmToken();
  }

  void deleteFcmToken(BuildContext context)async{
    Get.back();
    Get.back();
    homeController.deleteFcmToken();
  }

  Timer interval(Duration duration, func) {
    Timer function() {
      Timer timer = Timer(duration, function);
      func(timer);
      return timer;
    }
    return Timer(duration, function);
  }

  notificationCheckStatus(){
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notificationStatus = await LocalCachedData.instance.getIsEnableNotificationStatus();
      if(notificationStatus == null && context.mounted){
        interval(const Duration(minutes: 10), (timer) {
          showEnableNotificationBottomSheet(context);
          if (kDebugMode) {
            print(homeController.enableNotificationPromptCount++);
          }
          if (homeController.enableNotificationPromptCount > 1) timer.cancel();
        });
      }else{
        null;
      }
    });
  }

  void showEnableNotificationBottomSheet(BuildContext context){
    MyBottomSheet().showNonDismissibleBottomSheet(context: context, height: 320,
        children:[
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: (){
                   Get.back();
                  },
                  child: Container(
                    height: 30, width: 30, decoration: BoxDecoration(shape: BoxShape.circle, color: iron),
                    child: Center(
                      child: Icon(
                          Icons.clear, color: black, size: 23
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Image.asset(AssetPath.bell,width: 70, height: 70,),
              const SizedBox(height: 20,),
              Text("Enable Notifications?", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20, fontWeight: FontWeight.w700, color: black),),
              const SizedBox(height: 11,),
              Text("We’ll send you offers and reminders. You’ll never miss a message or an appointment.",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: black),),
              const SizedBox(height: 40,),
              DexterPrimaryButton(
                onTap: (){
                  DexterPopUp(
                      apply1: () async {
                        sendFcmToken(context);
                      },
                      apply: () {
                        deleteFcmToken(context);
                      },
                      btntext1: "Allow", btntext: "Don’t Allow",
                      context: context, title: "“Dexter” would like to send you notifications",
                      body: "Notifications may include alerts, sounds and icon badges, these can be configured in settings."
                  );
                },
                btnTitle: "Sounds good", btnTitleSize: 16, borderRadius: 35, btnHeight: 48,
                btnWidth: MediaQuery.of(context).size.width,
              )
            ],
          )
        ]);
  }

  Widget buildRestaurant(HomeController controller){
    switch (controller.viewState.state){
      case ResponseState.LOADING:
        return DashboardShimmerLoader();
      case ResponseState.ERROR:
        return const ErrorScreen();
      case ResponseState.EMPTY:
        return EmptyScreen(emptyScreenMessage: "No item found",
          icon: Lottie.asset('assets/lottie/empty.json', height: 220, width: 220),
        );
      case ResponseState.COMPLETE:
        return Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15,),
            DexterTextField(
                onTap: (){},
                filledColor: Colors.transparent,
                minLines: null, maxLines: 1, expands: false,
                hintText: "What are you looking for ?",
                prefixIcon: Padding(padding: const EdgeInsets.all(8.0), child: SvgPicture.asset(AssetPath.search, height: 20, width: 20,),)
            ),
            const SizedBox(height: 24,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Services', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),),
                GestureDetector(
                  onTap: ()=> Get.to(()=> AllServicesScreen()),
                  child: Container(color: white,
                      child: Text('See all', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w600),)),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            controller.appServicesResponse!.data!.isEmpty ? const SizedBox() :
            CategoryTypeButton(
              selected: controller.selectedIndex,
              callback: (int index) {
                final serviceName = controller.appServicesResponse!.data![index].name!.toLowerCase();
                final bookableStatus = controller.appServicesResponse!.data![index].isBookable!;
                final serviceId = controller.appServicesResponse!.data![index].id;
                if(serviceName == "food delivery" && bookableStatus == false){
                  Get.to(()=> Restaurants(ServiceId: serviceId.toString(), ServiceName: serviceName,));
                }else if (serviceName != "food delivery" && bookableStatus == false){
                  Get.to(()=> Shops(ServiceId: serviceId.toString(), ServiceName: serviceName,));
                }else if (serviceName != "food delivery" && bookableStatus == true){
                  Get.to(()=>BookableServices(serviceId: serviceId.toString(), serviceName: serviceName,));
                }else {
                  underConstruction(context);
                }
              }, category: controller.appServicesResponse!.data,),
            const SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Restaurants around you",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),),
                controller.shopsAroundYou!.isEmpty || controller.shopsAroundYou == [] ?
                Text('See all', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)) :
                GestureDetector(
                  onTap: ()=> Get.to(()=> Restaurants(ServiceId: 1.toString(), ServiceName: 'Food Delivery',)),
                  child: Text('See all', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w600),),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            controller.shopsAroundYou!.isEmpty || controller.shopsAroundYou == [] ?
            EmptyScreenWidget(message: "No Restaurant Found",
                icon: SvgPicture.asset("assets/svg/empty_restaurant.svg", height: 100, width: 100, color: greenPea,),
                height: MediaQuery.of(context).size.height/3.5) :
            CarouselSlider(
              options: CarouselOptions(
                  height: 254,autoPlayAnimationDuration: Duration(seconds: 20),
                  autoPlayInterval: Duration(seconds: 4),
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {});
                  }
              ), items: List.generate(controller.shopsAroundYou!.length, (index){
                final item = controller.shopsAroundYou![index];
              return  GestureDetector(
                onTap: (){
                  Get.to(()=> ShopDetailsAndMenu(id: controller.shopsAroundYou![index].id.toString(), name: controller.shopsAroundYou![index].name!,));
                },
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: white),
                      height: 254, width: MediaQuery.of(context).size.width / 1.1,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                            height: 140, width: double.maxFinite,
                            child: Image.network(item.coverImage ?? "", fit: BoxFit.cover,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          RatingBar.builder(
                                            itemSize: 8,
                                            initialRating: double.parse(item.averageRating ?? "0.0"),
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
                                          item.averageRating!.length <= 2 ?
                                          Text(double.parse("${item.averageRating ?? ""}").toString(),
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12,color: black, fontWeight: FontWeight.w700,),) :
                                          Text(item.averageRating?.substring(0,3) ?? "",
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12,color: black, fontWeight: FontWeight.w700,),),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Text(item.name!, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),),
                                      Text("${item.biography}", overflow: TextOverflow.ellipsis, maxLines: 2, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w400),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })
            ),
          ],
        );
    }
  }
  final _scrollController = ScrollController();

  Widget buildTopRatedVendors(HomeController controller){
    switch (controller.topRatedVendorViewState.state){
      case ResponseState.LOADING:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GridView.count(
                physics: ScrollPhysics(),
                crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: (1/0.8),
                shrinkWrap: true, crossAxisCount: 2,
                children: List.generate(4, (index){
                  return Shimmer.fromColors(
                    period: Duration(seconds: 1),
                    baseColor: Colors.grey.shade400,
                    highlightColor: Color(0xff6F6F6F)
                        .withOpacity(0.5),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: white),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      case ResponseState.ERROR:
        return const ErrorScreen();
      case ResponseState.EMPTY:
        return EmptyScreen(emptyScreenMessage: "No item found",
          icon: Image.asset(AssetPath.emptyFile, height: 220, width: 220),
        );
      case ResponseState.COMPLETE:
        return controller.topRatedVendorViewState.data!.data!.isEmpty || controller.topRatedVendorViewState.data!.data == [] ?
            EmptyScreenWidget(message: "No Top Rated Vendor Found",
                icon: SvgPicture.asset("assets/svg/empty_restaurant.svg", height: 100, width: 100, color: greenPea,),
                height: MediaQuery.of(context).size.height/3.5) :
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Rated Shops',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=> const AllTopRatedVendor());
                    },
                    child: Text('See all', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w600),),
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              SizedBox(
              height: MediaQuery.of(context).size.height/3,
              child: GridView(
                shrinkWrap: true,
                controller: _scrollController, scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 130,
                    childAspectRatio: 3 / 6,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20
                ),
                physics: BouncingScrollPhysics(),
                children: List.generate(
                controller.topRatedVendorViewState.data!.data!.length > 6 ? 6 : controller.topRatedVendorViewState.data!.data!.length, (index){
                  return GestureDetector(
                    onTap: (){
                      Get.to(()=> VendorDetail(id: controller.topRatedVendorViewState.data!.data![index].id!.toString(), name: controller.topRatedVendorViewState.data!.data![index].name!,));
                    },
                    child: Card(elevation: 3,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: white),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(10),
                                      child: Container(height: 80, width: 80,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: NetworkImage(controller.topRatedVendorViewState.data?.data?[index].coverImage ?? imagePlaceHolder), fit: BoxFit.cover)
                                        ),
                                      )),
                                  const SizedBox(width: 8,),
                                  Expanded(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(controller.topRatedVendorViewState.data!.data![index].name ?? "", overflow: TextOverflow.fade,
                                          style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14,color: black, fontWeight: FontWeight.w700,),),
                                        const SizedBox(height: 6,),
                                        Text(controller.topRatedVendorViewState.data!.data![index].biography ?? "", overflow: TextOverflow.fade, maxLines: 2,
                                          style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12,color: black, fontWeight: FontWeight.w400,),),
                                        const SizedBox(height: 6,),
                                        Row(
                                          children: [
                                            RatingBar.builder(
                                              itemSize: 12,
                                              initialRating: double.parse(controller.topRatedVendorViewState.data!.data![index].averageRating ?? "0.0"),
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
                                            Text(controller.topRatedVendorViewState.data!.data![index].averageRating?.substring(0,3) ?? "",
                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12,color: black, fontWeight: FontWeight.w700,),),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              ),
            ],
          );
    }
  }
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
        builder: (controller){
      return RefreshIndicator(
          child: SafeArea(top: false, bottom: false,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0.0, scrolledUnderElevation: 0.0,
                  backgroundColor: Colors.white, centerTitle: false,
                  title: GestureDetector(
                    onTap: () {
                      Get.to(()=> const LocationAndAddress());
                    },
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(homeController.selectedAddress == "" ? "Set Delivery Location" : "Delivery Location", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray, fontSize: 12),),
                        Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            homeController.selectedAddress == "" ? Icon(Icons.location_on, size: 18, color: greenPea,) :  const SizedBox(),
                            Expanded(
                              child: Text(homeController.selectedAddress == "" ? "Delivery Address" : homeController.selectedAddress,  maxLines: 2,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 13, fontWeight: FontWeight.w400,),),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      Get.to(()=> const LocationAndAddress());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: const Icon(Iconsax.location, color: black,),
                    ),
                  ),
                  actions: [
                    GetBuilder<HomeController>(
                        init: HomeController(),
                        builder: (controller){
                          return  Padding(
                            padding: const EdgeInsets.only(right: 2.0, bottom: 16),
                            child:      Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 18.0, top: 10),
                                  child: GestureDetector(
                                    onTap: () async {
                                      Get.to(()=> const Notifications(),);
                                    },
                                    child: Container(
                                      height: 36, width: 36,
                                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Color(0xffD9D9D9))),
                                      child: Center(child: Icon(Iconsax.notification, color: black,),
                                      ),
                                    ),
                                  ),
                                ),
                                controller.notificationItem == 0 ? const SizedBox()
                                // Positioned(top: 11, left: 2,
                                //   child: Container(height: 8, width: 8,
                                //     decoration: BoxDecoration(shape: BoxShape.circle,
                                //         border: Border.all(color: persianRed), color: persianRed),
                                //   ),
                                // )
                                    :
                                Positioned(top: 10, left: 0,
                                  child: Container(height: 18, width: 18,
                                    decoration: BoxDecoration(shape: BoxShape.circle,
                                        border: Border.all(color: persianRed), color: persianRed),
                                    child: Center(child: Text(controller.notificationItem.toString(),
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                  ],
                ),
                body: AnimatedColumn(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  children: [
                    buildRestaurant(controller),
                    buildTopRatedVendors(controller),
                  ],
                ),
              )
          ),
          onRefresh: ()async{
            controller.getSelectedAddress();
            controller.getRestaurantsAroundYou();
            controller.getTopRatedVendors();
            controller.getInAppNotification();
            controller.onInitializeLocalStorage();
          });
    });
  }
}

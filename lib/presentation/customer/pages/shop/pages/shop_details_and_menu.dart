import 'dart:developer';

import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/controller/shop_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/pages/shop_cart_page.dart';
import 'package:dexter_mobile/presentation/customer/widget/category_time_button.dart';
import 'package:dexter_mobile/presentation/customer/widget/circular_loading_widget.dart';
import 'package:dexter_mobile/presentation/customer/widget/description_widget.dart';
import 'package:dexter_mobile/presentation/customer/widget/menu_widget.dart';
import 'package:dexter_mobile/presentation/message/controller/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ShopDetailsAndMenu extends StatefulWidget {
  final String id;
  final String name;
  const ShopDetailsAndMenu({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  State<ShopDetailsAndMenu> createState() => _ShopDetailsAndMenuState();
}

class _ShopDetailsAndMenuState extends State<ShopDetailsAndMenu> {
  final pageController = PageController();
  final _controller = Get.put(ShopController());
  final cc = Get.put(ContactController());

  @override
  void initState() {
    _controller.getAShop(shopId: widget.id);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(
      init: ShopController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
        child: Scaffold(
          floatingActionButton:
          GetBuilder<ShopController>(
            init: ShopController(),
            builder: (_rsController){
            return Container(
              child: FittedBox(
                child: Stack(alignment: Alignment(1.4, -1.5),
                  children: [
                    FloatingActionButton(  // Your actual Fab
                      onPressed: () {
                        Get.to(()=>ShopCartPage(shopResponseModel: controller.shopResponseModel, shopId: widget.id,));
                      },
                      child: Icon(Icons.shopping_cart_outlined, color: white,), backgroundColor: greenPea,
                    ),
                    Container(             // This is your Badge
                      child: Center(child: Text("${_rsController.totalItemInCart}", style: TextStyle(color: Colors.white)),),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(spreadRadius: 1, blurRadius: 5, color: Colors.black.withAlpha(50))
                        ], color: tulipTree,  // This would be color of the Badge
                      ),
                    ),
                  ],
                ),
              ),
            );
          },),
            body: controller.shopLoadingState == true && controller.shopErrorState == false  ? CircularLoadingWidget() :
            NestedScrollView(
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    scrolledUnderElevation: 0.0,
                    foregroundColor: Colors.white, shadowColor: Colors.white, surfaceTintColor: Colors.white, elevation: 0.0,
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
                    expandedHeight: MediaQuery.of(context).size.height / 4, floating: false,
                    automaticallyImplyLeading: false, backgroundColor: Colors.white, pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                          height: MediaQuery.of(context).size.height / 4, width: double.maxFinite,
                          decoration: BoxDecoration(image: DecorationImage(image:
                          NetworkImage(controller.shopResponseModel!.data!.coverImage ?? imagePlaceHolder),
                            fit: BoxFit.cover,
                          ))
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 16),
                    sliver: SliverToBoxAdapter(
                      child: Column(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(controller.shopResponseModel!.data!.name ?? "", overflow: TextOverflow.fade, maxLines: 2,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16,color: black, fontWeight: FontWeight.w600,),),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.timer_outlined, color: greenPea, size: 15,),
                                  Text("Open from ${controller.shopResponseModel?.data?.openingTine  ?? ""} - ${ controller.shopResponseModel?.data?.closingTime  ?? ""}", overflow: TextOverflow.fade,
                                    style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 11,color: black, fontWeight: FontWeight.w700,),),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: Color(0xffD9F2EA),
                                        borderRadius: BorderRadius.circular(100)),
                                    child: controller.shopResponseModel!.data!.averageRating == null || controller.shopResponseModel!.data!.averageRating == "" ?
                                    Text(
                                      "Rating: ${"0.0"}",
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w600),
                                    ) : controller.shopResponseModel!.data!.averageRating.toString().length <= 2 ?
                                    Text(
                                      "Rating: ${controller.shopResponseModel!.data!.averageRating ?? ""}",
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w600),
                                    ) : controller.shopResponseModel!.data!.averageRating.toString().length > 2 ?
                                    Text(
                                      "Rating: ${controller.shopResponseModel!.data!.averageRating!.substring(0,3) ?? ""}",
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w600),
                                    ) : Text(
                                      "Rating: ${""}",
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  RatingBar.builder(
                                    itemSize: 12,
                                    initialRating: controller.shopResponseModel!.data!.averageRating == null ? 0.0 : double.parse(controller.shopResponseModel!.data!.averageRating?.substring(0,3) ?? "0.0"),
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
                          const SizedBox(height: 5,),
                          Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Location: ", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w600),),
                              const SizedBox(width: 5,),
                              Text("${controller.shopResponseModel!.data!.contactAddress?.fullAddress}",
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 5,),
                              Align(alignment: Alignment.centerLeft,
                                child: Text("About Shop",
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(height: 4,),
                              DescriptionTextWidget(text: controller.shopResponseModel!.data!.biography ?? ""),
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    sliver: SliverToBoxAdapter(
                      child: CategoryTimeButton(
                        selected: controller.selectedPageIndex,
                        callback: (int index) {
                          controller.changeIndex(index);
                          pageController.jumpToPage(index);
                        }, category: controller.categoryName,),
                    ),
                  ),
                ];
              },
              body: PageView.builder(
                controller: pageController,
                  itemCount: controller.categoryName!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: MenuWidget(),
                    );
                  }),
            ),
        ),
      );
    });
  }
}

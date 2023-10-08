import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/core/state/view_state.dart';
import 'package:dexter_mobile/presentation/customer/controller/vendor_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/controller/restaurant_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/controller/shop_cart_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class MenuCards extends StatefulWidget {
  final int index;
  final ScrollController controller;
  const MenuCards({Key? key, required this.index, required this.controller}) : super(key: key);

  @override
  State<MenuCards> createState() => _MenuCardsState();
}

class _MenuCardsState extends State<MenuCards> {
  final _controller = Get.put(RestaurantController());
  final _rsController = Get.put(RestaurantCartController());
  final vendorController = Get.put(VendorController());
  late Function updateSetState;
  @override
  void initState() {
    setState(() {
      vendorController.getProductsInCategory(categoryId: widget.index.toString());
    });
    super.initState();
  }
  final review = [
    {
      "name": "Winifred Stamm",
      "comment": "Amazing work! Makeup girl really brought my vision to life and made me feel gorgeous. Highly recommend!"
    },
    {
      "name": "Winifred Stamm",
      "comment": "Amazing work! Makeup girl really brought my vision to life and made me feel gorgeous. Highly recommend!"
    },
    {
      "name": "Winifred Stamm",
      "comment": "Amazing work! Makeup girl really brought my vision to life and made me feel gorgeous. Highly recommend!"
    },
    {
      "name": "Winifred Stamm",
      "comment": "Amazing work! Makeup girl really brought my vision to life and made me feel gorgeous. Highly recommend!"
    },
    {
      "name": "Winifred Stamm",
      "comment": "Amazing work! Makeup girl really brought my vision to life and made me feel gorgeous. Highly recommend!"
    },
    {
      "name": "Winifred Stamm",
      "comment": "Amazing work! Makeup girl really brought my vision to life and made me feel gorgeous. Highly recommend!"
    },
    {
      "name": "Winifred Stamm",
      "comment": "Amazing work! Makeup girl really brought my vision to life and made me feel gorgeous. Highly recommend!"
    },
    {
      "name": "Winifred Stamm",
      "comment": "Amazing work! Makeup girl really brought my vision to life and made me feel gorgeous. Highly recommend!"
    }
  ];
  void showRestaurantBottomSheet({required String imagePath, required String name,
    required String description, required String price, required int? foodId}){
    Get.bottomSheet(
      StatefulBuilder(builder: (context, update){
        updateSetState = update;
        final checkOutIndex = _rsController.getRestaurantFoodCartViewState.data?.data?.map((e) => e.productId).toList() ?? [];
        return Container(decoration: BoxDecoration(color: white,borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),),
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/1.8,),
          child: Column(
            children: [
              Container(height: MediaQuery.of(context).size.height / 4, width: double.maxFinite,
                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(imagePath), fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                padding: EdgeInsets.only(left: 18, right: 18, top: 20),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        GestureDetector(
                          onTap: (){
                            _controller.update();
                            Get.back();
                          },
                          child: Container(
                            height: 25, width: 25,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: white),
                            child: Center(child: Icon(Icons.clear, color: black,)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 19,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.bodyText1?.copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 14),),
                    const SizedBox(height: 5,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(description, style: Theme.of(context).textTheme.bodyText1?.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 14),)),
                        const SizedBox(width: 20,),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){

                              },
                              child: Container(
                                height: 26, width: 26,
                                decoration: BoxDecoration(color: Color(0xffE6E6E6), shape: BoxShape.circle),
                                child: Center(child: Icon(Icons.remove, color: white,size: 15)),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Text("${_controller.initialFoodPackageQuantity}", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 18),),
                            const SizedBox(width: 5,),
                            GestureDetector(
                              onTap: (){
                              },
                              child: Container(
                                height: 26, width: 26,
                                decoration: BoxDecoration(color: greenPea, shape: BoxShape.circle,),
                                child: Center(child: Icon(Icons.add, color: white, size: 15),),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 16,),
                    Text("₦ ${price}", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 16),),
                  ],
                ),
              ),
              const SizedBox(height: 60,),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  onTap: (){
                    Get.back();
                    updateSetState((){
                      // checkOutIndex.contains(foodId) ? _rsController.deleteItemInCart(id: foodId.toString(), context: context) :
                      _rsController.incrementItemInCart(id: foodId.toString());
                    });
                  },
                  child: Container(width: double.infinity, height: 50,
                    decoration: BoxDecoration(color: greenPea, borderRadius: BorderRadius.circular(30)),
                    child:_rsController.removeFromCartViewState.state == ResponseState.LOADING ?
                    Center(child:CircularProgressIndicator(color: white,)) : Center(
                      child: Text(
                        //checkOutIndex.contains(foodId) ? "Remove from chart" :
                        "Add to cart",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: white, fontWeight: FontWeight.w400, fontSize: 16),),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),),
      isScrollControlled: true, isDismissible: false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => updateSetState((){}),
      child: GetBuilder<VendorController>(
          init: VendorController(),
          builder: (controller){
            return
            Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 18,),
                controller.isLoadingReview == true ?
                    const SizedBox() :
                    controller.isLoadingReview == false && controller.reviewResponse == null || controller.reviewResponse!.data!.isEmpty ?
                        const SizedBox() :
                Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Review", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, color: Colors.black),),
                            const SizedBox(width: 2,),
                            Text("${controller.reviewResponse?.data?.length}", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, color: Color(0xff999999)),),
                          ],
                        ),
                        Text("See all", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, color: greenPea, decoration: TextDecoration.underline),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(controller.reviewResponse!.data!.length, (index){
                            final item = controller.reviewResponse?.data?[index];
                            return Container(
                              padding: EdgeInsets.all(10), margin: EdgeInsets.only(right: 20),
                              width: MediaQuery.of(context).size.width/1.5, decoration: BoxDecoration(border: Border.all(color: Color(0xff999999)), color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5,),
                                  RatingBar.builder(
                                    glowColor:  const Color(0xffF2994A),
                                    itemSize: 10,
                                    initialRating: item?.rating?.toDouble() ?? 0.0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star, size: 12,
                                      color: Color(0xffF2994A),
                                    ),
                                    onRatingUpdate: (rating) {
                                      if (kDebugMode) {
                                        print(rating);
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 10,),
                                  Text(item?.review ?? "", textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff999999), fontWeight: FontWeight.w400, fontSize: 12),)
                                ],
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                    const SizedBox(height: 15,),
                  ],
                ),
              ],
            );
          }),
    );
  }
}

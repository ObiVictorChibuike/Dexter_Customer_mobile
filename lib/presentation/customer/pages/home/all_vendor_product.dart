// import 'dart:developer';
// import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
// import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
// import 'package:dexter_mobile/presentation/customer/pages/shop/controller/restaurant_controller.dart';
// import 'package:dexter_mobile/presentation/customer/widget/category_time_button.dart';
// import 'package:dexter_mobile/presentation/customer/widget/product_pallete_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
// class AllVendorProduct extends StatefulWidget {
//   final String title;
//   final String id;
//   const AllVendorProduct({Key? key, required this.title, required this.id}) : super(key: key);
//
//   @override
//   State<AllVendorProduct> createState() => _AllVendorProductState();
// }
//
// class _AllVendorProductState extends State<AllVendorProduct> {
//   final _homeController = Get.put(HomeController());
//   final _controller = Get.put(RestaurantController());
//   final pageController = PageController();
//
//   @override
//   void initState() {
//     // _controller.selectedPageIndex = 0;
//     log("This is the id ${widget.id}");
//     _homeController.getAllProductCategory(shopId: widget.id);
//     _controller.getFoodInRestaurants(id: widget.id);
//     setState(() {});
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<RestaurantController>(
//       init: RestaurantController(),
//         builder: (controller){
//       return SafeArea(top: false, bottom: false,
//           child: Scaffold(
//               appBar: AppBar(
//                 elevation: 0.0,
//                 leading: GestureDetector(
//                     onTap: (){
//                       Get.back();
//                     },
//                     child: Icon(Icons.arrow_back_outlined, color: Colors.black,)),
//                 backgroundColor: Colors.white,
//                 title: Text("${widget.title} Products Categories", overflow: TextOverflow.fade,
//                   style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16, color: black, fontWeight: FontWeight.w600,),),
//               ),
//               body: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 10,),
//                     CategoryTimeButton(
//                       buttonIcon: widget.id == "1" ? Image.asset("assets/png/menu.png") : SizedBox(),
//                       selected: controller.selectedPageIndex,
//                       callback: (int index) {
//                         controller.changeIndex(index);
//                         pageController.jumpToPage(index);
//                       }, category: _homeController.categoryNames,),
//                     PageView(
//                       physics: BouncingScrollPhysics(),
//                       onPageChanged: (index) {
//                         controller.changeIndex(index);
//                       },
//                       controller: pageController,
//                       children:    [
//                         ...List.generate(_homeController.categoryNames!.length, (index){
//                           return ProductPalleteWidget(
//                             index: _homeController.getAllCategoryResponse!.categories![index].id!,
//                           );
//                         }),
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//           )
//       );
//     });
//   }
// }

// import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
// import 'package:dexter_mobile/app/shared/widgets/empty_screen.dart';
// import 'package:dexter_mobile/app/shared/widgets/error_screen.dart';
// import 'package:dexter_mobile/core/state/view_state.dart';
// import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
//
// class AllVendorScreen extends StatefulWidget {
//   const AllVendorScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AllVendorScreen> createState() => _AllVendorScreenState();
// }
//
// class _AllVendorScreenState extends State<AllVendorScreen> {
//   final _scrollController = ScrollController();
//   Widget buildAllVendors(HomeController controller){
//     switch (controller.viewState.state){
//       case ResponseState.LOADING:
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               GridView.count(
//                 physics: ScrollPhysics(),
//                 crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: (1/0.8),
//                 shrinkWrap: true, crossAxisCount: 2,
//                 children: List.generate(4, (index){
//                   return Shimmer.fromColors(
//                     baseColor: Colors.grey.shade500,
//                     highlightColor: Color(0xff6F6F6F)
//                         .withOpacity(0.5),
//                     child: Container(
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: white),
//                     ),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         );
//       case ResponseState.COMPLETE:
//         return SizedBox(
//           height: MediaQuery.of(context).size.height/3,
//           child: GridView(
//             controller: _scrollController, scrollDirection: Axis.horizontal,
//             gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 130,
//                 childAspectRatio: 3/6,
//                 crossAxisSpacing: 20,
//                 mainAxisSpacing: 20
//             ),
//             physics: BouncingScrollPhysics(),
//             children: List.generate(controller.allVendorViewState.data!.data!.length > 4 ? 4 : controller.allVendorViewState.data!.data!.length , (index){
//               return GestureDetector(
//                 onTap: (){},
//                 child: Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: white),
//                   child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Row(
//                           children: [
//                             ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: Container(
//                                   height: 80, width: 80,
//                                   decoration: BoxDecoration(
//                                       image: DecorationImage(image: NetworkImage(controller.allVendorViewState.data!.data![index].image!), fit: BoxFit.cover)
//                                   ),
//                                 )),
//                             const SizedBox(width: 8,),
//                             Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(controller.allVendorViewState.data!.data![index].name!, overflow: TextOverflow.fade,
//                                   style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12,color: black, fontWeight: FontWeight.w700,),),
//                                 const SizedBox(height: 6,),
//                                 Row(
//                                   children: [
//                                     RatingBar.builder(
//                                       itemSize: 12,
//                                       initialRating: double.parse(controller.allVendorViewState.data!.data![index].rating!),
//                                       minRating: 1,
//                                       direction: Axis.horizontal,
//                                       allowHalfRating: true,
//                                       itemCount: 5,
//                                       itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
//                                       itemBuilder: (context, _) => Icon(
//                                         Icons.star, size: 10,
//                                         color: Colors.amber,
//                                       ),
//                                       onRatingUpdate: (rating) {
//                                         print(rating);
//                                       },
//                                     ),
//                                     Text(controller.allVendorViewState.data!.data![index].toString(),
//                                       style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12,color: black, fontWeight: FontWeight.w700,),),
//                                   ],
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ),
//         );
//       case ResponseState.ERROR:
//         return const ErrorScreen();
//       case ResponseState.EMPTY:
//         return const EmptyScreen();
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(top: false, bottom: false,
//         child: GetBuilder<HomeController>(
//           init: HomeController(),
//             builder: (controller){
//           return Scaffold(
//             appBar: AppBar(
//               elevation: 0.0, backgroundColor: white,
//               leading: GestureDetector(
//                   onTap: (){
//                     Get.back();
//                   }, child: Icon(Icons.arrow_back, color: black,)),
//             ),
//             body: ListView(
//               children: [
//                 const SizedBox(height: 24,),
//                 Align(alignment: Alignment.centerLeft,
//                   child: Text(
//                     'All Vendors',
//                     style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 const SizedBox(height: 16,),
//                 buildAllVendors(controller),
//               ],
//             ),
//           );
//         })
//     );
//   }
// }

// import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
// import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
//
// class AllServicesScreen extends StatefulWidget {
//   const AllServicesScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AllServicesScreen> createState() => _AllServicesScreenState();
// }
//
// class _AllServicesScreenState extends State<AllServicesScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeController>(
//       init: HomeController(),
//         builder: (controller){
//       return SafeArea(top: false, bottom: false,
//           child: Scaffold(
//             backgroundColor: white,
//             appBar: AppBar(
//               elevation: 0.0, backgroundColor: white,
//               leading:  GestureDetector(
//                 onTap: () => Navigator.pop(context),
//                 child: const Icon(Iconsax.arrow_left, color: black,),
//               ),
//               title: Text("Services", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 16, fontWeight: FontWeight.w600),),
//             ),
//             body: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 30,),
//                   GridView.count(
//                     physics: ScrollPhysics(),
//                     crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: (1/0.9),
//                     shrinkWrap: true, crossAxisCount: 2,
//                     children: List.generate(controller.vendorType.length, (index){
//                       return GestureDetector(
//                         onTap: (){},
//                         child: Container(
//                           padding: EdgeInsets.all(8),
//                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
//                             color: index == 0 ? Color(0xffD9F2EA) : index == 1 ? Color(0xffFBEEDC) : index == 2 ? Color(0xffF9DFDF) : index == 3 ? Color(0xffEDF3FF) :
//                           index == 4 ? Color(0xffEDF3FF) : index == 5 ? Color(0xffFFEAFC) : index == 6? Color(0xffD9F2EA) : Color(0xffF9DFDF),),
//                           child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image.asset(controller.vendorType[index]["assets"]!, width: 60, height: 60,),
//                               const SizedBox(width: 15,),
//                               Text(controller.vendorType[index]["title"]!, overflow: TextOverflow.fade,
//                                 style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12,color: black, fontWeight: FontWeight.w700,),)
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//                   )
//                 ],
//               ),
//             ),
//           )
//       );
//     });
//   }
// }

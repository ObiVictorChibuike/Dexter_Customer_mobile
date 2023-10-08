import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/home/top_rated_vendor_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class AllTopRatedVendor extends StatefulWidget {
  const AllTopRatedVendor({super.key});

  @override
  State<AllTopRatedVendor> createState() => _AllTopRatedVendorState();
}

class _AllTopRatedVendorState extends State<AllTopRatedVendor> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: white, scrolledUnderElevation: 0,
            elevation: 0.0,
            leading: GestureDetector(
                onTap: () async {
                  Get.back();
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
            title: Text("Top Rated Shops", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 18, fontWeight: FontWeight.w600),),),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ...List.generate(controller.topRatedVendorViewState.data!.data!.length, (index){
                  return GestureDetector(
                    onTap: (){
                      Get.to(()=> VendorDetail(id: controller.topRatedVendorViewState.data!.data![index].id!.toString(), name: controller.topRatedVendorViewState.data!.data![index].name!,));
                    },
                    child: Card(elevation: 0.5,
                      child: Container(width: double.maxFinite,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: white),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
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
                                            tapOnlyMode: true,
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
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      );
    });
  }
}

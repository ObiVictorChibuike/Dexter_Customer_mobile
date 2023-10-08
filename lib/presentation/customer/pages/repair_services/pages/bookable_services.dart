import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/presentation/customer/pages/repair_services/controller/bookable_services_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/repair_services/pages/bookable-services_details.dart';
import 'package:dexter_mobile/presentation/customer/widget/circular_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class BookableServices extends StatefulWidget {
  final String serviceId;
  final String serviceName;
  const BookableServices({Key? key, required this.serviceId, required this.serviceName}) : super(key: key);

  @override
  State<BookableServices> createState() => _BookableServicesState();
}

class _BookableServicesState extends State<BookableServices> {
  final _controller = Get.put(BookableServicesController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookableServicesController>(
      init: BookableServicesController(),
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
              title: Text("${widget.serviceName} Services", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 18, fontWeight: FontWeight.w600),),),
            body: controller.businessByServicesLoadingState == true && controller.businessByServicesErrorState == false ?  CircularLoadingWidget() :
            controller.businessByServicesLoadingState == false && controller.businessByServicesErrorState == false && controller.businessByServicesResponse!.data!.isEmpty || controller.businessByServicesResponse?.data == [] ?
            Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetPath.emptyFile, height: 120, width: 120,),
                  const SizedBox(height: 40,),
                  Text("No service provider available for this service",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray, fontSize: 14, fontWeight: FontWeight.w400),),
                ],
              ),
            ) :
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ...List.generate(controller.businessByServicesResponse!.data!.length, (index){
                  final item = controller.businessByServicesResponse!.data![index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(()=> BookableServicesDetails(businessId: item.id.toString(),));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(13)),
                          child: Row(
                            children: [
                              ClipRRect(borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  height: 80, width: 80,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                  child: Image.network(item.coverImage ?? imagePlaceHolder, fit: BoxFit.cover,),
                                ),
                              ),
                              const SizedBox(width: 15,),
                              Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name ?? "", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),),
                                  const SizedBox(height: 5,),
                                  Text("Location:", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12, color: greenPea, fontWeight: FontWeight.w700),),
                                  Text(item.contactAddress?.fullAddress ?? "",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12, color: greenPea, fontWeight: FontWeight.w300),),
                                  const SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      // Container(
                                      //   padding: EdgeInsets.all(8),
                                      //   decoration: BoxDecoration(color: Color(0xffD9F2EA),
                                      //       borderRadius: BorderRadius.circular(100)),
                                      //   child: item.averageRating == null || item.averageRating == "" ?
                                      //   Text(
                                      //     "Rating: ${"0.0"}",
                                      //     style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w600),
                                      //   ) : item.averageRating.toString().length <= 2 ?
                                      //   Text(
                                      //     "Rating: ${item.averageRating ?? ""}",
                                      //     style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w600),
                                      //   ) : item.averageRating.toString().length > 2 ?
                                      //   Text(
                                      //     "Rating: ${item.averageRating!.substring(0,3) ?? ""}",
                                      //     style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w600),
                                      //   ) : Text(
                                      //     "Rating: ${""}",
                                      //     style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w600),
                                      //   ),
                                      // ),
                                      RatingBar.builder(
                                        itemSize: 12,
                                        initialRating: item.averageRating == null ? 0.0 : double.parse(item.averageRating?.substring(0,3) ?? "0.0"),
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
                                      item.averageRating == null || item.averageRating == "" ?
                                      Text(
                                        "Rating: ${"0.0"}",
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 12, fontWeight: FontWeight.w700),
                                      ) : item.averageRating.toString().length <= 2 ?
                                      Text(
                                        "Rating: ${item.averageRating ?? ""}",
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 12, fontWeight: FontWeight.w700),
                                      ) : item.averageRating.toString().length > 2 ?
                                      Text(
                                        "Rating: ${item.averageRating!.substring(0,3) ?? ""}",
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 12, fontWeight: FontWeight.w700),
                                      ) : Text(
                                        "Rating: ${""}",
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 12, fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                })
              ],
            ),
          )
      );
    });
  }

  @override
  void initState() {
    _controller.getBusinessByServices(serviceId: widget.serviceId);
    super.initState();
  }
}

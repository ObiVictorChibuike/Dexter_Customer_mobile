import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/utils/custom_date.dart';
import 'package:dexter_mobile/presentation/customer/controller/booking_controller.dart';
import 'package:dexter_mobile/presentation/customer/widget/circular_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'booking_detail_screen.dart';
import 'booking_progress.dart';

class PendingBookingScreen extends StatefulWidget {
  const PendingBookingScreen({Key? key}) : super(key: key);

  @override
  State<PendingBookingScreen> createState() => _PendingBookingScreenState();
}

class _PendingBookingScreenState extends State<PendingBookingScreen> {
  final _controller = Get.put(BookingController());


  @override
  void initState() {
    _controller.getPendingBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      init: BookingController(),
        builder: (controller){
        return Builder(builder: (context){
          if(_controller.pendingBookingsResponseModel == null || _controller.pendingBookingsResponseModel!.isEmpty && _controller.getPendingBookingLoadingState == true && _controller.getPendingBookingErrorState == false ){
            return CircularLoadingWidget();
          }else if(_controller.pendingBookingsResponseModel == null || _controller.pendingBookingsResponseModel!.isEmpty && _controller.getPendingBookingLoadingState == false && _controller.getPendingBookingErrorState == false ){
            return  Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetPath.emptyFile, height: 120, width: 120,),
                  const SizedBox(height: 40,),
                  Text("You have no active bookings",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray, fontSize: 14, fontWeight: FontWeight.w400),),
                ],
              ),
            );
          }else if(_controller.pendingBookingsResponseModel != null || _controller.pendingBookingsResponseModel!.isNotEmpty && _controller.getPendingBookingLoadingState == false && _controller.getPendingBookingErrorState == false ){
            return  Column(
              children: [
                const SizedBox(height: 10,),
                ...List.generate( _controller.pendingBookingsResponseModel!.length, (index){
                  final item = _controller.pendingBookingsResponseModel![index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(()=> BookingDetails(bookingId: item.id!.toString(),));
                        },
                        child: Container(
                          width: double.maxFinite, padding: EdgeInsets.all(16),
                          decoration: BoxDecoration( borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: dustyGray)),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(80),
                                    child: Container(height: 40, width: 40, decoration: BoxDecoration(shape: BoxShape.circle),
                                      child: Image.network(
                                        item.business?.coverImage ??
                                            imagePlaceHolder , height: 40, width: 40, fit: BoxFit.cover,),
                                    ),
                                  ),
                                  const SizedBox(width: 15,),
                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.business?.name ?? "",
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),),
                                      Text(CustomDate.slash(item.scheduledDate.toString()),
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xff8F92A1), fontSize: 12, fontWeight: FontWeight.w400),),
                                    ],
                                  ),
                                ],
                              ),

                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: black, borderRadius: BorderRadius.circular(2)),
                                child: Text(item.status ?? "",  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: white, fontSize: 10, fontWeight: FontWeight.w700),),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                    ],
                  );
                })
              ],
            );
          }else if(_controller.pendingBookingsResponseModel == null || _controller.pendingBookingsResponseModel!.isEmpty && _controller.getPendingBookingLoadingState == false && _controller.getPendingBookingErrorState == true ){
            return CircularLoadingWidget();
          }
          return SizedBox.shrink();
        });
    });
  }
}

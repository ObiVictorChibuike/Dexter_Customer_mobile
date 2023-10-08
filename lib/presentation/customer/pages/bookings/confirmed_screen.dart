import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/utils/custom_date.dart';
import 'package:dexter_mobile/presentation/customer/controller/booking_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/bookings/booking_detail_screen.dart';
import 'package:dexter_mobile/presentation/customer/pages/bookings/booking_progress.dart';
import 'package:dexter_mobile/presentation/customer/widget/circular_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmedBookingScreen extends StatefulWidget {
  const ConfirmedBookingScreen({super.key});

  @override
  State<ConfirmedBookingScreen> createState() => _ConfirmedBookingScreenState();
}

class _ConfirmedBookingScreenState extends State<ConfirmedBookingScreen> {
  final _controller = Get.find<BookingController>();
  @override
  void initState() {
    _controller.getConfirmedBookings();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
        init: BookingController(),
        builder: (controller){
          return Builder(builder: (context){
            if(_controller.confirmedBookingsResponseModel == null || _controller.confirmedBookingsResponseModel!.isEmpty && _controller.getConfirmedBookingsLoadingState == true && _controller.getConfirmedBookingsErrorState == false){
              return CircularLoadingWidget();
            }else if(_controller.confirmedBookingsResponseModel == null || _controller.confirmedBookingsResponseModel!.isEmpty && _controller.getConfirmedBookingsLoadingState == false && _controller.getConfirmedBookingsErrorState == false ){
              return Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AssetPath.emptyFile, height: 120, width: 120,),
                    const SizedBox(height: 40,),
                    Text("You have no confirmed bookings",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray, fontSize: 14, fontWeight: FontWeight.w400),),
                  ],
                ),
              );
            }else if(_controller.confirmedBookingsResponseModel != null || _controller.confirmedBookingsResponseModel!.isNotEmpty && _controller.getConfirmedBookingsLoadingState == false && _controller.getConfirmedBookingsErrorState == false){
              return Column(
                children: [
                  const SizedBox(height: 10,),
                  ...List.generate( _controller.confirmedBookingsResponseModel!.length, (index){
                    final item = _controller.confirmedBookingsResponseModel![index];
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
                                          item.business?.coverImage ?? imagePlaceHolder , height: 40, width: 40, fit: BoxFit.cover,),
                                      ),
                                    ),
                                    const SizedBox(width: 15,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item.business?.name ?? "",
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),),
                                        Text(CustomDate.slash(item.scheduledDate.toString()),
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xff8F92A1), fontSize: 12, fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: tulipTree, borderRadius: BorderRadius.circular(2)),
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
            }
            return CircularLoadingWidget();
          });
        });
  }
}

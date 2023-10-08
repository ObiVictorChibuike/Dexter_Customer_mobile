import 'package:clean_dialog/clean_dialog.dart';
import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/bookings/booking_detail_screen.dart';
import 'package:dexter_mobile/presentation/customer/pages/orders/order_details_screen.dart';
import 'package:dexter_mobile/presentation/customer/widget/circular_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  showAlertDialog({required String notificationId}){
    showDialog(
      context: context,
      builder: (context) => CleanDialog(
        title: 'Mark As Read',
        content: "Do you want to mark this notification as Read",
        backgroundColor: greenPea,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
        actions: [
          CleanDialogActionButtons(
              actionTitle: 'Ok',
              textColor: persianRed,
              onPressed: (){
                Navigator.pop(context);
                controller.markAsRead(context: context, notificationId: notificationId, isNotificationDetails: false);
              }
          ),
          CleanDialogActionButtons(
              actionTitle: 'Cancel',
              textColor: greenPea,
              onPressed: (){
                Navigator.pop(context);
              }
          ),
        ],
      ),
    );
  }


  showMarkAllDialog(){
    showDialog(
      context: context,
      builder: (context) => CleanDialog(
        title: 'Mark All as Read',
        content: "Do you want to mark all notification as Read",
        backgroundColor: greenPea,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
        actions: [
          CleanDialogActionButtons(
              actionTitle: 'Ok',
              textColor: persianRed,
              onPressed: (){
                Navigator.pop(context);
                controller.markAllAsRead(context: context);
              }
          ),
          CleanDialogActionButtons(
              actionTitle: 'Cancel',
              textColor: greenPea,
              onPressed: (){
                Navigator.pop(context);
              }
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller){
          return SafeArea(top: false, bottom: false,
              child: Scaffold(
                backgroundColor: white,
                appBar: AppBar(
                  centerTitle: true,
                  actions: [
                    controller.inAppNotificationResponse == [] ||
                        controller.inAppNotificationResponse?.length == 0 ||
                        controller.inAppNotificationResponse!.length < 2 ?
                    const SizedBox() :
                    GestureDetector(
                      onTap: (){
                        showMarkAllDialog();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 13.0),
                        child: Icon(Icons.mark_email_read_sharp, color: greenPea,),
                      ),
                    ),
                  ],
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
                  elevation: 0.0, backgroundColor: white,
                  title: Text("Notifications", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 20, fontWeight: FontWeight.w700),),
                ),
                body:
                controller.inAppNotificationLoadingState == true && controller.inAppNotificationErrorState == false ?
                CircularLoadingWidget() : controller.inAppNotificationLoadingState == false && controller.inAppNotificationErrorState == false ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: controller.inAppNotificationResponse == [] || controller.inAppNotificationResponse!.isEmpty ?
                  Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AssetPath.emptyNotification, height: 80, width: 80,),
                        const SizedBox(height: 32,),
                        Text("You’re caught up", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 16, fontWeight: FontWeight.w500),),
                        const SizedBox(height: 8,),
                        Text("You have no pending notifications currently",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray, fontSize: 14, fontWeight: FontWeight.w400),),
                      ],
                    ),
                  ) :
                  ListView(
                    children: [
                      const SizedBox(height: 15,),
                      ...List.generate(controller.inAppNotificationResponse!.length, (index){
                        final data = controller.inAppNotificationResponse![index];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                if(data.data?.type?.toLowerCase().substring(0,7) == "booking"){
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> BookingDetails(bookingId: data.data!.bookingId!.toString())));
                                }else if(data.data?.type?.toLowerCase().substring(0,5) == "order"){
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> OrderDetails(orderId: data.data!.orderId!.toString())));
                                }else{
                                  null;
                                }
                              },
                              child: Container(
                                width: double.maxFinite, padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    Row(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        data.readAt == null ? Image.asset(AssetPath.notification, height: 50, width: 50,) :Image.asset("assets/png/read_note.png", height: 50, width: 50,),
                                        const SizedBox(width: 16,),
                                        Expanded(
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(data.data?.type?.toLowerCase() == "booking.placed" ? "Booking Placed"
                                                  : data.data?.type?.toLowerCase() == "order.cancelled" ? "Order Cancelled"
                                                  : data.data?.type?.toLowerCase() == "order.completed" ? "Order Completed"
                                                  : data.data?.type?.toLowerCase() == "order.confirmed" ? "Order Confirmed"
                                                  : data.data?.type?.toLowerCase() == "order.fulfilled" ? "Order Fulfilled"
                                                  : data.data?.type?.toLowerCase() == "order.placed" ? "Order Placed"
                                                  : data.data?.type?.toLowerCase() == "order.received" ? "Order Received"
                                                  : data.data?.type?.toLowerCase() == "booking.cancelled" ? "Booking Cancelled"
                                                  : data.data?.type?.toLowerCase() == "booking.completed" ? "Booking Completed"
                                                  : data.data?.type?.toLowerCase() == "booking.confirmed" ? "Booking Confirmed"
                                                  : data.data?.type?.toLowerCase() == "booking.fulfilled" ? "Booking Fulfilled"
                                                  : data.data?.type?.toLowerCase() == "booking.placed" ? "Booking Placed"
                                                  : data.data?.type?.toLowerCase() == "booking.received" ? "Booking Received"
                                                  : data.data?.type?.toLowerCase() == "wallet.credited" ? "Wallet Credited"
                                                  : data.data?.type?.toLowerCase() == "wallet.debited" ? "Wallet Debited" : "",
                                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 16, fontWeight: FontWeight.w600),),
                                              Text(data.data?.message ?? "",
                                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 12,
                                                    fontWeight: data.readAt == null ? FontWeight.w400 : FontWeight.w400),
                                                maxLines: 3, overflow: TextOverflow.ellipsis,),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    data.readAt == null ? const SizedBox(height: 5,) : const SizedBox(),
                                    data.readAt == null ?
                                    GestureDetector(
                                      onTap: (){
                                        showAlertDialog(notificationId: data.id!.toString());
                                      },
                                      child: Align(alignment: Alignment.centerRight,
                                        child: Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), width: MediaQuery.of(context).size.width/ 3.5,
                                          decoration:BoxDecoration(color: greenPea, borderRadius: BorderRadius.circular(30)),
                                          child: Center(child: Text("Mark as read",  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: white, fontSize: 12, fontWeight: FontWeight.w600),)),),
                                      ),
                                    ) : const SizedBox()
                                  ],
                                ),
                              ),
                            ),
                            const Divider(color: greenPea,)
                          ],
                        );
                      })
                    ],
                  ),
                ) : CircularLoadingWidget(),
              )
          );
        });
  }

  HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    controller.getInAppNotification();
    super.initState();
  }
}

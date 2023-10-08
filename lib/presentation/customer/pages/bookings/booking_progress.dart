import 'package:clean_dialog/clean_dialog.dart';
import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/utils/custom_date.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_primary_button.dart';
import 'package:dexter_mobile/presentation/customer/controller/booking_controller.dart';
import 'package:dexter_mobile/presentation/customer/controller/order_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/bookings/booking_detail_screen.dart';
import 'package:dexter_mobile/presentation/customer/pages/orders/order_details_screen.dart';
import 'package:dexter_mobile/presentation/customer/pages/orders/widget/order_tracking_widget.dart';
import 'package:dexter_mobile/presentation/customer/widget/circular_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BookingProgressScreen extends StatefulWidget {
  final int id;
  const BookingProgressScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<BookingProgressScreen> createState() => _BookingProgressScreenState();
}

class _BookingProgressScreenState extends State<BookingProgressScreen> with TickerProviderStateMixin{
  confirmBookingCancellation({required BookingController controller, }){
    showDialog(
      context: context,
      builder: (context) => CleanDialog(
        title: 'Cancel Booking',
        content: "Are you sure you want to cancel this booking?",
        backgroundColor: greenPea,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
        actions: [
          CleanDialogActionButtons(
              actionTitle: 'Confirm',
              textColor: greenPea,
              onPressed: () async {
                Navigator.pop(context);
                controller.cancelBooking(bookingId: controller.bookingDetailsModelResponse!.data!.id.toString());
              }
          ),
          CleanDialogActionButtons(
              actionTitle: 'Discard',
              textColor: persianRed,
              onPressed: (){
                Navigator.pop(context);
              }
          ),
        ],
      ),
    );
  }

  confirmPayment({required BookingController controller, }){
    showDialog(
      context: context,
      builder: (context) => CleanDialog(
        title: 'Confirm Request',
        content: "Are you sure you want to initiate this payment?",
        backgroundColor: greenPea,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
        actions: [
          CleanDialogActionButtons(
              actionTitle: 'Confirm',
              textColor: greenPea,
              onPressed: () async {
                Navigator.pop(context);
                controller.cashOnDelivery(bookingId: controller.bookingDetailsModelResponse!.data!.id.toString());
              }
          ),
          CleanDialogActionButtons(
              actionTitle: 'Discard',
              textColor: persianRed,
              onPressed: (){
                Navigator.pop(context);
              }
          ),
        ],
      ),
    );
  }
  final paymentMethod = [
    {
      "title": "Cash on Delivery",
      "assets": "assets/png/delivery.png"
    },
    {
      "title": "Pay with Card",
      "assets": "assets/png/credit-card.png"
    },
  ];

  void payOptionDialog({required BookingController controller}){
    Get.bottomSheet(Container(decoration: BoxDecoration(color: white,borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/3.5,), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: ListView(
        children: [
          const SizedBox(height: 10,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text("Choose Payment method", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 18, fontWeight: FontWeight.w600),),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 30, width: 30, decoration: BoxDecoration(shape: BoxShape.circle, color: iron),
                  child: Center(
                    child: Icon(
                      Icons.clear, color: black,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20,),
          ...List.generate(paymentMethod.length, (index){
            return Column(
              children: [
                GestureDetector(
                  onTap: (){
                    if(index == 0){
                      Get.back();
                      confirmPayment(controller: controller);
                    }else{
                      controller.payWithPayStack(bookingId: controller.bookingDetailsModelResponse!.data!.id.toString());
                    }
                  },
                  child: Container(
                    height: 55, width: double.maxFinite, color: Colors.white,
                    child: Row(
                      children: [
                        Image.asset(paymentMethod[index]["assets"]!, height: 40, width: 40,),
                        const SizedBox(width: 15,),
                        Text(paymentMethod[index]["title"]!, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 15, fontWeight: FontWeight.w400),)
                      ],
                    ),
                  ),
                ),
                Divider()
              ],
            );
          })
        ],
      ),
    ), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
    ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
        init: Get.find<BookingController>(),
        builder: (controller){
          return Builder(builder: (context){
            if(_controller.bookingDetailsModelResponse == null && _controller.getBookingDetailsLoadingState == true && _controller.getBookingDetailsErrorState == false ){
              return CircularLoadingWidget();
            }else if(_controller.bookingDetailsModelResponse == null && _controller.getBookingDetailsLoadingState == false && _controller.getBookingDetailsErrorState == false ){
              return Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AssetPath.emptyFile, height: 120, width: 120,),
                    const SizedBox(height: 40,),
                    Text("No Data",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray, fontSize: 14, fontWeight: FontWeight.w400),),
                  ],
                ),
              );
            }else if(_controller.bookingDetailsModelResponse != null && _controller.getBookingDetailsLoadingState == false && _controller.getBookingDetailsErrorState == false ){
              final item = controller.bookingDetailsModelResponse?.data;

              List<MyStep> pendingSteps = [
                MyStep(
                  shimmer: false,
                  iconStyle: greenPea,
                  title: 'Your booking is Pending',
                  content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()), style:
                      Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff37474F)),)),
                ),
                MyStep(
                  shimmer: false,
                  iconStyle: greenPea,
                  title: 'Waiting of Confirmation',
                  content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()), style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff37474F)),)),
                ),
              ];

              List<MyStep> fulfilled = [
                MyStep(
                  shimmer: false,
                  iconStyle: greenPea,
                  title: 'Your booking is Pending',
                  content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()), style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff37474F)),)),
                ),
                MyStep(
                  shimmer: false,
                  iconStyle: greenPea,
                  title: 'Waiting of Confirmation',
                  content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()), style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff37474F)),)),
                ),
                MyStep(
                  shimmer: false,
                  iconStyle: greenPea,
                  title: 'Your Booking is Delivered',
                  content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()), style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff37474F)),)),
                ),
                MyStep(
                  shimmer: false,
                  iconStyle: greenPea,
                  title: 'Waiting for Payment',
                  content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()), style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff37474F)),)),
                ),
              ];


              List<MyStep> confirmed = [
                MyStep(
                  shimmer: false,
                  iconStyle: greenPea,
                  title: 'Your booking is Pending',
                  content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()), style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff37474F)),)),
                ),
                MyStep(
                  shimmer: false,
                  iconStyle: greenPea,
                  title: 'Waiting of Confirmation',
                  content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()), style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff37474F)),)),
                ),
                MyStep(
                  shimmer: false,
                  iconStyle: greenPea,
                  title: 'Ready to be delivered',
                  content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()), style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff37474F)),)),
                ),
              ];


              List<MyStep> completed = [
                MyStep(
                  shimmer: false,
                  iconStyle: greenPea,
                  title: 'Your booking is Pending',
                  content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()), style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff37474F)),)),
                ),
                MyStep(
                  shimmer: false,
                  iconStyle: greenPea,
                  title: 'Waiting of Confirmation',
                  content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()), style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff37474F)),)),
                ),
                MyStep(
                  shimmer: false,
                  iconStyle: greenPea,
                  title: 'Your booking is Fulfilled',
                  content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()), style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff37474F)),)),
                ),
                MyStep(
                  shimmer: false,
                  iconStyle: greenPea,
                  title: 'Waiting for Payment',
                  content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()), style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff37474F)),)),
                ),
                MyStep(
                  shimmer: false,
                  iconStyle: greenPea,
                  title: 'Your booking is Completed',
                  content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()), style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff37474F)),)),
                ),
                MyStep(
                  shimmer: false,
                  iconStyle: greenPea,
                  title: 'Kindly rate us and comment',
                  content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()), style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff37474F)),)),
                ),
              ];
              List<MyStep> cancelled = [
                MyStep(
                  shimmer: false,
                  iconStyle: greenPea,
                  title: 'This order has been cancelled',
                  content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()), style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff37474F)),)),
                ),
              ];
              return SafeArea(top: false, bottom: false,
                child: Scaffold(backgroundColor: white,
                  appBar: AppBar(
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
                    title: Text("Booking Progress", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 20, fontWeight: FontWeight.w700),),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 26,),
                        Container(
                          width: double.maxFinite, padding: EdgeInsets.all(10),
                          decoration: BoxDecoration( borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: dustyGray)),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(80),
                                    child: Container(height: 40, width: 40, decoration: BoxDecoration(shape: BoxShape.circle),
                                      child: Image.network(
                                        item?.business?.coverImage ??
                                            imagePlaceHolder , height: 40, width: 40, fit: BoxFit.cover,),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text( item?.business?.name ?? "",
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),),
                                      Text(CustomDate.slash(item?.createdAt.toString() ?? DateTime.now().toString()),
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xff8F92A1), fontSize: 12, fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(color: item?.status == "pending" ? black :
                                item?.status == "fulfilled" ? Colors.deepOrangeAccent : item?.status == "completed" ? greenPea : item?.status == "cancelled" ? persianRed : item?.status == "confirmed" ? tulipTree :
                                Colors.transparent, borderRadius: BorderRadius.circular(2)),
                                child: Text(item?.status ?? "",  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: white, fontSize: 10, fontWeight: FontWeight.w700),),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Progress", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 13, fontWeight: FontWeight.w600),),
                            GestureDetector(
                                onTap: (){
                                  Get.to(()=> BookingDetails(bookingId: widget.id.toString(),));
                                }, child: Text("View Details", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 13, fontWeight: FontWeight.w400),))
                          ],
                        ),
                        const SizedBox(height: 5,),
                        VerticalStepper(
                          steps: item?.status == "pending" ? pendingSteps : item?.status == "confirmed" ? confirmed : item?.status == "fulfilled" ? fulfilled : item?.status == "completed" ? completed : item?.status == "cancelled" ? cancelled : pendingSteps,
                          dashLength: 50,
                        ),
                        const SizedBox(height: 18,),
                        // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text("Estimated Delivery Date",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xff999999), fontSize: 13, fontWeight: FontWeight.w600), ),
                        //     Text("November 19",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 13, fontWeight: FontWeight.w600), ),
                        //   ],
                        // ),
                        // const SizedBox(height: 15,),
                        item?.status == "fulfilled" ?
                        DexterPrimaryButton(
                          onTap: (){
                            payOptionDialog(controller: controller);
                          },
                          buttonBorder: greenPea, btnTitle: "Make Payment",
                          borderRadius: 30, titleColor: white, btnHeight: 56, btnTitleSize: 16,
                        )
                            : const SizedBox(),
                        const SizedBox(height: 24,),
                        item?.status == "cancelled" || item?.status == "completed" || item?.status == "fulfilled" ? const SizedBox() : DexterPrimaryButton(
                          onTap: (){
                            confirmBookingCancellation(controller: controller);
                          },
                          buttonBorder: Color(0xffFCEFEF), btnTitle: "Cancel Booking", btnColor: Color(0xffFCEFEF),
                          borderRadius: 30, titleColor: Color(0xffCC2929), btnHeight: 56, btnTitleSize: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }else if(_controller.bookingDetailsModelResponse == null && _controller.getBookingDetailsLoadingState == false && _controller.getBookingDetailsErrorState == false ){
              return CircularLoadingWidget();
            }
            return SizedBox.shrink();
          });
        });
  }
  final _controller = Get.find<BookingController>();
  @override
  void initState() {
    _controller.getBookingDetails(bookingId: widget.id.toString());
    super.initState();
  }
}

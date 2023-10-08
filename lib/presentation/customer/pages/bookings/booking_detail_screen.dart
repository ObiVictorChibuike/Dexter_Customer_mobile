import 'package:clean_dialog/clean_dialog.dart';
import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/utils/custom_date.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_primary_button.dart';
import 'package:dexter_mobile/presentation/botton_nav_controller.dart';
import 'package:dexter_mobile/presentation/customer/controller/booking_controller.dart';
import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/orders/rate_and_review.dart';
import 'package:dexter_mobile/presentation/customer/widget/animated_column.dart';
import 'package:dexter_mobile/presentation/customer/widget/circular_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingDetails extends StatefulWidget {
  final String bookingId;
  const BookingDetails({super.key, required this.bookingId});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  final homeController = Get.find<HomeController>();
  final _controller = Get.find<BookingController>();
  final _bnbController = Get.find<BottomNavigationBarController>();

  @override
  void initState() {
    _controller.getBookingDetails(bookingId: widget.bookingId);
    super.initState();
  }

  late DateTime _selectedDate = DateTime.now();
  final dateController = TextEditingController();
  final serviceProviderType = TextEditingController();
  final serviceProvider = TextEditingController();
  final chargeAmount = TextEditingController();
  String? dateTimeString;
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
  final formKey = GlobalKey <FormState>();

  String greeting({required DateTime date}) {
    var hour = date.hour;
    if (hour < 12) {
      return 'Morning';
    }if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
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
        init: BookingController(),
        builder: (controller){
          return SafeArea(top: false, bottom: false,
              child: Scaffold(
                  backgroundColor: white,
                  appBar: AppBar(
                    centerTitle: true,
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
                    title: Text("Appointment Details", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 20, fontWeight: FontWeight.w700),),
                  ),
                  body: Builder(builder: (context){
                    if(controller.bookingDetailsModelResponse == null && controller.getBookingDetailsLoadingState == true && controller.getBookingDetailsErrorState == false){
                      return CircularLoadingWidget();
                    }else if(controller.bookingDetailsModelResponse == null && controller.getBookingDetailsLoadingState == false && controller.getBookingDetailsErrorState == false ){
                      return Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(AssetPath.emptyFile, height: 120, width: 120,),
                            const SizedBox(height: 40,),
                            Text("Booking details not available",
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray, fontSize: 14, fontWeight: FontWeight.w400),),
                          ],
                        ),
                      );
                    } else if(controller.bookingDetailsModelResponse != null && controller.getBookingDetailsLoadingState == false && controller.getBookingDetailsErrorState == false){
                      return  AnimatedColumn(children: [
                        const SizedBox(height: 10,),
                        Text("Location",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: dustyGray, fontWeight: FontWeight.w500, fontSize: 13),),
                        const SizedBox(height: 6,),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(12), border: Border.all(color: greenPea)),
                          child: Center(
                            child:  Row(
                              children: [
                                Icon(Icons.location_on, color: greenPea,),
                                Expanded(
                                  child: Text(controller.bookingDetailsModelResponse?.data?.address?.fullAddress ?? "", overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: black, fontWeight: FontWeight.w500, fontSize: 13),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(12), border: Border.all(color: greenPea)),
                          child: Column(
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Time/Date",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: black, fontWeight: FontWeight.w500, fontSize: 13),),
                                  Text(CustomDate.slash(controller.bookingDetailsModelResponse?.data?.scheduledDate.toString() ?? DateTime.now().toString())),
                                ],
                              ),
                              const Divider(),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Reference Number",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: black, fontWeight: FontWeight.w500, fontSize: 13),),
                                  Text(controller.bookingDetailsModelResponse?.data?.reference ?? "",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: greenPea, fontWeight: FontWeight.w600, fontSize: 13),),
                                ],
                              ),
                              const Divider(),
                              controller.bookingDetailsModelResponse?.data?.notes == null ? const SizedBox():
                              Align(alignment: Alignment.centerLeft,
                                child: Text("Message",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: black, fontWeight: FontWeight.w500, fontSize: 13),),
                              ),
                              controller.bookingDetailsModelResponse?.data?.notes == null ? const SizedBox(): const SizedBox(height: 10,),
                              controller.bookingDetailsModelResponse?.data?.notes == null ? const SizedBox():
                              Text(controller.bookingDetailsModelResponse?.data?.notes ?? "",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: greenPea, fontSize: 13, fontWeight: FontWeight.w400),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Text("Vendor Details",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: black, fontWeight: FontWeight.w500, fontSize: 13),),
                        const SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(12), border: Border.all(color: greenPea)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(50),
                                    child: Container(height: 50, width: 50, decoration: BoxDecoration(shape: BoxShape.circle),
                                        child: Image.network(controller.bookingDetailsModelResponse?.data?.business?.coverImage ?? imagePlaceHolder, fit: BoxFit.cover,)
                                    ),
                                  ),
                                  const SizedBox(width: 15,),
                                  Expanded(child:
                                  Row(mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(controller.bookingDetailsModelResponse?.data?.business?.name ?? "",
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 16),),
                                          const SizedBox(height: 5,),
                                          Text("₦ ${MoneyFormatter(amount: double.parse(controller.bookingDetailsModelResponse?.data?.subtotalAmount ?? "0.00"),).output.nonSymbol}",
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 14),),
                                          const SizedBox(height: 5,),
                                          Text("N:B: This fee is exclusive \nof items or parts that \nneed to be bought.",
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: greenPea, fontWeight: FontWeight.w400, fontSize: 12),)
                                        ],
                                      ),
                                    ],
                                  )),
                                  Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 10, width: 10, decoration: BoxDecoration(color:
                                      controller.bookingDetailsModelResponse?.data?.status == "pending" ? black :
                                      controller.bookingDetailsModelResponse?.data?.status == "completed" ? greenPea :
                                      controller.bookingDetailsModelResponse?.data?.status == "confirmed" ? tulipTree :
                                      controller.bookingDetailsModelResponse?.data?.status == "cancelled" ? persianRed :
                                      controller.bookingDetailsModelResponse?.data?.status == "fulfilled" ? Colors.deepOrangeAccent : Colors.transparent,
                                          shape: BoxShape.circle),
                                      ),
                                      Text(controller.bookingDetailsModelResponse?.data?.status == "pending" ? "Pending" :
                                      controller.bookingDetailsModelResponse?.data?.status == "confirmed" ? "Confirmed" :
                                      controller.bookingDetailsModelResponse?.data?.status == "completed" ? "Completed" :
                                      controller.bookingDetailsModelResponse?.data?.status == "cancelled" ? "Cancelled" :
                                      controller.bookingDetailsModelResponse?.data?.status == "fulfilled" ? "Fulfilled" : "",
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 14),),
                                    ],
                                  )
                                ],
                              ),
                              const Divider(),
                              const SizedBox(height: 10,),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Total Service Charge",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: black, fontWeight: FontWeight.w500, fontSize: 13),),
                                  Text("NGN ${MoneyFormatter(
                                    amount: double.parse(controller.bookingDetailsModelResponse?.data?.totalAmount ?? "0.00"),).output.nonSymbol}",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: greenPea, fontWeight: FontWeight.w600, fontSize: 13),),
                                ],
                              ),
                              const Divider(),
                              const SizedBox(height: 10,),
                              Align(alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on, color: greenPea,),
                                    Text("Business Location",
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: black, fontWeight: FontWeight.w500, fontSize: 13),),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6,),
                              controller.bookingDetailsModelResponse?.data?.address?.fullAddress == null ? const SizedBox() :
                              Text(controller.bookingDetailsModelResponse?.data?.address?.fullAddress ?? "",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: dustyGray, fontSize: 13, fontWeight: FontWeight.w400),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50,),
                        controller.bookingDetailsModelResponse?.data?.status == "completed" ? const SizedBox(height: 28,) : const SizedBox(height: 18,),
                        controller.bookingDetailsModelResponse?.data?.status == "completed" ? DexterPrimaryButton(
                          onTap: (){
                            Get.to(()=> RateAndReview(
                              vendorName: controller.bookingDetailsModelResponse?.data?.business?.name.toString() ?? "",
                              isFromBusiness: true, id: controller.bookingDetailsModelResponse!.data!.business!.id.toString(),

                            ));
                          },
                          buttonBorder: greenPea, btnTitle: "Write review",
                          borderRadius: 30, titleColor: white, btnHeight: 56, btnTitleSize: 16,
                        ) : const SizedBox(),
                        controller.bookingDetailsModelResponse?.data?.status == "fulfilled" ?
                        DexterPrimaryButton(
                          onTap: (){
                            payOptionDialog(controller: controller);
                          },
                          buttonBorder: greenPea, btnTitle: "Make Payment",
                          borderRadius: 30, titleColor: white, btnHeight: 56, btnTitleSize: 16,
                        )
                            : const SizedBox(),
                        const SizedBox(height: 24,),
                        controller.bookingDetailsModelResponse?.data?.status == "cancelled" || controller.bookingDetailsModelResponse?.data?.status == "completed" || controller.bookingDetailsModelResponse?.data?.status == "fulfilled" ? const SizedBox() : DexterPrimaryButton(
                          onTap: (){
                            confirmBookingCancellation(controller: controller);
                          },
                          buttonBorder: Color(0xffFCEFEF), btnTitle: "Cancel Booking", btnColor: Color(0xffFCEFEF),
                          borderRadius: 30, titleColor: Color(0xffCC2929), btnHeight: 56, btnTitleSize: 16,
                        ),
                      ], padding: EdgeInsets.symmetric(horizontal: 20));
                    }
                    return CircularLoadingWidget();
                  })
              )
          );
        });
  }
}

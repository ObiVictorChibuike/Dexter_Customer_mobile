import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/presentation/customer/controller/booking_controller.dart';
import 'package:dexter_mobile/presentation/customer/controller/order_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/bookings/confirmed_screen.dart';
import 'package:dexter_mobile/presentation/customer/pages/bookings/processing_screen.dart';
import 'package:dexter_mobile/presentation/customer/pages/orders/processing_screen.dart';
import 'package:dexter_mobile/presentation/customer/widget/booking_category_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pending_screen.dart';
import 'canceled_screen.dart';
import 'completed_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final pageController = PageController();
  List<String> category = [
    'Pending',
    "Confirmed",
    "Delivered",
    'Completed',
    'Canceled',
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      init: BookingController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(backgroundColor: white,
            // appBar: AppBar(
            //   elevation: 0.0, backgroundColor: white,
            //   title: Text("Transactions", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 20, fontWeight: FontWeight.w700),),
            // ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 14,),
                  BookingCategoryButton(
                    selected: controller.currentIndex,
                    callback: (int index) {
                      controller.changeButtonIndex(index);
                      pageController.jumpToPage(index);
                    },
                    category: category,
                  ),
                  Expanded(
                    child: PageView(
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (index) {
                        controller.changeButtonIndex(index);
                      },
                      controller: pageController,
                      children: const[
                        const PendingBookingScreen(),
                        const ConfirmedBookingScreen(),
                        const FulfilledBookingScreen(),
                        const CompletedBookingScreen(),
                        const CanceledBookingScreen(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
      );
    });
  }
  BookingController _controller = Get.put(BookingController());

  @override
  void initState() {
    setState(() {
      _controller.currentIndex = 0;
    });
    super.initState();
  }
}

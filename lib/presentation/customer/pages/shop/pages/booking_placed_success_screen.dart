import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_primary_button.dart';
import 'package:dexter_mobile/presentation/bottom_navigation_bar_screen.dart';
import 'package:dexter_mobile/presentation/botton_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingPlaced extends StatelessWidget {
  const BookingPlaced({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationBarController>(
      init: BottomNavigationBarController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100,),
                  Image.asset(AssetPath.success, height: 250, width: 250,),
                  Text("Booking Placed", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 28, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 8,),
                  Text("Your booking has been Successfully placed, \nOur team will contact with you soon. \nFor any help, call (+234) 911 999 9996 ", textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w200),),
                  const Spacer(),
                  DexterPrimaryButton(
                    onTap: (){
                      controller.moveToBookings();
                      Get.offAll(()=> BottomNavigationBarScreen());
                    },
                    buttonBorder: greenPea, btnTitle: "View Booking",
                    borderRadius: 30, titleColor: white, btnHeight: 56, btnTitleSize: 16,
                  ),
                  const SizedBox(height: 60,),
                ],
              ),
            ),
          )
      );
    });
  }
}

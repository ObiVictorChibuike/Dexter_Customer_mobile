import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/presentation/bottom_navigation_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:get/get.dart';

class BookingAndOrderSuccessPage extends StatefulWidget {
  final String title;
  final String body;
  const BookingAndOrderSuccessPage({super.key, required this.title, required this.body});

  @override
  State<BookingAndOrderSuccessPage> createState() => _BookingAndOrderSuccessPageState();
}

class _BookingAndOrderSuccessPageState extends State<BookingAndOrderSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50),
                  Image.asset(AssetPath.success, height: 150, width: 150),
                  const SizedBox(height: 10),
                  Text(widget.title, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: black, fontSize: 22, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 15),
                  Text(widget.body, textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: greenPea, fontSize: 15, fontWeight: FontWeight.w400),),
                  const SizedBox(height: 25),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Get.offAll(()=> BottomNavigationBarScreen());
                    },
                    child: Text('Close', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: greenPea, fontSize: 18, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}

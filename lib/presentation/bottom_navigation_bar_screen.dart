import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/presentation/botton_nav_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/home/home.dart';
import 'package:dexter_mobile/presentation/customer/pages/settings/settings_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'customer/pages/transactions/transaction_page.dart';
import 'local_notification_services.dart';
import 'message/page/chat_history.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  pushNotificationOnInitConfiguration() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        Get.to(() => const BottomNavigationBarScreen());
      }
    });
    //Is called when the app is in foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
      }
      LocalNotificationService.displayNotification(message);
    });
    //Only works When the app is in background but opened
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.data);
      Get.to(() => const BottomNavigationBarScreen());
    });
  }

  List<Widget> pages = [
    const HomeScreen(),
    const TransactionScreen(),
    const ChatHistory(),
    // const MessageScreen(),
    const SettingsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder<BottomNavigationBarController>(
        init: BottomNavigationBarController(),
          builder: (controller){
        return Scaffold(
          body: pages[controller.currentIndex.value],
          backgroundColor: Colors.white,
          bottomNavigationBar: SizedBox(
            height: 80,
            child: BottomNavigationBar(
              elevation: 0.0,
              type: BottomNavigationBarType.fixed,
              iconSize: 18,
              currentIndex: controller.currentIndex.value,
              showUnselectedLabels: true,
              backgroundColor: white,
              unselectedItemColor: const Color(0xff292D32),
              selectedItemColor: greenPea,
              onTap: controller.onItemTapped,
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: const Icon(Iconsax.home),
                ),
                BottomNavigationBarItem(
                  label: 'Bookings',
                  icon: const Icon(Iconsax.activity),
                ),
                BottomNavigationBarItem(
                  label: 'Message',
                  icon: const Icon(Iconsax.message),
                ),
                BottomNavigationBarItem(
                    label: 'Settings',
                    icon: const Icon(Iconsax.setting)
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

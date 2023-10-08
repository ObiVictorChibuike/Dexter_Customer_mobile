import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'bottom_navigation_bar_screen.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize(){

    const InitializationSettings initializationSettings = InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings("@mipmap/ic_launcher")
    );
    _notificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
      final String? payload = notificationResponse.payload;
      if (notificationResponse.payload != null) {
        debugPrint('notification payload: $payload');
      }
      await Get.to(()=> const BottomNavigationBarScreen());
    });
  }
  static void displayNotification(RemoteMessage message)async {
    try{
      final id = DateTime.now().millisecondsSinceEpoch ~/1000;

       NotificationDetails notificationDetails = NotificationDetails(
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
          android: AndroidNotificationDetails(
            "dexter",
            "dexter mobile channel",
            channelDescription: "This is Dexter channel for notification",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
            icon: "@mipmap/ic_launcher",
            largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher")
          )
      );
      await _notificationsPlugin.show(
          id,
          message.notification!.title!,
          message.notification!.title!,
          notificationDetails,
        payload: message.data['id'],
      );
    }on Exception catch (e){
      print(e);
    }

  }
}
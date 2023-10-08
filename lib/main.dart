import 'package:dexter_mobile/app/shared/theme_config/theme_config.dart';
import 'package:dexter_mobile/presentation/auth/login/controller/login_controller.dart';
import 'package:dexter_mobile/presentation/bottom_navigation_bar_screen.dart';
import 'package:dexter_mobile/presentation/customer/controller/address_controller.dart';
import 'package:dexter_mobile/presentation/intro/page/onboarding_screen.dart';
import 'package:dexter_mobile/presentation/local_notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart'show kIsWeb;
import 'dart:io';
import 'package:get/get.dart';
import 'domain/local/local_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
   AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  if (message.notification != null && Platform.isIOS) {
    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.initialize();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));
  Get.put<LocalCachedData>(await LocalCachedData.create());
  final loggedIn = await LocalCachedData.instance.getLoginStatus();
  final controller = Get.put(LoginController(), permanent: true);
  controller.getAppServices();
  runApp(MyApp(loggedIn: loggedIn,));
}

class MyApp extends StatelessWidget {
  final bool? loggedIn;
  const MyApp({Key? key, this.loggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,));
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.applicationTheme(),
        home: loggedIn == true ? BottomNavigationBarScreen() : OnBoardingScreen(),
      ),
    );
  }
}


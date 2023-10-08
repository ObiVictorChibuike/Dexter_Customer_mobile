
import 'package:another_flushbar/flushbar.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FlushBarHelper{
  BuildContext? c;
  Flushbar? flush;
  String? message;
  FlushBarHelper(this.c, this.message);

  showFlushBar({Color? color, IconData? icon, Color? borderColor, Gradient? backgroundGradient, Color? textColor, Color? iconColor}){
    flush = Flushbar(
      messageText:  Text(message!, style: Theme.of(c!).textTheme.bodyText1?.copyWith(color: textColor ?? greenPea),),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      flushbarPosition: FlushbarPosition.TOP, backgroundGradient: backgroundGradient,
      backgroundColor:  Colors.white, borderColor: borderColor,
      mainButton: Icon(icon, color: iconColor ?? Colors.white, size: 25,),
      margin: EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(4),
      isDismissible: true,
      duration: const Duration(seconds: 3),
    )..show(c ?? Get.context!);
  }

  get showErrorBar => FlushBarHelper(c, message).
  showFlushBar(color: accentRed[100], icon: Icons.error, textColor: Colors.white, borderColor: Colors.red,
      backgroundGradient: LinearGradient(colors: [Colors.red, Colors.red]), iconColor: Colors.white);

  get showSuccessBar => FlushBarHelper(c, message).
  showFlushBar(icon: Icons.check_circle, color: greenPea, borderColor: greenPea, iconColor: greenPea,
      backgroundGradient: LinearGradient(colors: [greenPea, greenPea]), textColor: Colors.white);

}
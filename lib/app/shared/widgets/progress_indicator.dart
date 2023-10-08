import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:flutter/material.dart'; 

progressIndicator(BuildContext? context) {
  showDialog(
      barrierDismissible: false,
      context: context!,
      builder: (context) => Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(top: 1),
          child: LinearProgressIndicator(
            color: greenPea.withOpacity(.23),
            valueColor: AlwaysStoppedAnimation<Color>(greenPea),
          )));
 
}

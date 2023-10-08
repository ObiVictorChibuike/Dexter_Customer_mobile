import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:flutter/cupertino.dart';

class ProgressDialogHelper{
  late NAlertDialog dialog;

  dialogLoadingState(BuildContext context, String message){
    dialog = NAlertDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: const Text("Please wait"),
      content: Row(
        children: [
          FittedBox(
            child: SpinKitWanderingCubes(
              size: 20, shape: BoxShape.circle,
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? greenPea : greenPea,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 10,),
          Text(message),
        ],
      ),
      blur: 2, dismissable: false,
    );
    dialog.show(context, transitionType: DialogTransitionType.Shrink);
  }
  // hideProgressDialog(BuildContext context){
  //   Navigator.pop(context);
  // }

  get loadStateTerminated => Get.back();
  get loadingState => ProgressDialogHelper().dialogLoadingState(Get.context!, "Please wait...");
}
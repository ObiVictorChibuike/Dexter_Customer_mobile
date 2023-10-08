import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/presentation/auth/login/pages/login.dart';
import 'package:dexter_mobile/presentation/bottom_navigation_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dexter_primary_button.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Align(alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetPath.success, height: 150, width: 150,),
              const SizedBox(height: 24,),
              Text("Congratulation", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 28, fontWeight: FontWeight.w700),),
              const SizedBox(height: 8,),
              Text("A reset link has been sent to the email provided, \ncheck your inbox to reset password.", textAlign: TextAlign.center,
                  style:  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14, fontWeight: FontWeight.w400),),
              const SizedBox(height: 48,),
              DexterPrimaryButton(
                onTap: (){
                  Get.offAll(()=> const Login());
                },
                buttonBorder: greenPea, btnTitle: "Sign in",
                borderRadius: 30, titleColor: white, btnHeight: 56, btnTitleSize: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

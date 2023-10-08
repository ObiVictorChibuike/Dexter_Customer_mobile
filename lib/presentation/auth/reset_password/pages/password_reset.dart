import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_primary_button.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_text_field.dart';
import 'package:dexter_mobile/app/shared/widgets/success-screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            elevation: 0.0, backgroundColor: white,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Reset password", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 28, fontWeight: FontWeight.w700),),
                const SizedBox(height: 8,),
                Text("A verification code will be sent to your email, please \nenter your email address.", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400, fontSize: 14),),
                const SizedBox(height: 33,),
                Text('Email',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w400, fontSize: 14, color: black),
                ),
                const SizedBox(
                  height: 8,
                ),
                DexterTextField(
                  minLines: null, maxLines: 1, expands: false,
                  hintText: "abc@xyz.com",
                ),
                const SizedBox(height: 36,),
                DexterPrimaryButton(
                  onTap: (){
                    Get.to(()=> const SuccessScreen());
                  },
                  buttonBorder: greenPea, btnTitle: "Reset password",
                  borderRadius: 30, titleColor: white, btnHeight: 56, btnTitleSize: 16,
                ),
                const SizedBox(height: 48,),
                Align(alignment: Alignment.center,
                  child: RichText(text: TextSpan(text: "Already have an account? ", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray), children: [
                    TextSpan(text: "Sign in", style:  Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea))
                  ])),
                ),
              ],
            ),
          ),
        )
    );
  }
}

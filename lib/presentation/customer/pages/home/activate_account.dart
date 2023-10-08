import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_primary_button.dart';
import 'package:dexter_mobile/presentation/auth/reset_password/pages/password_reset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';

import '../../../../app/shared/widgets/numeric_keyboard.dart';


class ActivateAccount extends StatefulWidget {
  const ActivateAccount({Key? key}) : super(key: key);

  @override
  State<ActivateAccount> createState() => _ActivateAccountState();
}

class _ActivateAccountState extends State<ActivateAccount> {
  bool _onEditing = true;
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
                Text("Activate account", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 28, fontWeight: FontWeight.w700),),
                const SizedBox(height: 8,),
                Text("Please input the verification code sent to the email \nyou provided.", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400, fontSize: 14),),
                const SizedBox(height: 36,),
                Align(alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: VerificationCode(
                      fullBorder: true,
                      textStyle: TextStyle(
                          fontSize: 49.0,
                          color: Theme.of(context).textTheme.bodyText1!.color!,
                          fontWeight: FontWeight.w500),
                      keyboardType: TextInputType.number,
                      underlineColor: Theme.of(context).cardColor,
                      // If this is null it will use primaryColor: Colors.red from Theme
                      length: 4,
                      cursorColor: Colors.blue,
                      // If this is null it will default to the ambient
                      onCompleted: (String value) {

                      },
                      onEditing: (bool value) {
                        setState(() {
                          _onEditing = value;
                        });
                        if (!_onEditing) FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 56,),
                NumericKeyboard(
                    onKeyboardTap: (String text) {},
                    rightButtonFn: () {
                      HapticFeedback.heavyImpact();
                    }),
                const SizedBox(height: 76,),
                DexterPrimaryButton(
                  onTap: (){
                    Get.to(()=> const ResetPassword());
                  },
                  buttonBorder: greenPea, btnTitle: "Activate account",
                  borderRadius: 30, titleColor: white, btnHeight: 56, btnTitleSize: 16,
                ),
              ],
            ),
          ),
        )
    );
  }
}

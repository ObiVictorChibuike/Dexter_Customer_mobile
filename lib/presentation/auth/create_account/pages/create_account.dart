import 'dart:io';
import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/utils/form_mixin.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_primary_button.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_text_field.dart';
import 'package:dexter_mobile/presentation/auth/create_account/controller/controller.dart';
import 'package:dexter_mobile/presentation/auth/create_account/pages/privacy_policy.dart';
import 'package:dexter_mobile/presentation/auth/login/pages/login.dart';
import 'package:dexter_mobile/presentation/customer/widget/animated_column.dart';
import 'package:dexter_mobile/presentation/customer/widget/under_construction_dilaog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> with FormMixin{
  final buttonIcons = [
    {
      "assets": AssetPath.google,
      "title": "Google"
    },
    {
      "assets": AssetPath.apple,
      "title": "Apple"
    }
  ];
  //Form Controllers
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();

  //Keys
  final scaffoldKey = GlobalKey <ScaffoldState>();
  final formKey = GlobalKey <FormState>();

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      init: RegistrationController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            key: scaffoldKey, backgroundColor: white,
            appBar: AppBar(elevation: 0.0, backgroundColor: Colors.transparent, automaticallyImplyLeading: false,),
            body: Form(
              key: formKey,
              child: AnimatedColumn(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  Text("Create an account", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 28, fontWeight: FontWeight.w600, color: black),),
                  const SizedBox(height: 8,),
                  Text("Create your dexter account and and enjoy freedom",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: dustyGray),),
                  const SizedBox(height: 50,),
                  Platform.isAndroid ? Align(alignment: Alignment.center,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            // controller.handleSignIn(context: context);
                          },
                          child: Container(
                            height: 80, width: 85,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Container(
                                height: 30, width: 30,
                                child: Image.asset(AssetPath.google, fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("Google", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12, fontWeight: FontWeight.w600, color: dustyGray),)
                      ],
                    ),
                  ) : Align(alignment: Alignment.center,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            underConstruction(context);
                          },
                          child: Container(
                            height: 80, width: 85,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Container(
                                height: 30, width: 30,
                                child: Image.asset(
                                  AssetPath.apple, fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("Apple", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12, fontWeight: FontWeight.w600, color: dustyGray),)
                      ],
                    ),
                  ),
                  const SizedBox(height: 24,),
                  Align(alignment: Alignment.center,
                      child: Text("Or, register with email",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: black),)),
                  const SizedBox(height: 18,),
                  Text('Firstname',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w400, fontSize: 14, color: black),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DexterTextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                      ],
                    minLines: null, maxLines: 1, expands: false,
                    hintText: "John",
                    controller: firstName,
                    validator: isRequired,
                  ),
                  const SizedBox(height: 16,),
                  Text('Lastname',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w400, fontSize: 14, color: black),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DexterTextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                    ],
                    minLines: null, maxLines: 1, expands: false,
                    hintText: "Doe",
                    controller: lastName,
                    validator: isRequired,
                  ),
                  const SizedBox(height: 16,),
                  Text('Email',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w400, fontSize: 14, color: black),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DexterTextField(
                    minLines: null, maxLines: 1, expands: false,
                    hintText: "abc@xyz.com",
                    controller: email,
                    validator: isValidEmailAddress,
                  ),
                  const SizedBox(height: 16,),
                  Text('Phone no',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w400, fontSize: 14, color: black),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DexterTextField(
                    minLines: null, maxLines: 1, expands: false,
                    hintText: "080xxxxxxxx",
                    controller: phone,
                    validator: isRequired,
                  ),
                  const SizedBox(height: 16,),
                  Text('Password',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w400, fontSize: 14, color: black),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DexterTextField(
                    obscureText: _obscureText,
                    minLines: null, maxLines: 1, expands: false,
                    hintText: "*********",
                    controller: password,
                    validator: (value){
                      if(value!.isEmpty || value == ""){
                        return "This field is required";
                      }else if (value.length < 8){
                        return "Password must be up to 8 characters";
                      }
                      return null;
                    },
                    // validator: validatePassword(
                    //     shouldContainSpecialChars: true,
                    //     shouldContainCapitalLetter: true,
                    //     shouldContainNumber: true,
                    //     minLength: 8,
                    //     maxLength: 32,
                    //     errorMessage:
                    //     "Password must be up to 8 characters",
                    //     onNumberNotPresent: () {
                    //       return "Password must contain number";
                    //     },
                    //     onSpecialCharsNotPresent: () {
                    //       return "Password must contain special characters";
                    //     },
                    //     onCapitalLetterNotPresent: () {
                    //       return "Password must contain capital letters";
                    //     }),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                          _obscureText ? Iconsax.eye_slash : Iconsax.eye,
                          size: 16,
                          color: const Color(0xff292D32)),
                    ),
                  ),
                  const SizedBox(height: 31,),
                  DexterPrimaryButton(
                    onTap: () async {
                      if(formKey.currentState!.validate()){
                        formKey.currentState!.save();
                        await controller.registerUser(firstName: firstName.text, lastName: lastName.text, email: email.text, phone: phone.text, password: password.text);
                      }},
                    buttonBorder: greenPea, btnTitle: "Create an account",
                    borderRadius: 30, titleColor: white, btnHeight: 56, btnTitleSize: 16,
                  ),
                  const SizedBox(height: 24,),
                  Align(alignment: Alignment.center,
                    child: RichText(text: TextSpan(text: "Already have an account? ", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray), children: [
                      TextSpan(text: "Sign in", style:  Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea),
                        recognizer: new TapGestureRecognizer()..onTap = (){
                        Get.to(()=> const Login());
                        },),
                    ])),
                  ),
                  SizedBox(height: 26),
                  Align(alignment: Alignment.center,
                    child: RichText(textAlign: TextAlign.center,
                      text: TextSpan(text: "By continuing, you accept \nour ",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 10,),
                          children: [
                            TextSpan(text: "Term of Services ", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 10,
                              color: greenPea,),
                                recognizer: TapGestureRecognizer()..onTap = ()async{
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const PrivacyPolicy()));
                                },
                                children: [
                                  TextSpan(text: "and ", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 10), children: [
                                    TextSpan(text: "Privacy policy", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 10,
                                        color: greenPea),
                                      recognizer: TapGestureRecognizer()..onTap = ()async{
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const PrivacyPolicy()));
                                      },)
                                  ])
                                ]),
                          ]),),
                  ),
                  const SizedBox(height: 70,)
                ],
              ),
            ),
          )
      );
    });
  }
}

import 'dart:developer';
import 'package:clean_dialog/clean_dialog.dart';
import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/utils/flush_bar.dart';
import 'package:dexter_mobile/app/shared/utils/form_mixin.dart';
import 'package:dexter_mobile/app/shared/utils/progress_dialog.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_primary_button.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_text_field.dart';
import 'package:dexter_mobile/core/state/view_state.dart';
import 'package:dexter_mobile/domain/local/local_storage.dart';
import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/settings/privacy_policy.dart';
import 'package:dexter_mobile/presentation/customer/widget/view_profile_photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'contact_us.dart';
import 'faq.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with FormMixin{
  final _controller = Get.put(HomeController());
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  bool? notificationStatus;
  final formKey = GlobalKey <FormState>();
  Future<void> onInitializeLocalStorage() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    notificationStatus = await LocalCachedData.instance.getIsEnableNotificationStatus();
    log(notificationStatus.toString());
    setState(() {});
  }

  Future<void> launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  void showDeleteBottomSheet(){
    Get.bottomSheet(Container(decoration: BoxDecoration(color: white,borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/2.5,), padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ListView(
        children: [
          const SizedBox(height: 10,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Delete Account", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 16, fontWeight: FontWeight.w600),),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 30, width: 30, decoration: BoxDecoration(shape: BoxShape.circle, color: iron),
                  child: Center(
                    child: Icon(
                      Icons.clear, color: black,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 22,),
          Image.asset("assets/png/alert!.png", height: 50, width: 50,),
          const SizedBox(height: 24,),
          Text("Are you sure you want to delete your \naccount?", textAlign: TextAlign.center, style:
          Theme.of(context).textTheme.bodySmall?.copyWith(color: black, fontSize: 16, fontWeight: FontWeight.w600),),
          Text("We will hate to see you go.", textAlign: TextAlign.center, style:
          Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),),
          const SizedBox(height: 24,),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  launchUrlStart(url: "https://getdexterapp.com/delete");
                },
                child: Container(height: 38, padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(35), color: Color(0xffFCEFEF)),
                  child: Center(
                    child: Text("Delete Account", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: persianRed, fontSize: 14, fontWeight: FontWeight.w600),),
                  ),),
              ),
              const SizedBox(width: 25,),
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(height: 38, padding: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(35), color: greenPea),
                  child: Center(
                    child: Text("Cancel", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: white, fontSize: 14, fontWeight: FontWeight.w600),),
                  ),),
              ),
            ],
          )
        ],
      ),
    ), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
    ),
      isScrollControlled: true,
    );
  }

  @override
  void initState() {
    firstNameController.text = _controller.profileResponse!.data!.firstName!;
    lastNameController.text = _controller.profileResponse!.data!.lastName!;
    emailController.text = _controller.profileResponse!.data!.email!;
    onInitializeLocalStorage();
    super.initState();
  }
  final dexterSettings = [
    {
      "assets": AssetPath.call,
      "title": "Contact Us"
    },
    {
      "assets": AssetPath.faq,
      "title": "FAQs"
    },
    {
      "assets": AssetPath.privacyPolicy,
      "title": "Privacy Policy"
    },
    {
      "assets": AssetPath.about,
      "title": "About Dexter"
    },
  ];

  void updateProfile(BuildContext context,)async{
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      ProgressDialogHelper().loadingState;
      await _controller.updateUserProfile(firstNameController.text, lastNameController.text, emailController.text);
      if(_controller.updateUserProfileViewState.state == ResponseState.COMPLETE){
        setState((){
          firstNameController.text = _controller.profileResponse!.data!.firstName!;
          lastNameController.text = _controller.profileResponse!.data!.lastName!;
          emailController.text = _controller.profileResponse!.data!.email!;
        });
        ProgressDialogHelper().loadStateTerminated;
        // Get.offAll(()=> BottomNavigationBarScreen());
        FlushBarHelper(context, "Profile Updated Successfully").showSuccessBar;
      }else if(_controller.updateUserProfileViewState.state == ResponseState.ERROR){
        ProgressDialogHelper().loadStateTerminated;
        FlushBarHelper(context, _controller.errorMessage).showErrorBar;
      }
    }
  }

  Future<bool> _updateProfile() async {
    Widget cancelButton = TextButton(
      child: Text("NO", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 16, fontWeight: FontWeight.w800)),
      onPressed:  () {
        Get.back();
      },
    );

    Widget continueButton = Form(
      key: formKey,
      child: TextButton(
        child: Text("YES", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 16, fontWeight: FontWeight.w800)),
        onPressed:  () {
          Get.back();
          updateProfile(context);
        },
      ),
    );

    AlertDialog alert = AlertDialog(
      content: Text("Are you sure you want to continue this operation"
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return (await showDialog(
      context: context,
      builder: (context) => alert,
    )) ?? false;
  }


  void showEditProfileBottomSheet({required String imagePath}){
    Get.bottomSheet(Container(decoration: BoxDecoration(color: white,borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/1.5,), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: ListView(
        children: [
          const SizedBox(height: 10,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Edit Profile", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 18, fontWeight: FontWeight.w600),),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 30, width: 30, decoration: BoxDecoration(shape: BoxShape.circle, color: iron),
                  child: Center(
                    child: Icon(
                      Icons.clear, color: black,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20,),
          Align(alignment: Alignment.center, child: ClipRRect(borderRadius: BorderRadius.circular(40),
            child: Container(height: 80, width: 80, decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image.network(imagePath, height: 80, width: 80, fit: BoxFit.cover,)),
          )),
          const SizedBox(height: 30,),
          Text('First Name',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400, fontSize: 14, color: black),),
          const SizedBox(height: 8,),
          DexterTextField(
            minLines: null,
            maxLines: 1, expands: false,
            hintText: "John Doe",
            controller: firstNameController,
            validator: isRequired,
          ),
          const SizedBox(height: 16,),
          Text('Last Name',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w400, fontSize: 14, color: black),
          ),
          const SizedBox(
            height: 8,
          ),
          DexterTextField(
            minLines: null,
            maxLines: 1, expands: false,
            hintText: "John Doe",
            controller: lastNameController,
            validator: isRequired,
          ),
          const SizedBox(height: 16,),
          Text('Email', style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w400, fontSize: 14, color: black),
          ),
          const SizedBox(
            height: 8,
          ),
          DexterTextField(
            minLines: null,
            maxLines: 1, expands: false,
            hintText: "abc@xyz.com",
            controller: emailController,
            validator: isValidEmailAddress,
          ),
          // DexterPrimaryButton(
          //   onTap: (){
          //     Navigator.of(context).pop();
          //     showChangePasswordBottomSheet(context);
          //   },
          //   buttonWidget: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Text(
          //         "Change Password",
          //         textAlign: TextAlign.left,
          //         style: TextStyle(
          //           fontWeight: FontWeight.w600,
          //           fontSize: 12,
          //           letterSpacing: 0.27,
          //           color: greenPea,
          //         ),
          //       ),
          //       Icon(Icons.arrow_forward, color: greenPea,)
          //     ],
          //   ),
          //   buttonBorder: greenPea, btnHeight: 52, btnTitleSize: 14, borderRadius: 35, btnColor: white, titleColor: greenPea,
          //   btnWidth: MediaQuery.of(context).size.width,
          // ),
          const SizedBox(height: 26,),
          DexterPrimaryButton(
            buttonBorder: greenPea, btnHeight: 52, btnTitleSize: 14, borderRadius: 35,
            btnTitle: "Save changes", btnColor: greenPea, titleColor: white,
            btnWidth: MediaQuery.of(context).size.width,
            onTap: (){
              Get.back();
              _updateProfile();
            },
          ),
        ],
      ),
    ), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
    ),
      isScrollControlled: true,
    );
  }

  showSignOutDialog(){
    showDialog(
      context: context,
      builder: (context) => CleanDialog(
        title: 'Sign Out',
        content: "Do you want to sign out from vendor app?",
        backgroundColor: greenPea,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
        actions: [
          CleanDialogActionButtons(
              actionTitle: 'Yes',
              textColor: greenPea,
              onPressed: () async {
                log("message");
                Get.back();
                _controller.logOut(context: context);
                Get.deleteAll();
              }
          ),
          CleanDialogActionButtons(
              actionTitle: 'No',
              textColor: persianRed,
              onPressed: (){
                Navigator.pop(context);
              }
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
            resizeToAvoidBottomInset: false, extendBodyBehindAppBar: true,
            backgroundColor: white,
            appBar: AppBar(
              elevation: 0.0, backgroundColor: white, actions: [
              GestureDetector(
                onTap: (){
                  showSignOutDialog();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 20),
                  child: Text("Sign out", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: persianRed, fontSize: 14, fontWeight: FontWeight.w600),),
                ),
              ),
            ],
              title: Text("Settings", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 20, fontWeight: FontWeight.w700),),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 22,),
                  Align(alignment: Alignment.center, child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ViewProfilePhoto(controller.profileResponse?.data?.coverImage ?? profilePicturePlaceHolder);
                        }));
                      },
                      child: Hero(
                        tag: "profile_photo",
                        child: Container(
                          height: 86, width: 86,
                          decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(controller.profileResponse?.data?.coverImage ?? profilePicturePlaceHolder), fit: BoxFit.cover)),
                        ),
                      ))),
                  const SizedBox(height: 8,),
                  GestureDetector(
                    onTap: (){
                      showEditProfileBottomSheet(imagePath: controller.profileResponse?.data?.coverImage ?? profilePicturePlaceHolder);
                    },
                    child: Align(alignment: Alignment.center,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${firstNameController.text} ${lastNameController.text}",
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 18, fontWeight: FontWeight.w700),),
                            Icon(Icons.mode_edit_outlined, color: greenPea, size: 15,)
                          ],
                        )),
                  ),
                  const SizedBox(height: 39,),
                  Align(alignment: Alignment.centerLeft,
                      child: Text("Notification", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray, fontSize: 14, fontWeight: FontWeight.w400),)),
                  const SizedBox(height: 31,),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                              height: 50,
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(AssetPath.pushNotification, height: 35, width: 35,),
                                      const SizedBox(width: 16,),
                                      Text("Push Notification", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: thunder, fontSize: 14),),
                                    ],
                                  ),
                                  CupertinoSwitch(
                                      activeColor: greenPea,
                                      value: _controller.notificationStatus ?? false, onChanged: (value) async {
                                    if(value == true){
                                      _controller.sendUserFcmToken();
                                    }else{
                                      _controller.deleteFcmToken();
                                    }
                                  })
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35,),
                  Align(alignment: Alignment.centerLeft,
                      child: Text("Dexter", style:
                      Theme.of(context).textTheme.bodySmall!.
                      copyWith(color: dustyGray, fontSize: 14, fontWeight: FontWeight.w400),)),
                  const SizedBox(height: 24,),
                  ...List.generate(dexterSettings.length, (index) => GestureDetector(
                    onTap: (){
                      index == 1 ? Get.to(()=> const Faqs()) : index == 2 ? Get.to(()=> PrivacyPolicyScreen()) :
                      index == 0 ? Get.to(()=> ContactUsScreen()) : null;
                    },
                    child: Container(
                        height: 50, color: Colors.white,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(dexterSettings[index]["assets"]!, height: 35, width: 35,),
                                const SizedBox(width: 16,),
                                Text(dexterSettings[index]["title"]!, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: thunder, fontSize: 14),),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios_outlined, color: black, size: 16,)
                          ],
                        )
                    ),
                  ),),
                  const SizedBox(height: 26,),
                  GestureDetector(
                    onTap: (){
                      showDeleteBottomSheet();
                    },
                    child: Container(height: 40, padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35), color: Color(0xffFCEFEF)),
                      child: Center(
                        child: Text("Delete Account", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: persianRed, fontSize: 14, fontWeight: FontWeight.w600),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      );
    });
  }
}

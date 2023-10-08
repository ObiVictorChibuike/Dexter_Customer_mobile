import 'dart:io';
import 'package:clean_dialog/clean_dialog.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_primary_button.dart';
import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ViewProfilePhoto extends StatefulWidget {
  const ViewProfilePhoto(this.imageUrl);
  final String? imageUrl;

  @override
  State<ViewProfilePhoto> createState() => _ViewProfilePhotoState();
}

class _ViewProfilePhotoState extends State<ViewProfilePhoto> {

  showAlertDialog(HomeController controller){
    showDialog(
      context: context,
      builder: (context) => CleanDialog(
        title: 'Do you want to discard ?',
        content: "You have not updated the selected image. Do you want to discard ?",
        backgroundColor: greenPea,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),
        contentTextStyle: const TextStyle(fontSize: 13, color: Colors.white,),
        actions: [
          CleanDialogActionButtons(
              actionTitle: 'Discard',
              textColor: greenPea,
              onPressed: (){
                setState(() {
                  controller.updateProfilePhoto = null;
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              }
          ),
          CleanDialogActionButtons(
            actionTitle: 'Cancel',
            textColor: persianRed,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  updateProfilePicture(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller){
              return SimpleDialog(
                backgroundColor: Colors.white,
                title: Text('Update product photo', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18, fontWeight: FontWeight.w700),),
                children: [
                  SimpleDialogOption(
                    padding: EdgeInsets.all(20),
                    child: Text('Take a photo'),
                    onPressed: () async {
                      Get.back();
                      controller.onUploadProductPhoto(ImageSource.camera);
                      setState(() {});
                    },
                  ),
                  SimpleDialogOption(
                    padding: EdgeInsets.all(20),
                    child: Text('Choose from Gallery'),
                    onPressed: () async {
                      Get.back();
                      controller.onUploadProductPhoto(ImageSource.gallery);
                      setState(() {});
                    },
                  ),
                  SimpleDialogOption(
                    padding: EdgeInsets.all(20),
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: white, elevation: 0,
        actions: [
          // Icon(Icons.share, color: greenPea, size: 23,),
          // const SizedBox(width: 16,),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: (){
                  updateProfilePicture(context);
                },
                child: Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.edit, color: greenPea, size: 15,),
                    Text("Edit", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: greenPea, fontSize: 15, fontWeight: FontWeight.w500, decoration: TextDecoration.underline),),
                  ],
                ),
              ),
            ),
          ),
        ],
        title: Text("Profile photo", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w800, fontSize: 18),),
        leading: GestureDetector(
          onTap: (){
            if(homeController.updateProfilePhoto != null){
              showAlertDialog(homeController);
            }else{
              homeController.getProfile();
              Navigator.pop(context);
            }
          },
            child: Icon(Icons.arrow_back_ios_new, color: Colors.black,)),),
      body: GetBuilder<HomeController>(
        init: HomeController(),
          builder: (controller){
        return Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            GestureDetector(
              child: Center(
                child: Hero(
                  tag: 'profile_photo',
                  child: controller.updateProfilePhoto != null ? Image.file(File(controller.updateProfilePhoto!.path),
                    fit: BoxFit.fill, height: MediaQuery.of(context).size.height /2.0, width: double.maxFinite,) :
                  Image.network(
                    widget.imageUrl ?? imagePlaceHolder,
                    fit: BoxFit.fill, height: MediaQuery.of(context).size.height /2.0, width: double.maxFinite,
                  ),
                ),
              ),
              onTap: () {
                if(controller.updateProfilePhoto != null){
                  showAlertDialog(controller);
                }else{
                  homeController.getProfile();
                  Navigator.pop(context);
                }
              },
            ),
            const Spacer(flex: 2,),
            controller.updateProfilePhoto != null ?
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DexterPrimaryButton(
                    onTap: () async {
                      if(controller.updateProfilePhoto == null){
                        Get.snackbar("Error","Please add a passport photograph");
                      }else{
                        await controller.updateProfilePicture();
                      }
                    },
                    btnTitle: "Update", btnTitleSize: 16, borderRadius: 35, btnHeight: 56,
                    btnWidth: MediaQuery.of(context).size.width,
                  ),
                ),
                const SizedBox(height: 60,),
              ],
            ) : const SizedBox()
          ],
        );
      })
    );
  }
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    homeController.updateProfilePhoto = null;
    setState(() {});
    super.initState();
  }
}
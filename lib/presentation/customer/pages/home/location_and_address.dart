import 'dart:developer';

import 'package:clean_dialog/clean_dialog.dart';
import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_primary_button.dart';
import 'package:dexter_mobile/app/shared/widgets/error_screen.dart';
import 'package:dexter_mobile/domain/local/local_storage.dart';
import 'package:dexter_mobile/presentation/customer/controller/address_controller.dart';
import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
import 'package:dexter_mobile/presentation/customer/widget/animated_column.dart';
import 'package:dexter_mobile/presentation/customer/widget/circular_loading_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:uuid/uuid.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/secret_keys.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:iconsax/iconsax.dart';


class LocationAndAddress extends StatefulWidget {
  const LocationAndAddress({Key? key}) : super(key: key);

  @override
  State<LocationAndAddress> createState() => _LocationAndAddressState();
}

class _LocationAndAddressState extends State<LocationAndAddress> {
  HomeController homeController = Get.find<HomeController>();
  bool dropDownSuggestion1 = false;
  List<AutocompletePrediction> predictions = [];
  final addressController = Get.find<AddressController>();
  late GooglePlace googlePlace;
  TextEditingController searchAddressController = TextEditingController();
  void autoCompleteSearch(String value) async {
    final sessionToken = Uuid().v4();
    var result = await googlePlace.autocomplete.get(value, sessionToken: sessionToken, region: "ng");
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  setDeliveryAddressDialog({required String address, required String addressId}){
    showDialog(
      context: context,
      builder: (context) => CleanDialog(
        title: 'Set Delivery Address',
        content: "Are you sure you want to set this as your delivery location?",
        backgroundColor: greenPea,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
        actions: [
          CleanDialogActionButtons(
              actionTitle: 'Ok',
              textColor: greenPea,
              onPressed: () async {
                Get.put<LocalCachedData>(await LocalCachedData.create());
                await LocalCachedData.instance.cacheSelectedLocation(location: address);
                await LocalCachedData.instance.cacheSelectedLocationId(locationId: addressId);
                Navigator.pop(context);
                Get.snackbar("Success", "You successfully set your delivery address", colorText: white, backgroundColor: greenPea);
              }
          ),
          CleanDialogActionButtons(
              actionTitle: 'Cancel',
              textColor: persianRed,
              onPressed: (){
                Navigator.pop(context);
              }
          ),
        ],
      ),
    );
  }

  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final editStreetController = TextEditingController();
  final editCityController = TextEditingController();
  final editStateController = TextEditingController();
  final editCountryController = TextEditingController();
  final addressId = TextEditingController();

  void showEditAddressBottomSheet({required String addressId}){
    Get.bottomSheet(Container(decoration: BoxDecoration(color: white,borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/1.5,), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            const SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
            Text("Add Delivery Address", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 18, fontWeight: FontWeight.w600),),
            const SizedBox(height: 8,),
            Align(alignment: Alignment.centerLeft, child: Text("Kindly add delivery address as you would have to pick one of these address when booking a services or placing an order",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400, fontSize: 14, color: greenPea),),),
            const SizedBox(height: 20,),
            Text('Address',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w400, fontSize: 14, color: black),
            ),
            const SizedBox(height: 8,),
            DexterTextField(
              controller: editStreetController,
              minLines: null, maxLines: 1, expands: false,
              hintText: "",
              validator: (value){
                if(value!.isEmpty){
                  return "Please enter address street";
                }
                return null;
              },
            ),
            const SizedBox(height: 16,),
            Text('City',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w400, fontSize: 14, color: black),
            ),
            const SizedBox(height: 8,),
            DexterTextField(
              controller: editCityController,
              minLines: null, maxLines: 1, expands: false,
              hintText: "",
              validator: (value){
                if(value!.isEmpty){
                  return "Please enter address city";
                }
                return null;
              },
            ),
            const SizedBox(height: 16,),
            Row(
              children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Address State',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 14, color: black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                          errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                        ),
                        isExpanded: true,
                        hint: Text(editStateController.text, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14)),
                        items: addressController.state.map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item ?? "", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 15)),
                        )).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Kindly select your address state';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          editStateController.text = value.toString();
                        },
                        buttonStyleData: ButtonStyleData(height: 50, padding: EdgeInsets.only(left: 0, right: 10),
                            decoration: BoxDecoration(color: Color(0xffEFEFF0), borderRadius: BorderRadius.circular(20), border: Border.all(color: Color(0xff868484), width: 0.7))),
                        iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down, color: black, size: 18,), iconSize: 30,),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16,),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Address Country',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 14, color: black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                          errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                        ),
                        isExpanded: true,
                        hint: Text(editCountryController.text, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14)),
                        items: addressController.country.map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item ?? "", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 15)),
                        )).toList(),
                        validator: (value) {
                          if (value == null || value == "") {
                            return 'Kindly select your address country';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          editCountryController.text = value.toString();
                        },
                        buttonStyleData: ButtonStyleData(height: 50, padding: EdgeInsets.only(left: 0, right: 10),
                            decoration: BoxDecoration(color: Color(0xffEFEFF0), borderRadius: BorderRadius.circular(20), border: Border.all(color: Color(0xff868484), width: 0.7))),
                        iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down, color: black, size: 18,), iconSize: 30,),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40,),
            DexterPrimaryButton(
              onTap: () async {
                if(formKey.currentState!.validate()){
                  Get.back();
                  addressController.editAddress(street: editStreetController.text,
                      city: editCityController.text, state: editStateController.text, country: editCountryController.text, addressId: addressId);
                }
              },
              buttonBorder: greenPea, btnTitle: "Edit Address",
              borderRadius: 30, titleColor: white, btnHeight: 56, btnTitleSize: 16,
            )
          ],
        ),
      ),
    ), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
    ),
      isScrollControlled: true,
    );
  }

  final formKey = GlobalKey <FormState>();
  void showAddAddressBottomSheet(){
    Get.bottomSheet(Container(decoration: BoxDecoration(color: white,borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/1.5,), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            const SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
            Text("Add Delivery Address", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 18, fontWeight: FontWeight.w600),),
            const SizedBox(height: 8,),
            Align(alignment: Alignment.centerLeft, child: Text("Kindly add delivery address as you would have to pick one of these address when booking a services or placing an order",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400, fontSize: 14, color: greenPea),),),
            const SizedBox(height: 20,),
            Text('Address',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w400, fontSize: 14, color: black),
            ),
            const SizedBox(height: 8,),
            DexterTextField(
              controller: streetController,
              minLines: null, maxLines: 1, expands: false,
              hintText: "",
              validator: (value){
                if(value!.isEmpty){
                  return "Please enter address street";
                }
                return null;
              },
            ),
            const SizedBox(height: 16,),
            Text('City',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w400, fontSize: 14, color: black),
            ),
            const SizedBox(height: 8,),
            DexterTextField(
              controller: cityController,
              minLines: null, maxLines: 1, expands: false,
              hintText: "",
              validator: (value){
                if(value!.isEmpty){
                  return "Please enter address city";
                }
                return null;
              },
            ),
            const SizedBox(height: 16,),
            Row(
              children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('State',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 14, color: black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                          errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                        ),
                        isExpanded: true,
                        hint: Text("", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xff868484), fontSize: 15)),
                        items: addressController.state.map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item ?? "", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 15)),
                        )).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Kindly select your address state';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          stateController.text = value.toString();
                        },
                        buttonStyleData: ButtonStyleData(height: 50, padding: EdgeInsets.only(left: 0, right: 10),
                            decoration: BoxDecoration(color: Color(0xffEFEFF0), borderRadius: BorderRadius.circular(20), border: Border.all(color: Color(0xff868484), width: 0.7))),
                        iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down, color: black, size: 18,), iconSize: 30,),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16,),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Country',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 14, color: black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                          errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                        ),
                        isExpanded: true,
                        hint: Text("", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xff868484), fontSize: 15)),
                        items: addressController.country.map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item ?? "", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 15)),
                        )).toList(),
                        validator: (value) {
                          if (value == null || value == "") {
                            return 'Kindly select your address country';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          countryController.text = value.toString();
                        },
                        buttonStyleData: ButtonStyleData(height: 50, padding: EdgeInsets.only(left: 0, right: 10),
                            decoration: BoxDecoration(color: Color(0xffEFEFF0), borderRadius: BorderRadius.circular(20), border: Border.all(color: Color(0xff868484), width: 0.7))),
                        iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down, color: black, size: 18,), iconSize: 30,),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40,),
            DexterPrimaryButton(
              onTap: () async {
                if(formKey.currentState!.validate()){
                  Get.back();
                  addressController.addAddress(street: streetController.text,
                      city: cityController.text, state: stateController.text, country: countryController.text);
                }
              },
              buttonBorder: greenPea, btnTitle: "Add Address",
              borderRadius: 30, titleColor: white, btnHeight: 56, btnTitleSize: 16,
            )
          ],
        ),
      ),
    ), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
    ),
      isScrollControlled: true,
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: persianRed,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  @override
  void initState() {
    String apiKey = SecretKeys().apiKey;
    googlePlace = GooglePlace(apiKey);
    addressController.getUserAddress();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
      init: AddressController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
              backgroundColor: white,
              appBar: AppBar(
                centerTitle: false, elevation: 0, backgroundColor: white,
                actions: [
                  GestureDetector(
                    onTap: ()=>showAddAddressBottomSheet(),
                    child: Container(margin: EdgeInsets.only(right: 15, top: 15, bottom: 15),padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: greenPea, borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Row(
                          children: [
                            Icon(Iconsax.add, size: 20, color: white,),
                            Text("Add address", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white, fontWeight: FontWeight.w700),)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
                leading: GestureDetector(
                    onTap: (){
                      homeController.getSelectedAddress();
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(color: Color(0xffF2F2F2), shape: BoxShape.circle),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    )),
                title: Text("Address", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 20, fontWeight: FontWeight.w700),),),
              body: controller.addressResponseModel == null || controller.addressResponseModel!.isEmpty && controller.isLoadingAddress == true && controller.isLoadingAddressHasError == false ?
              CircularLoadingWidget() : controller.addressResponseModel == null || controller.addressResponseModel!.isEmpty && controller.isLoadingAddress == false && controller.isLoadingAddressHasError == false ?
              Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AssetPath.emptyFile, height: 120, width: 120,),
                    const SizedBox(height: 40,),
                    Text("No address added",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray, fontSize: 14, fontWeight: FontWeight.w400),),
                    const SizedBox(height: 40,),
                    GestureDetector(
                      onTap: ()=>showAddAddressBottomSheet(),
                      child: Text("Click here to add address",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 14,
                            fontWeight: FontWeight.w400, decoration: TextDecoration.underline),),
                    ),
                  ],
                ),
              ) : controller.addressResponseModel != null || controller.addressResponseModel!.isNotEmpty && controller.isLoadingAddress == false && controller.isLoadingAddressHasError == false ?
              AnimatedColumn(children: [
                const SizedBox(height: 24,),
                ...List.generate(controller.addressResponseModel!.length, (index) =>
                    Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setDeliveryAddressDialog(address: controller.addressResponseModel![index].fullAddress!, addressId: controller.addressResponseModel![index].id.toString());
                          },
                          child: Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
                                Icon(Iconsax.location, color: greenPea,),
                                const SizedBox(width: 15,),
                                Expanded(
                                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.addressResponseModel?[index].fullAddress ?? "", overflow: TextOverflow.ellipsis, maxLines: 3, style:
                                      Theme.of(context).textTheme.bodySmall?.copyWith(color: black, fontSize: 13, fontWeight: FontWeight.w400),),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap: (){
                                      addressId.text = controller.addressResponseModel![index].id.toString();
                                      final i = controller.addressResponseModel?.indexWhere((element) => element.id.toString() == addressId.text);
                                      editStreetController.text = controller.addressResponseModel![i!].street!;
                                      editStateController.text = controller.addressResponseModel![i].state!;
                                      editCityController.text = controller.addressResponseModel![i].city!;
                                      editCountryController.text = controller.addressResponseModel![i].country!;
                                      log("12");
                                      showEditAddressBottomSheet(addressId: controller.addressResponseModel![index].id!.toString());
                                    }, child: Icon(Icons.save_as_outlined, color: greenPea, size: 15,)),
                              ],
                            ),),
                        ),
                        const Divider()
                      ],
                    ),),
              ], padding: EdgeInsets.symmetric(horizontal: 20))  :
              controller.addressResponseModel == null || controller.addressResponseModel!.isEmpty && controller.isLoadingAddress == false && controller.isLoadingAddressHasError == true ?
              ErrorScreen() : CircularLoadingWidget(),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: ListView(
              //       children: [
              //         DexterTextField(
              //             onChanged: (value) {
              //               dropDownSuggestion1 = true;
              //               if (value.isNotEmpty) {
              //                 autoCompleteSearch(value);
              //               } else {
              //                 if (predictions.length > 0 && mounted) {
              //                   setState(() {
              //                     predictions = [];
              //                   });
              //                 }
              //               }
              //             },
              //             controller: searchAddressController,
              //             filledColor: Colors.transparent,
              //             minLines: null, maxLines: 1, expands: false,
              //             hintText: "Enter your address?",
              //             prefixIcon: Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Icon(Iconsax.location, color: black,),
              //             ),
              //             suffixIcon: searchAddressController.text.isEmpty ? const SizedBox.shrink() : Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: GestureDetector(
              //                 onTap: (){
              //                   searchAddressController.clear();
              //                   dropDownSuggestion1 = false;
              //                   setState((){});
              //                 },
              //                   child: Icon(Icons.clear, color: black,)),
              //             ),
              //         ),
              //         dropDownSuggestion1 == true
              //             ? SizedBox(
              //           width: double.infinity,
              //           height: 300,
              //           child: ListView.builder(
              //             padding: EdgeInsets.zero,
              //             shrinkWrap: true,
              //             itemCount: predictions.length,
              //             itemBuilder: (context, index) {
              //               return ListTile(
              //                 leading: SvgPicture.asset(AssetPath.navigation),
              //                 title: Text('${predictions[index].description}'),
              //                 onTap: () {
              //                   setState(() {
              //                     searchAddressController.text = '${predictions[index].description}';
              //                     homeController.address = '${predictions[index].description}';
              //                     dropDownSuggestion1 = false;
              //                   });
              //                   FocusManager.instance.primaryFocus?.unfocus();
              //                 },
              //               );
              //             },
              //           ),
              //         )
              //             : dropDownSuggestion1 == false ? SizedBox(height: 300,
              //           // child: ListView(
              //           //   physics: const BouncingScrollPhysics(),
              //           //   children: [
              //           //     ...List.generate(_controller.userAddresses!.reversed.length, (index){
              //           //       return ListTile(
              //           //         leading: SvgPicture.asset(AssetPath.navigation),
              //           //         title: Text('${_controller.userAddresses![index].address}'),
              //           //         onTap: (){
              //           //           homeController.address = '${_controller.userAddresses![index].address}';
              //           //           Get.back();
              //           //         },
              //           //       );
              //           //     })
              //           //   ],
              //           // ),
              //         ) : const SizedBox.shrink(),
              //       ]
              //   ),
              // )
          )
      );
    });
  }
}

import 'dart:developer';
import 'dart:io';
import 'package:clean_dialog/clean_dialog.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/utils/flush_bar.dart';
import 'package:dexter_mobile/app/shared/utils/form_mixin.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_primary_button.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_text_field.dart';
import 'package:dexter_mobile/data/business_services/business_details_model_response.dart';
import 'package:dexter_mobile/domain/local/local_storage.dart';
import 'package:dexter_mobile/presentation/bottom_navigation_bar_screen.dart';
import 'package:dexter_mobile/presentation/customer/controller/address_controller.dart';
import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/repair_services/controller/bookable_services_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class ServiceBookingScreen extends StatefulWidget {
  final GetBusinessDetailsResponseModel? getBusinessDetailsResponseModel;
  const ServiceBookingScreen({Key? key, this.getBusinessDetailsResponseModel}) : super(key: key);

  @override
  State<ServiceBookingScreen> createState() => _ServiceBookingScreenState();
}

class _ServiceBookingScreenState extends State<ServiceBookingScreen> with FormMixin{
  final _controller = Get.put(BookableServicesController());
  final addressController = Get.find<AddressController>();
  final addressId = TextEditingController();
  String? selectedAddress;
  String? selectedAddressId;
  final formKey = GlobalKey <FormState>();

  String getDate(String date) {
    final formattedDate = Jiffy(date).yMMMMd;
    return formattedDate;
  }

  void showRepairPromptBottomSheet({required String message,required String formattedDate, required String displayDate, required String address, required BookableServicesController controller}){
    Get.bottomSheet(
      StatefulBuilder(builder: (context, update){
        return Container(decoration: BoxDecoration(color: white,borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),),
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/1.7,),
          child: Column(
            children: [
              Container(height: MediaQuery.of(context).size.height / 4.2, width: double.maxFinite,
                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(widget.getBusinessDetailsResponseModel?.data?.coverImage ?? imagePlaceHolder), fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                padding: EdgeInsets.only(left: 18, right: 18, top: 20),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        GestureDetector(
                          onTap: (){
                            _controller.update();
                            Get.back();
                          },
                          child: Container(
                            height: 25, width: 25,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: white),
                            child: Center(child: Icon(Icons.clear, color: black,)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 10,),
                    Expanded( flex: 2,child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.getBusinessDetailsResponseModel?.data?.name ?? "",
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: black, fontWeight: FontWeight.w700, fontSize: 16),),
                        const Divider(),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Iconsax.clock, color: black, size: 12,),
                                const SizedBox(width: 5,),
                                Text('Open Time ', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: black),)
                              ],
                            ),
                            RichText(text: TextSpan(text: "${widget.getBusinessDetailsResponseModel?.data?.openingTime?.substring(0,5) ?? ""} AM", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w400, fontSize: 10, color: greenPea)),),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Iconsax.clock, color: black, size: 12,),
                                const SizedBox(width: 5,),
                                Text('Close Time ', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: black),)
                              ],
                            ),
                            RichText(text: TextSpan(text: "${widget.getBusinessDetailsResponseModel?.data?.closingTime?.substring(0,5) ?? ""} PM", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w400, fontSize: 10, color: greenPea)),),
                          ],
                        ),
                      ],
                    ),),
                    const Spacer(),
                    Expanded(flex: 2,
                        child: Row(
                      children: [
                        Icon(Iconsax.calendar, color: black, size: 20,),
                        const SizedBox(width: 5,),
                        Text("${displayDate}", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 12),),
                      ],
                    ))
                  ],
                ),
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Text("Average Service Fee:",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 12),),
                    const SizedBox(width: 5,),
                    RichText(text: TextSpan(text: " ", style: Theme.of(context).textTheme.bodyText1?.copyWith(color: black, fontWeight: FontWeight.w300, fontSize: 12),
                        children: [TextSpan(text: "NGN ${widget.getBusinessDetailsResponseModel?.data?.serviceCharge ?? ""}",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: greenPea, fontWeight: FontWeight.w300, fontSize: 10))]))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child:  Row(
                  children: [
                    Icon(Icons.location_on, color: persianRed, size: 15,),
                    const SizedBox(width: 5,),
                    Expanded(
                      child: RichText(text: TextSpan(text: " ", style: Theme.of(context).textTheme.bodyText1?.copyWith(color: black, fontWeight: FontWeight.w300, fontSize: 12),
                          children: [TextSpan(text: address,
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: greenPea, fontWeight: FontWeight.w300, fontSize: 10))])),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DexterPrimaryButton(
                  onTap: (){
                    Get.back();
                    controller.createBooking(businessId: widget.getBusinessDetailsResponseModel!.data!.id.toString(), addressId: addressId.text, scheduleDate: formattedDate, notes: _controller.messageController.text);
                  },
                  buttonBorder: greenPea, btnTitle: "Schedule Booking",
                  borderRadius: 30, titleColor: white, btnHeight: 56, btnTitleSize: 16,
                ),
              ),
            ],
          ),
        );
      }), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),),
      isScrollControlled: true, isDismissible: false,
    );
  }

  _showImagePickerDialog() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(180, 45), backgroundColor: greenPea),
                    onPressed: () {
                      Get.back();
                      _controller.onUploadImage();
                    },
                    child: const Text("Open Gallery"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _commentForm(){
    var maxLine = 8;
    return Container(height: maxLine * 20.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: TextFormField(
        validator: (value){
          if(value!.isEmpty || value == ""){
            return 'Kindly attach a brief note';
          }
          return null;
        },
        cursorHeight: 17,  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 15),
        minLines: null, maxLines: maxLine, expands: false,
        controller: _controller.messageController,
        textInputAction: TextInputAction.next, keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          counterText: " ",
          hintText: "Please specify whatever information we need \nto serve you better",
          hintStyle: TextStyle(fontSize: 14),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
          fillColor: Color(0xffEFEFF0),
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.all(13),
        ),
        cursorColor: Colors.black,
      ),
    );
  }
  DateTime? formattedDate;
  _selectDateOfAppointment(BuildContext context, BookableServicesController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3030),
      helpText: 'SELECT APPOINTMENT DATE',
      confirmText: 'SELECT',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: greenPea,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
        formattedDate = inputFormat.parse(picked.toString());
        var outputFormat = DateFormat('dd/MM/yyyy');
        controller.dateOfAppointment.text = getDate(picked.toString());
        print(controller.dateOfAppointment.text);
      });
    }
  }

  showAddressDialog(){
    showDialog(
      context: context,
      builder: (context) => CleanDialog(
        title: 'Address Notice',
        content: "You don't have any address yet. kindly add a address from the dashboard to proceed.",
        backgroundColor: greenPea,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
        actions: [
          CleanDialogActionButtons(
              actionTitle: 'Move to Dashboard',
              textColor: greenPea,
              onPressed: (){
                Navigator.pop(context);
                Get.offAll(()=>BottomNavigationBarScreen());
                //Get.offUntil(MaterialPageRoute(builder: (BuildContext context)=> BottomNavigationBarScreen()), (route) => false);
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

  Future<void> getSelectedAddress() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    await LocalCachedData.instance.getSelectedLocation().then((value){
      log(value.toString());
      if(value != null && value != ""){
        selectedAddress = value;
        setState(() {});
      }
    });
    await LocalCachedData.instance.getSelectedLocationId().then((value){
      if(value != null && value != ""){
        addressId.text = value;
        setState(() {});
      }
    });
  }
  @override
  void initState() {
    getSelectedAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookableServicesController>(
      init: BookableServicesController(),
        builder: (controller){
          return SafeArea(top: false, bottom: false,
              child: Scaffold(
                backgroundColor: white,
                appBar: AppBar(
                  centerTitle: true,
                  leading: GestureDetector(
                      onTap: (){
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
                  elevation: 0.0, backgroundColor: white,
                  title: Text("Book Services", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 20, fontWeight: FontWeight.w700),),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: formKey,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SizedBox(height: 15,),
                        Text('Booking Address',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 14, color: black),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(height: 75,
                          child: GestureDetector(
                            onTap: (){
                              if(addressController.addressResponseModel == [] || addressController.addressResponseModel!.isEmpty){
                                showAddressDialog();
                              }else{
                                null;
                              }
                            },
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                counterText: " ",
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
                              hint: Text(selectedAddress ?? "Address", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: selectedAddress == null ? Color(0xff868484) : black, fontSize: 15)),
                              items: addressController.addressResponseModel!.map((item) => DropdownMenuItem<String>(
                                value: item.id.toString() ?? "",
                                child: Text(item.fullAddress ?? "", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 15)),
                              )).toList(),
                              validator: (value) {
                                if (value == null && selectedAddress == null) {
                                  return 'Please select booking address';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                addressId.text = value!;
                                final index = addressController.addressResponseModel!.indexWhere((element) => element.id.toString() == value.toString());
                                selectedAddress = addressController.addressResponseModel![index].fullAddress.toString();
                                setState(() {});
                              },
                              buttonStyleData: ButtonStyleData(height: 48, padding: EdgeInsets.only(left: 0, right: 10),
                                  decoration: BoxDecoration(color: Color(0xffEFEFF0), borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Color(0xff868484), width: 0.7))),
                              iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down, color: black, size: 18,), iconSize: 30,),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        // Text('What item would you like to get fixed?',
                        //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        //       fontWeight: FontWeight.w400, fontSize: 14, color: black),
                        // ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // RichText(text: TextSpan(
                        //     text: "What item would you like to get fixed?", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),
                        //     children: [
                        //       TextSpan(text: " *", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w600),)
                        //     ]
                        // )),
                        // SizedBox(height: 12,),
                        // DropdownButtonFormField2(
                        //   decoration: InputDecoration(
                        //     isDense: true,
                        //     contentPadding: EdgeInsets.zero,
                        //     enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.all(Radius.circular(20)),
                        //         borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                        //     focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.all(Radius.circular(20)),
                        //         borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                        //     focusedErrorBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.all(Radius.circular(20)),
                        //         borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                        //     border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.all(Radius.circular(20)),
                        //         borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                        //     errorBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.all(Radius.circular(20)),
                        //         borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                        //   ),
                        //   isExpanded: true,
                        //   hint: Text("Item name", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 15)),
                        //   items: controller.item.map((item) => DropdownMenuItem<String>(
                        //     value: item,
                        //     child: Text(item,      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 15)),
                        //   )).toList(),
                        //   validator: (value) {
                        //     if (value == null) {
                        //       return 'Please select item.';
                        //     }
                        //     return null;
                        //   },
                        //   onChanged: (value) {
                        //     _controller.selectedItems = value;
                        //     controller.otherItemsController.clear();
                        //     log(value!);
                        //   },
                        //   buttonStyleData: ButtonStyleData(height: 48, padding: EdgeInsets.only(left: 0, right: 10),
                        //       decoration: BoxDecoration(color: Color(0xffEFEFF0), borderRadius: BorderRadius.circular(20), border: Border.all(color: Color(0xff868484), width: 0.7))),
                        //   iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down, color: black, size: 18,), iconSize: 30,),
                        //   dropdownStyleData: DropdownStyleData(
                        //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 24,),
                        // Text('Others (please specify)',
                        //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        //       fontWeight: FontWeight.w400, fontSize: 14, color: black),
                        // ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // Text("Others (please specify)", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),),
                        // SizedBox(height: 12,),
                        // DexterTextField(
                        //   minLines: null, maxLines: 1, expands: false,
                        //   hintText: "Item name",
                        //   controller: controller.otherItemsController,
                        //   style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 15),
                        //   onChanged: (value){
                        //     _controller.selectedItems = controller.otherItemsController.text;
                        //   },
                        // ),
                        // SizedBox(height: 24,),
                        Text('Specify Appointment Date',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 14, color: black),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // RichText(text: TextSpan(
                        //     text: "Schedule Appointment", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),
                        //     children: [
                        //       TextSpan(text: " *", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w600),)
                        //     ]
                        // )),
                        // SizedBox(height: 12,),
                        DexterTextField(
                          onTap: (){
                            _selectDateOfAppointment(context, controller);
                          },
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 15),
                          minLines: null, maxLines: 1, expands: false, readOnly: true, validator: isRequired,
                          hintText: "Select Date",controller: controller.dateOfAppointment,
                          suffixIcon: Icon(Icons.keyboard_arrow_down, color: black,),
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(flex: 3,
                        //       child: DexterTextField(
                        //         onTap: (){
                        //           _selectDateOfBirth(context, controller);
                        //         },
                        //         style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 15),
                        //         minLines: null, maxLines: 1, expands: false, readOnly: true,
                        //         hintText: "Select Date",controller: _controller.dateOfAppointment,
                        //         suffixIcon: Icon(Icons.keyboard_arrow_down, color: black,),
                        //       ),
                        //     ),
                        //     const SizedBox(width: 10),
                        //     Expanded(flex: 2,
                        //       child: DropdownButtonFormField2(
                        //         decoration: InputDecoration(
                        //           isDense: true,
                        //           contentPadding: EdgeInsets.zero,
                        //           enabledBorder: OutlineInputBorder(
                        //               borderRadius: BorderRadius.all(Radius.circular(20)),
                        //               borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                        //           focusedBorder: OutlineInputBorder(
                        //               borderRadius: BorderRadius.all(Radius.circular(20)),
                        //               borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                        //           focusedErrorBorder: OutlineInputBorder(
                        //               borderRadius: BorderRadius.all(Radius.circular(20)),
                        //               borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                        //           border: OutlineInputBorder(
                        //               borderRadius: BorderRadius.all(Radius.circular(20)),
                        //               borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                        //           errorBorder: OutlineInputBorder(
                        //               borderRadius: BorderRadius.all(Radius.circular(20)),
                        //               borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
                        //         ),
                        //         isExpanded: true,
                        //         hint: Text("Period",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 15),),
                        //         items: controller.period.map((item) => DropdownMenuItem<String>(
                        //           value: item,
                        //           child: Text(item, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 15),),
                        //         )).toList(),
                        //         validator: (value) {
                        //           if (value == null) {
                        //             return 'Please select period.';
                        //           }
                        //           return null;
                        //         },
                        //         onChanged: (value) {
                        //           _controller.selectedPeriod = value;
                        //         },
                        //         buttonStyleData: ButtonStyleData(height: 48, padding: EdgeInsets.only(left: 0, right: 10),
                        //             decoration: BoxDecoration(color: Color(0xffEFEFF0), borderRadius: BorderRadius.circular(20), border: Border.all(color: Color(0xff868484), width: 0.7))),
                        //         iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down, color: black, size: 18,), iconSize: 30,),
                        //         dropdownStyleData: DropdownStyleData(
                        //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 24,),
                        Text('Message',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 14, color: black),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // RichText(text: TextSpan(
                        //     text: "Message", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),
                        //     children: [
                        //       TextSpan(text: " *", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w600),)
                        //     ]
                        // )),
                        // SizedBox(height: 12,),
                        _commentForm(),
                        SizedBox(height: 24,),
                        // Text("Images (Up to 5 Images)", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),),
                        // SizedBox(height: 12,),
                        // controller.imageFiles == null || controller.imageFiles == [] || controller.imageFiles!.isEmpty ?
                        // GestureDetector(
                        //   onTap: () {
                        //     _showImagePickerDialog();
                        //   },
                        //   child: Container(
                        //       width: double.maxFinite, padding: const EdgeInsets.only(top: 40),
                        //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Color(0xffEFEFF0),border: Border.all(color: Color(0xff868484))),
                        //       child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Container(
                        //             height: 95, width: 95,decoration: BoxDecoration(color: Color(0xff0E9B62).withOpacity(0.2),
                        //             borderRadius: BorderRadius.circular(8),),
                        //             child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                        //               children: [
                        //                 const Icon(Iconsax.camera5, color: Color(0xff0E9B62),),
                        //                 const SizedBox(height: 10,),
                        //                 Text("Add Media", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xff0E9B62), fontSize: 12, fontWeight: FontWeight.w600),),
                        //               ],
                        //             ),
                        //           ),
                        //           const SizedBox(height: 24,),
                        //           RichText(text: TextSpan(
                        //               text: "Click ", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10, fontWeight: FontWeight.w600),
                        //               children: [
                        //                 TextSpan(text: "Here", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xff0E9B62), fontSize: 10, fontWeight: FontWeight.w600),),
                        //                 TextSpan(text: " to Add image", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10, fontWeight: FontWeight.w600),)
                        //               ]
                        //           )),
                        //           const SizedBox(height: 57,),
                        //         ],
                        //       )
                        //   ),
                        // ) : Wrap(alignment: WrapAlignment.spaceAround,
                        //   children: List.generate(controller.imageFiles!.length, (index){
                        //     return Stack(
                        //       children: [
                        //         Card(
                        //           child: Container(
                        //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                        //             height: 100, width:80,
                        //             child: Image.file(File(controller.imageFiles![index].path)),
                        //           ),
                        //         ),
                        //         GestureDetector(
                        //           onTap: (){
                        //             controller.imageFiles!.removeAt(index);
                        //             setState(() {});
                        //           },
                        //           child: Container(height: 20, width: 20, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                        //             child: Center(
                        //               child: Icon(Icons.clear, color: Colors.white, size: 15,),
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     );
                        //   })
                        // ),
                        const SizedBox(height: 46,),
                        DexterPrimaryButton(
                          onTap: (){
                            if(formKey.currentState!.validate()){
                              showRepairPromptBottomSheet(
                                  message: _controller.messageController.text,
                                  formattedDate: formattedDate.toString(),
                                  displayDate: controller.dateOfAppointment.text,
                                  address: selectedAddress ?? "",
                                controller: controller
                              );
                            }
                            },
                          buttonBorder: greenPea, btnTitle: "Continue",
                          borderRadius: 30, titleColor: white, btnHeight: 56, btnTitleSize: 16,
                        ),
                        const SizedBox(height: 32,),
                      ],
                    ),
                  ),
                ),
              )
          );
        }
    );
  }
}

import 'dart:developer';
import 'package:clean_dialog/clean_dialog.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_primary_button.dart';
import 'package:dexter_mobile/datas/location/get_location.dart';
import 'package:dexter_mobile/domain/local/local_storage.dart';
import 'package:dexter_mobile/presentation/bottom_navigation_bar_screen.dart';
import 'package:dexter_mobile/presentation/customer/controller/address_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/home/location_and_address.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/controller/shop_cart_controller.dart';
import 'package:dexter_mobile/presentation/customer/widget/circular_loading_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';

class MapDetails extends StatefulWidget {
  final int cartId;
  final String amount;
  final String totalItem;
  final String shopAddress;
  final String openingTime;
  final String closingTime;
  final String shopName;
  const MapDetails({Key? key, required this.amount, required this.totalItem, required this.shopAddress, required this.cartId, required this.openingTime, required this.closingTime, required this.shopName}) : super(key: key);

  @override
  State<MapDetails> createState() => _MapDetailsState();
}

class _MapDetailsState extends State<MapDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final addressController = Get.find<AddressController>();
  final descriptionController = TextEditingController();
  final addressId = TextEditingController();

  Widget _businessDescriptionForm(){
    var maxLine = 8;
    return Container(
      height: maxLine * 18.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), color: Colors.white),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.top, controller: descriptionController,
        textCapitalization: TextCapitalization.sentences, textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline, minLines: null, maxLines: null, expands: true,
        // maxLines: 11,
        decoration: InputDecoration(
          counterText: " ",
          hintText: "Add note",
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xff868484), fontSize: 14),
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xff868484), fontSize: 14),
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
          fillColor: Colors.white, filled: true, isDense: true, contentPadding: const EdgeInsets.all(13),
        ),
      ),
    );
  }
  final plugin = PaystackPlugin();
  GoogleMapController? _googleMapController;
  Marker? origin;
  double heightFactor = 0.3;
  addMarker(LatLng pos) {
    origin = Marker(markerId: const MarkerId("Origin"), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), position: pos);
  }

   double? longitude, latitude;

  Future<void> getLocation() async {
    final value = await GetLocation.instance!.checkLocation;
    longitude = value.longitude ?? 0.0;
    latitude = value.latitude ?? 0.00;
    addMarker(LatLng(value.latitude ?? 0.000, value.longitude ?? 0.00));
    setState(() {});
  }

  String? selectedAddress;
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
    getLocation();
    plugin.initialize(publicKey: payStackPublicKey);
    super.initState();
  }

  showAddressDialog(){
    showDialog(
      context: context,
      builder: (context) => CleanDialog(
        title: 'Address Notice',
        content: "You haven't added any address yet. kindly add a address from the dashboard to proceed.",
        backgroundColor: greenPea,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
        actions: [
          CleanDialogActionButtons(
              actionTitle: 'Add Address',
              textColor: greenPea,
              onPressed: (){
                Navigator.pop(context);
                Get.to(()=>LocationAndAddress());
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

  bool addNote = false;
  double bottomSheetHeight = 0.45;
  final _controller = Get.put(RestaurantCartController());
  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }
  Widget showMyBottomSheet(BuildContext context){
    return StatefulBuilder(builder: (context, update){
      return DraggableScrollableSheet(
          initialChildSize: bottomSheetHeight,
          maxChildSize: bottomSheetHeight,
          minChildSize: bottomSheetHeight,
          builder: (BuildContext context, ScrollController controller){
            return Container(
              decoration: const BoxDecoration(
                  color: Colors.white,  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),)
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: controller,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10,),
                      Align(alignment: Alignment.center,
                          child: Container(height: 5, width: 50, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),)),
                      const SizedBox(height: 10,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery location Address",  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 16, fontWeight: FontWeight.w600),),
                          GestureDetector(
                            onTap: (){
                              addNote = !addNote;
                              if(addNote == false){
                                update(() {
                                  bottomSheetHeight = 0.45;
                                });
                              }else if(addNote == true){
                                update(() {
                                  bottomSheetHeight = 0.65;
                                });
                              }
                            },
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(addNote == true ? Icons.remove : Icons.note_alt, color: greenPea,),
                                const SizedBox(width: 1,),
                                Text(addNote == true ? "Remove Note" : "Add Note" , style: Theme.of(context).textTheme.bodySmall?.copyWith(color: greenPea, fontWeight: FontWeight.w700),),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15,),
                      SizedBox(height: 75,
                        child: GestureDetector(
                          onTap: (){
                            if(addressController.addressResponseModel == null || addressController.addressResponseModel == [] || addressController.addressResponseModel!.isEmpty && selectedAddress == null){
                              showAddressDialog();
                            }else{
                              null;
                            }
                          },
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              counterText: " ",
                              isDense: true, fillColor: Color(0xffEFEFF0),
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
                            hint: Text(selectedAddress ?? "Select delivery address", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: selectedAddress == null ? Color(0xff868484) : black, fontSize: 15)),
                            items: addressController.addressResponseModel?.map((item) => DropdownMenuItem<String>(
                              value: item.id.toString() ?? "",
                              child: Text(item.fullAddress ?? "", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 15)),
                            )).toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select delivery address';
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
                      Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(13),
                          border: Border.all(color: Color(0xff868484), width: 0.7)), padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${widget.shopName ?? ""}", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600, fontSize: 14, color: black),),
                            const SizedBox(height: 5,),
                            const Divider(),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Shop Address: ", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 12),),
                                // const SizedBox(height: 5,),
                                Text("${widget.shopAddress}", maxLines: 3,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: greenPea, fontWeight: FontWeight.w300, fontSize: 13),),
                              ],
                            ),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Item: ", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: greenPea, fontWeight: FontWeight.w700, fontSize: 13),),
                                    Text("${widget.totalItem}", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 13),),
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Price: ", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: greenPea, fontWeight: FontWeight.w700, fontSize: 13),),
                                    Text("NGN ${MoneyFormatter(amount: double.parse(widget?.amount ?? "0.00"),).output.nonSymbol}", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 13),),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      addNote == false ? const SizedBox() : const SizedBox(height: 10,),
                      addNote == false ? const SizedBox() : _businessDescriptionForm(),
                      const SizedBox(height: 15,),
                      DexterPrimaryButton(
                        onTap: () {
                          _controller.checkOut(
                              cartId: widget.cartId.toString(),
                              addressId: addressId.text,
                              notes: descriptionController.text
                          );
                        },
                        buttonBorder: greenPea, btnTitle: "CheckOut",
                        borderRadius: 30, titleColor: white, btnHeight: 56, btnTitleSize: 16,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }


  @override
  Widget build(BuildContext context) {
    final _initialCameraPosition = CameraPosition(target: LatLng(latitude ?? 0.00, longitude ?? 0.00), zoom: 13);
    return Scaffold(
      key: _scaffoldKey,
      body: origin == null ? CircularLoadingWidget() : Stack(
        children: [
          Positioned(
            top: 0, left: 0, right: 0,
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              compassEnabled: false,
              myLocationEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (controller) => _googleMapController = controller,
              markers: {
                origin!,
              },
            ),
          ),
          showMyBottomSheet(context),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 20.0, left: 10),
            child: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Card(elevation: 3, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                child: Container(
                  height: 50, width: 50,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: white,),
                  child: Center(
                    child: Icon(Icons.arrow_back, color: Colors.black,),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

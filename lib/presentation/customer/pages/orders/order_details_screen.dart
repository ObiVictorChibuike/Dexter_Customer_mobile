import 'package:clean_dialog/clean_dialog.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/utils/custom_date.dart';
import 'package:dexter_mobile/app/shared/widgets/error_screen.dart';
import 'package:dexter_mobile/datas/location/get_location.dart';
import 'package:dexter_mobile/presentation/customer/controller/booking_controller.dart';
import 'package:dexter_mobile/presentation/customer/controller/order_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/orders/rate_and_review.dart';
import 'package:dexter_mobile/presentation/customer/widget/animated_column.dart';
import 'package:dexter_mobile/presentation/customer/widget/circular_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:money_formatter/money_formatter.dart';

class OrderDetails extends StatefulWidget {
  final String orderId;
  const OrderDetails({super.key, required this.orderId});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final _controller = Get.put(OrderController());
  final bk = Get.lazyPut(()=>BookingController());
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

  showMarkDialog({required void Function() onPressed, required String title, required String content}){
    showDialog(
      context: context,
      builder: (context) => CleanDialog(
        title: title,
        content: content,
        backgroundColor: greenPea,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
        actions: [
          CleanDialogActionButtons(
            actionTitle: 'Yes',
            textColor: greenPea,
            onPressed: onPressed,
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
  void initState() {
    getLocation();
    _controller.getOrderDetails(orderId: widget.orderId);
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  void rateProduct({required String productName, required String productId}){
    Get.bottomSheet(Container(decoration: BoxDecoration(color: white,borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/4,), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: ListView(
        children: [
          const SizedBox(height: 10,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rate Product", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 18, fontWeight: FontWeight.w600),),
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
          Column(
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                  Get.to(()=> RateAndReview(
                    vendorName: productName,
                    isFromBusiness: false,
                    id: productId,
                  ));
                },
                child: Container(
                  height: 55, width: double.maxFinite, color: Colors.white,
                  child: Row(
                    children: [
                      Image.asset("assets/png/rating.png", height: 40, width: 40,),
                      const SizedBox(width: 15,),
                      Text("Rate this Product", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 15, fontWeight: FontWeight.w400),)
                    ],
                  ),
                ),
              ),
              Divider()
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
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
        init: OrderController(),
        builder: (controller){
          final _initialCameraPosition = CameraPosition(target: LatLng(latitude ?? 0.00, longitude ?? 0.00), zoom: 13);
          return SafeArea(top: false, bottom: false,
              child: Scaffold(backgroundColor: white,
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
                  title: Text("Orders Details", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 20, fontWeight: FontWeight.w700),),
                ),
                body: origin == null ? CircularLoadingWidget() :
                controller.getOrdersDetailsLoadingState == true && controller.getOrderDetailsErrorState == false ?
                CircularLoadingWidget() : controller.getOrdersDetailsLoadingState == false && controller.getOrderDetailsErrorState ==
                    false && controller.orderDetailsModelResponse != null ?
                AnimatedColumn(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  children: [
                    Text("Customer", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: greenPea, fontSize: 14, fontWeight: FontWeight.w700),),
                    const SizedBox(height: 5,),
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(borderRadius: BorderRadius.circular(40),
                            child: Image.network(controller.orderDetailsModelResponse?.data?.shop?.coverImage ?? imagePlaceHolder, height: 40, width: 40, fit: BoxFit.cover,)),
                        const SizedBox(width: 10,),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${controller.orderDetailsModelResponse?.data?.shop?.name}",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Color(0xff06161C), fontSize: 16, fontWeight: FontWeight.w600),),
                            Text(CustomDate.slash(controller.orderDetailsModelResponse?.data?.createdAt.toString() ?? DateTime.now().toString()),
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xff8F92A1), fontSize: 12, fontWeight: FontWeight.w600),),
                            const SizedBox(height: 5,),
                            Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 10, width: 10, decoration: BoxDecoration(color:
                                controller.orderDetailsModelResponse?.data?.status == "pending" ? black :
                                controller.orderDetailsModelResponse?.data?.status == "confirmed" ? tulipTree :
                                controller.orderDetailsModelResponse?.data?.status == "confirmed" ? greenPea :
                                controller.orderDetailsModelResponse?.data?.status == "cancelled" ? persianRed :
                                controller.orderDetailsModelResponse?.data?.status == "fulfilled" ? Colors.deepOrangeAccent :
                                Colors.transparent,
                                    shape: BoxShape.circle),
                                ),
                                const SizedBox(width: 5,),
                                Text(controller.orderDetailsModelResponse?.data?.status == "pending" ? "Pending" :
                                controller.orderDetailsModelResponse?.data?.status == "confirmed" ? "Confirmed" :
                                controller.orderDetailsModelResponse?.data?.status == "completed" ? "Completed" :
                                controller.orderDetailsModelResponse?.data?.status == "cancelled" ? "Cancelled" :
                                controller.orderDetailsModelResponse?.data?.status == "fulfilled" ? "Delivered" :"",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 14),),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Location", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700),),
                        const SizedBox(width: 15,),
                        Expanded(flex: 4,
                          child: Text("${controller.orderDetailsModelResponse?.data?.address?.fullAddress ?? ""}",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: greenPea, fontSize: 14, fontWeight: FontWeight.w400),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      height: MediaQuery.of(context).size.height/3.5, width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),),
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
                    const SizedBox(height: 15,),
                    controller.orderDetailsModelResponse?.data?.notes == null ? const SizedBox() : Text("Message", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w400),),
                    controller.orderDetailsModelResponse?.data?.notes == null ? const SizedBox() : const SizedBox(height: 5,),
                    controller.orderDetailsModelResponse?.data?.notes  == null ? const SizedBox() : Text("${controller.orderDetailsModelResponse?.data?.notes ?? ""}",
                      textAlign: TextAlign.start,
                      maxLines: 5, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: black,
                          fontSize: 14, fontWeight: FontWeight.w400),),
                    const SizedBox(height: 15,),
                    Text("Items", style: Theme.of(context).textTheme.bodySmall?.copyWith(color:
                    Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w400),),
                    const SizedBox(height: 5,),
                    ...List.generate(controller.orderDetailsModelResponse!.data!.orderItems!.length, (index){
                      final data = controller.orderDetailsModelResponse!.data!.orderItems![index];
                      return  GestureDetector(
                        onTap: (){
                          if(controller.orderDetailsModelResponse?.data?.status == "completed" ){
                            Get.back();
                            rateProduct(
                                productName: data.product?.name ?? "",
                                productId: data.productId.toString()
                            );
                          }else{
                            Get.back();
                            null;
                          }
                        },
                        child: Container(
                          width: double.maxFinite, padding: EdgeInsets.all(10),
                          decoration: BoxDecoration( borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: dustyGray)),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(borderRadius: BorderRadius.circular(60),
                                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)), height: 40, width: 40,
                                  child: Image.network(data.product?.image ?? imagePlaceHolder , height: 40, width: 40, fit: BoxFit.cover,),
                                ),
                              ),
                              const SizedBox(width: 15,),
                              Expanded(
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${ data.product?.name ?? ""}",
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),),
                                    Text( data.product?.description ?? "", maxLines: 4,
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xff8F92A1), fontSize: 12, fontWeight: FontWeight.w600),),
                                  ],
                                ),
                              ),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("NGN ${MoneyFormatter(amount: double.parse(data.product?.price ?? "0.00"),).output.nonSymbol}",
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w700),),
                                  Row(
                                    children: [
                                      Text("Quantity: ", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: greenPea, fontSize: 13, fontWeight: FontWeight.w700),),
                                      Text( data.quantity.toString() ?? "", maxLines: 4,
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xff8F92A1), fontSize: 12, fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 15,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order ID", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Color(0xff999999), fontSize: 13, fontWeight: FontWeight.w500),),
                        Text("#${controller.orderDetailsModelResponse?.data?.id}",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: greenPea, fontSize: 13, fontWeight: FontWeight.w400),),
                      ],
                    ),
                    const SizedBox(height: 6,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order Reference", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Color(0xff999999), fontSize: 13, fontWeight: FontWeight.w500),),
                        Text("#${controller.orderDetailsModelResponse?.data?.reference}",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: greenPea, fontSize: 13, fontWeight: FontWeight.w400),),
                      ],
                    ),
                    const SizedBox(height: 6,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Amount", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Color(0xff999999), fontSize: 13, fontWeight: FontWeight.w500),),
                        Text("NGN ${MoneyFormatter(amount: double.parse(controller.orderDetailsModelResponse?.data?.totalAmount ?? "0.00"),).output.nonSymbol}",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: greenPea, fontSize: 14, fontWeight: FontWeight.w400),),
                      ],
                    ),
                    const SizedBox(height: 35,),
                  ],
                )
                    : controller.getOrdersDetailsLoadingState == false && controller.getOrderDetailsErrorState == true ?
                ErrorScreen() : const SizedBox(),
              )
          );
        });
  }
}

import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_text_field.dart';
import 'package:dexter_mobile/app/shared/widgets/empty_screen.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/controller/shop_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/pages/shop_details_and_menu.dart';
import 'package:dexter_mobile/presentation/customer/widget/circular_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Shops extends StatefulWidget {
  final String ServiceId;
  final String ServiceName;
  const Shops({Key? key, required this.ServiceId, required this.ServiceName}) : super(key: key);

  @override
  State<Shops> createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  final query = TextEditingController();
  ShopController shopController = Get.put(ShopController());

  @override
  void initState() {
    shopController.getShopByServices(serviceId: widget.ServiceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(
        init: ShopController(),
        builder: (controller){
          return SafeArea(top: false, bottom: false,
              child: Scaffold(
                backgroundColor: white,
                appBar: AppBar(
                  backgroundColor: white,
                  elevation: 0.0,
                  leading: GestureDetector(
                      onTap: ()async{
                        query.clear();
                        await controller.getShopByServices(serviceId: widget.ServiceId);
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back, color: black,)),
                  title: Text("${widget.ServiceName}", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 16, fontWeight: FontWeight.w600),),),
                body: controller.shopByServicesResponse == null && controller.shopByServicesLoadingState == true ? CircularLoadingWidget() :
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 30,),
                      DexterTextField(
                          controller: query,
                          onChanged: (value) async {
                            if(query.text.isEmpty){
                              await controller.getShopByServices(serviceId: widget.ServiceId);
                            }else{
                              final shops = controller.shopByServicesResponse!.data!.where((restaurants){
                                final nameLowerCase = restaurants.name!.toLowerCase();
                                final queryLowerCase = query.text.toLowerCase();
                                return nameLowerCase.contains(queryLowerCase);
                              }).toList();
                              setState(() {
                                controller.shopByServicesResponse!.data = shops;
                              });}
                          },
                          filledColor: Colors.transparent, minLines: null, maxLines: 1, expands: false,
                          hintText: "Search ${widget.ServiceName}",
                          prefixIcon: Padding(padding: const EdgeInsets.all(8.0), child: SvgPicture.asset(AssetPath.search),)
                      ),
                      controller.shopByServicesLoadingState == false && controller.shopByServicesResponse!.data!.isEmpty || controller.shopByServicesResponse!.data == [] || controller.shopByServicesResponse!.data == null ?
                      Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height/5,),
                                Image.asset(AssetPath.emptyFile, height: 150, width: 150,),
                                const SizedBox(height: 15,),
                                Text("No shop found", style: TextStyle(color: Color(0xFF52575C), fontSize: 15),),
                              ],
                            ),
                          ),
                        ],
                      ) :  controller.shopByServicesErrorState == true && controller.shopByServicesResponse!.data!.isEmpty || controller.shopByServicesResponse!.data == [] ? CircularLoadingWidget() :
                      Column(
                        children: [
                          ...List.generate(controller.shopByServicesResponse!.data!.length, (index) =>
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: GestureDetector(
                                  onTap: (){
                                    Get.to(()=> ShopDetailsAndMenu(id: controller.shopByServicesResponse!.data![index].id.toString(), name: controller.shopByServicesResponse!.data![index].name!,));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                                        height: 254, width: MediaQuery.of(context).size.width / 1.2,
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                                              height: 150, width: double.maxFinite,
                                              child: Image.network(controller.shopByServicesResponse!.data![index].coverImage ?? imagePlaceHolder, fit: BoxFit.cover,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(controller.shopByServicesResponse!.data![index].name!,
                                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),),
                                                  const SizedBox(height: 15,),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.all(8),
                                                        decoration: BoxDecoration(color: Color(0xffD9F2EA),
                                                            borderRadius: BorderRadius.circular(100)),
                                                        child: Text("${controller.shopByServicesResponse!.data![index].biography}",
                                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w600),
                                                        ),),
                                                      const SizedBox(width: 10,),
                                                      Container(
                                                        padding: EdgeInsets.all(8),
                                                        decoration: BoxDecoration(color: Color(0xffD9F2EA),
                                                            borderRadius: BorderRadius.circular(100)),
                                                        child: Text(
                                                          "${controller.shopByServicesResponse!.data![index].contactAddress?.fullAddress ?? ""}",
                                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w600),
                                                        ),),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          )
                        ],
                      )
                      // buildRestaurant(controller),
                    ],
                  ),
                ),
              )
          );
        });
  }
}

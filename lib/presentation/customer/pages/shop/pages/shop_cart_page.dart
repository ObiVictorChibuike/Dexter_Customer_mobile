import 'dart:developer';
import 'package:clean_dialog/clean_dialog.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_primary_button.dart';
import 'package:dexter_mobile/data/shops_model/shop_response_model.dart';
import 'package:dexter_mobile/domain/local/local_storage.dart';
import 'package:dexter_mobile/presentation/customer/controller/address_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/controller/product_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/controller/shop_controller.dart';
import 'package:dexter_mobile/presentation/customer/widget/animated_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';
import 'map_detail.dart';

class ShopCartPage extends StatefulWidget {
  final String shopId;
  final ShopResponseModel? shopResponseModel;
  const ShopCartPage({Key? key, this.shopResponseModel, required this.shopId}) : super(key: key);

  @override
  State<ShopCartPage> createState() => _ShopCartPageState();
}

class _ShopCartPageState extends State<ShopCartPage> {
  final addressController = Get.put(AddressController());
  String? selectedAddress;
  Future<void> getSelectedAddress() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    await LocalCachedData.instance.getSelectedLocation().then((value){
      if(value != null && value != ""){
        selectedAddress = value;
        log(selectedAddress.toString());
        setState(() {});
      }
    });
  }
  @override
  void initState() {
    getSelectedAddress();
    addressController.getUserAddress();
    super.initState();
  }

  int? totalItem;
  String? totalSum;
  showAlertDialog({required ShopController controller}){
    showDialog(
      context: context,
      builder: (context) => CleanDialog(
        title: 'Clear Cart?',
        content: "Are you sure you want to clear this cart?",
        backgroundColor: greenPea,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
        actions: [
          CleanDialogActionButtons(
              actionTitle: 'Yes',
              textColor: persianRed,
              onPressed: (){
                Navigator.pop(context);
                controller.clearCartByShop(context: context);
              }
          ),
          CleanDialogActionButtons(
              actionTitle: 'No',
              textColor: greenPea,
              onPressed: (){
                Navigator.pop(context);
              }
          ),
        ],
      ),
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

  showDeleteAccountDialog({required ShopController controller, required String shopId, required String productId, required String cartId}){
    showDialog(
      context: context,
      builder: (context) => CleanDialog(
        title: 'Delete Item',
        content: "Are you sure you want to delete this item?",
        backgroundColor: greenPea,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
        actions: [
          CleanDialogActionButtons(
              actionTitle: 'Yes',
              textColor: greenPea,
              onPressed: (){
                Navigator.pop(context);
                controller.deleteItemFromCart(cartId: cartId, shopId: shopId, productId: productId);
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
  final productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(
      init: ShopController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: white, elevation: 0.0,
            title: Text("Shop Cart", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: black, fontSize: 18, fontWeight: FontWeight.w600),),
            leading: GestureDetector(
              onTap: (){
                Get.back();
              },
                child: Icon(Icons.arrow_back_ios_new, color: black,)),
            actions: [
              GestureDetector(
                onTap: (){
                  showAlertDialog(controller: controller);
                },
                child: Container(height: 28, padding: EdgeInsets.symmetric(horizontal: 10), margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(35), color: Color(0xffFCEFEF)),
                  child: Center(
                    child: Text("Clear Cart", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: persianRed, fontSize: 14, fontWeight: FontWeight.w600),),
                  ),
                ),
              ),
            ],
          ),
          body:  controller.cartByShopResponse == null || controller.cartByShopResponse!.data!.isEmpty || controller.cartByShopResponse!.data == [] ?
          Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height/ 3,),
                Image.asset('assets/png/empty-cart.png', height: 100, width: 100,),
                const SizedBox(height: 15,),
                Text("You don't have cart with this shop", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: greenPea, fontSize: 13, fontWeight: FontWeight.w400),),
                SizedBox(height: MediaQuery.of(context).size.height/ 3,),
              ],
            ),
          ) :
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
               Expanded(
                   child: AnimatedColumn(
                     padding: EdgeInsets.symmetric(horizontal: 0),
                     children: [
                       ...List.generate(controller.cartByShopResponse!.data!.first.cartItems!.length, (index){
                         final cartItems = controller.cartByShopResponse!.data;
                         totalItem = controller.cartByShopResponse!.data!.first.cartItemsCount;
                         totalSum = controller.cartByShopResponse!.data!.first.cartItemsSumPrice;
                         return Dismissible(
                           direction: DismissDirection.endToStart,
                           background: const SizedBox(),
                           secondaryBackground: slideLeftBackground(),
                           key: UniqueKey(),
                           onDismissed: (DismissDirection direction) {
                             setState(() {
                               controller.cartByShopResponse!.data!.removeAt(index);
                             });
                           },
                           confirmDismiss: (DismissDirection direction) async {
                             if (direction == DismissDirection.endToStart) {
                               return await showDeleteAccountDialog(controller: controller, shopId: cartItems.first.shopId.toString(),
                                   productId: cartItems.first.cartItems![index].productId.toString(), cartId: cartItems.first.id.toString());
                             } else {
                               return null;
                             }
                           },
                           child: Container(padding: EdgeInsets.all(10), margin: EdgeInsets.symmetric(vertical: 10),
                             decoration: BoxDecoration(
                                 boxShadow: [
                                   BoxShadow(color: Colors.grey.withOpacity(0.3), offset: Offset(0, 1), blurRadius: 5, spreadRadius: 1)
                                 ],
                                 borderRadius: BorderRadius.circular(16), border: Border.all(color: Color(0xffE6E6E6),), color: white),
                             child: Row(
                               children: [
                                 ClipRRect(
                                     borderRadius: BorderRadius.circular(10),
                                     child: Container(
                                       height: 80, width: 80,
                                       decoration: BoxDecoration(
                                           image: DecorationImage(image: NetworkImage(cartItems!.first.cartItems?[index].product?.image ?? imagePlaceHolder), fit: BoxFit.cover)
                                       ),
                                     )),
                                 const SizedBox(width: 15,),
                                 Expanded(
                                   child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Expanded(child: Text(cartItems.first.cartItems?[index].product?.name ?? "",
                                             style: Theme.of(context).textTheme.bodyText1?.copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 14),)),
                                           const SizedBox(width: 30,),
                                           Row(
                                             children: [
                                               GestureDetector(
                                                 onTap: (){
                                                   if(cartItems.first.cartItems![index].quantity! == 1){
                                                     null;
                                                   }else{
                                                     final quantity = cartItems.first.cartItems![index].quantity! - 1;
                                                     productController.incrementProductQuantityFromCart(shopId: widget.shopId, productId: cartItems.first.cartItems![index].productId!, quantity: quantity!);
                                                   }

                                                 },
                                                 child: Container(height: 26, width: 26,
                                                   decoration: BoxDecoration(color: Color(0xffE6E6E6), shape: BoxShape.circle),
                                                   child: Center(child: Icon(Icons.remove, color: black,size: 15)),
                                                 ),
                                               ),
                                               const SizedBox(width: 12,),
                                               Text("${cartItems.first.cartItems![index].quantity}",
                                                 style: Theme.of(context).textTheme.bodyText1!.copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 18),),
                                               const SizedBox(width: 12,),
                                               GestureDetector(
                                                 onTap: (){
                                                   final quantity = cartItems.first.cartItems![index].quantity! + 1;
                                                   productController.incrementProductQuantityFromCart(shopId: widget.shopId, productId: cartItems.first.cartItems![index].productId!, quantity: quantity!);
                                                 },
                                                 child: Container(
                                                   height: 26, width: 26,
                                                   decoration: BoxDecoration(color: greenPea, shape: BoxShape.circle,),
                                                   child: Center(child: Icon(Icons.add, color: white, size: 15),),
                                                 ),
                                               )
                                             ],
                                           )
                                         ],
                                       ),
                                       const SizedBox(height: 16,),
                                       Text("₦ ${MoneyFormatter(amount: double.parse(cartItems.first.cartItems?[index].price ?? "0.00"),).output.nonSymbol}",
                                         style: Theme.of(context).textTheme.bodyText1!.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 16),),
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         );
                       }),
                     ],
                   )
               ),
                const SizedBox(height: 21,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Delivery Location", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: dustyGray, fontWeight: FontWeight.w400, fontSize: 13),),
                    const Spacer(),
                    Expanded(child: Text(selectedAddress ?? "No address",maxLines: 1, textAlign: selectedAddress == "" || selectedAddress == null ? TextAlign.end : TextAlign.start,
                      overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: greenPea, fontWeight: FontWeight.w400, fontSize: 13,),))
                  ],
                ),
                // const Divider(),
                // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text("Subtotal $totalItem ${totalItem == 1 ? "item" : "items"}", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: dustyGray, fontWeight: FontWeight.w400, fontSize: 13),),
                //     Text("₦ 6,000", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: greenPea, fontWeight: FontWeight.w400, fontSize: 13),)
                //   ],
                // ),
                const Divider(),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Shopping Cost", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: dustyGray, fontWeight: FontWeight.w400, fontSize: 13),),
                    Text("₦ ${MoneyFormatter(amount: double.parse(widget.shopResponseModel?.data?.shippingCost ?? "0.00"),).output.nonSymbol}",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: greenPea, fontWeight: FontWeight.w400, fontSize: 13),)
                  ],
                ),
                const Divider(),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 13),),
                    Text("₦ ${MoneyFormatter(amount: double.parse(totalSum ?? "0.00"),).output.nonSymbol}", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: greenPea, fontWeight: FontWeight.w400, fontSize: 13),)
                  ],
                ),
                const Divider(),
                DexterPrimaryButton(
                  onTap: (){
                    Get.to(()=> MapDetails(
                      amount: totalSum.toString(),
                      totalItem: totalItem.toString(),
                      shopAddress: widget.shopResponseModel?.data?.contactAddress?.fullAddress ?? "",
                      cartId: controller.cartByShopResponse!.data!.first.cartItems!.first.cartId!,
                      closingTime: widget.shopResponseModel?.data?.closingTime ?? "",
                      openingTime: widget.shopResponseModel?.data?.openingTine ?? "",
                      shopName: widget.shopResponseModel?.data?.name ?? "",
                    ));
                  },
                  buttonBorder: greenPea, btnTitle: "Proceed",
                  borderRadius: 30, titleColor: white, btnHeight: 56, btnTitleSize: 16,
                ),
                const SizedBox(height: 15,),
              ],
            ),
          ),
        ),
      );
    });
  }
}

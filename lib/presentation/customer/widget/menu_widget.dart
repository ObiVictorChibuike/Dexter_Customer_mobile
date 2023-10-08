import 'dart:developer';
import 'package:clean_dialog/clean_dialog.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/domain/local/local_storage.dart';
import 'package:dexter_mobile/presentation/customer/pages/home/product_preview.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/controller/product_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/controller/shop_controller.dart';
import 'package:dexter_mobile/presentation/customer/widget/animated_column.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final productController = Get.put(ProductController());
  final shopController = Get.put(ShopController());
  late Function updateSetState;
  late int quantity = 1;

  showAlertDialog({required ShopController controller}){
    showDialog(
      context: context,
      builder: (context) => CleanDialog(
        title: 'Clear Cart?',
        content: "You you already have items in another shop cart. To proceed with your request, you either checkout from your previous cart or you clear the cart",
        backgroundColor: greenPea,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
        actions: [
          CleanDialogActionButtons(
              actionTitle: 'Clear Cart',
              textColor: persianRed,
              onPressed: (){
                Navigator.pop(context);
                controller.clearCartByShop(context: context);
              }
          ),
          CleanDialogActionButtons(
              actionTitle: 'Check Out',
              textColor: greenPea,
              onPressed: (){
                Navigator.pop(context);
              }
          ),
        ],
      ),
    );
  }

  void showRestaurantBottomSheet({required String imagePath, required String name,
    required String description, required String price, required String shopId, required int productId,required bool inStock}) {
    var summation = double.parse(price);
    Get.bottomSheet(
      StatefulBuilder(builder: (context, update) {
        updateSetState = update;
        return Container(decoration: BoxDecoration(color: white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),),
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.8,),
          child: Column(
            children: [
              Container(height: MediaQuery.of(context).size.height / 3.6,
                width: double.maxFinite,
                decoration: BoxDecoration(image: DecorationImage(
                    image: NetworkImage(imagePath), fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                padding: EdgeInsets.only(left: 18, right: 18, top: 20),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 25, width: 25,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: white),
                            child: Center(
                                child: Icon(Icons.clear, color: black,)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 19,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 14),),
                    const SizedBox(height: 5,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(
                          description, overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 14),)),
                        const SizedBox(width: 20,),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (quantity == 1) {
                                  null;
                                } else {
                                  updateSetState(() {
                                    quantity--;
                                     summation = double.parse(price) * quantity;
                                  });
                                }
                              },
                              child: Container(
                                height: 26, width: 26,
                                decoration: BoxDecoration(
                                    color: quantity > 1 ? greenPea : Color(0xffE6E6E6),
                                    shape: BoxShape.circle),
                                child: Center(child: Icon(
                                    Icons.remove, color: white, size: 15)),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Text("${ quantity}", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 18),),
                            const SizedBox(width: 10,),
                            GestureDetector(
                              onTap: () {
                                updateSetState(() {
                                  quantity++;
                                  summation = double.parse(price) * quantity;
                                });
                              },
                              child: Container(
                                height: 26, width: 26,
                                decoration: BoxDecoration(
                                  color: greenPea, shape: BoxShape.circle,),
                                child: Center(child: Icon(
                                    Icons.add, color: white, size: 15),),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 16,),
                    Text("₦ ${MoneyFormatter(amount: summation).output.nonSymbol}",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 16),),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    Get.put<LocalCachedData>(await LocalCachedData.create());
                    final cartId = await LocalCachedData.instance.getUserCartId();
                    if (inStock == true && cartId == null) {
                      Get.back();
                      productController.addProductToCart(shopId: shopId.toString(), productId: productId, quantity: quantity);
                    }else if (inStock == true && cartId != null && cartId == shopId) {
                      Get.back();
                      productController.addProductToCart(shopId: shopId.toString(), productId: productId, quantity: quantity);
                    }else if (inStock == true && cartId != null && cartId != shopId ) {
                      Get.back();
                      showAlertDialog(controller: shopController);
                    } else if(inStock == false){
                      Get.snackbar("Failed", "This product is out of stock. Kindly check later for availability", backgroundColor: white, colorText: black);
                    }
                  },
                  child: Container(width: double.infinity, height: 50,
                    decoration: BoxDecoration(
                        color: inStock == true ? greenPea : Colors.grey,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text("Add to cart", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: white, fontWeight: FontWeight.w400, fontSize: 16),),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(20)),),
      isScrollControlled: true, isDismissible: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => updateSetState((){}),
      child: GetBuilder<ShopController>(
        init: ShopController(),
          builder: (controller){
        return  controller.productUnderCategoryErrorState == false && controller.productUnderCategoryLoadingState == true ? Center(child: CupertinoActivityIndicator(),) :
                controller.productUnderCategoryLoadingState == false && controller.productUnderCategoryResponseModel == null ||
                controller.productUnderCategoryResponseModel!.data!.isEmpty || controller.productUnderCategoryResponseModel!.data == [] ?
            Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40,),
                    Image.asset('assets/png/menu.png', height: 150, width: 150),
                    const SizedBox(height: 20,),
                    Text("No item available", style: TextStyle(color: Colors.red, fontSize: 15,),),
                  ],
                ),
                const SizedBox(height: 60,),
              ],
            ) :
        AnimatedColumn(
          padding: EdgeInsets.all(0),
          children: [
            ...List.generate(controller.productUnderCategoryResponseModel!.data!.length, (index){
              final item = controller.productUnderCategoryResponseModel!.data![index];
              return GestureDetector(
                onTap: (){
                  quantity = 1;
                  showRestaurantBottomSheet(
                    imagePath: item.image ?? "",
                    name: item.name ?? '',
                    description: item.description ?? "",
                    price: "${item.price ?? 0}",
                    productId: item.id!,
                    shopId: item.shopId.toString(),
                    inStock: item.inStock!
                  );
                },
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10), decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              offset: Offset(0, 1),
                              blurRadius: 5,
                              spreadRadius: 1)
                        ], color: white,
                        borderRadius: BorderRadius.circular(16), border: Border.all(color: Color(0xffE6E6E6))),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>ProductPreview(
                                productUnderCategory: controller.productUnderCategoryResponseModel!.data![index],
                              ));
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 80, width: 80,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: NetworkImage(item.image ?? imagePlaceHolder), fit: BoxFit.cover)
                                  ),
                                )),
                          ),
                          const SizedBox(width: 15,),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 22.0),
                              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Row(crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     RatingBar.builder(
                                  //       itemSize: 10,
                                  //       initialRating: double.parse(item.averageRating ?? "0.0"),
                                  //       minRating: 1,
                                  //       direction: Axis.horizontal,
                                  //       allowHalfRating: true,
                                  //       itemCount: 5,
                                  //       itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                  //       itemBuilder: (context, _) => Icon(
                                  //         Icons.star, size: 10,
                                  //         color: Colors.amber,
                                  //       ),
                                  //       onRatingUpdate: (rating) {
                                  //         print(rating);
                                  //       },
                                  //     ),
                                  //     item.averageRating == null ?
                                  //     Text("0.0",
                                  //       style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12,color: black, fontWeight: FontWeight.w700,),) :
                                  //     Text(item.averageRating.length <= 2 ? item.averageRating ?? "" : item.averageRating?.substring(0,3) ?? "",
                                  //       style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12,color: black, fontWeight: FontWeight.w700,),)
                                  //   ],
                                  // ),
                                  Text("${item.name}", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 14, fontWeight: FontWeight.w600),),
                                  const SizedBox(height: 8,),
                                  Text("₦ ${MoneyFormatter(amount: double.parse(item.price ?? "0.00"),).output.nonSymbol}",  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 12, fontWeight: FontWeight.w600),)
                                ],
                              ),
                            ),
                          ),
                          item.inStock == true ? const SizedBox() :
                          Align(alignment: Alignment.topRight,
                              child: Image.asset("assets/png/out-of-stock.png", height: 30, width: 30,)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              );
            }),
            const SizedBox(height: 20,),
          ],
        );
      }),
    );
  }
}

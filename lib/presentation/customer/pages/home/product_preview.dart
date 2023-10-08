import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/utils/custom_date.dart';
import 'package:dexter_mobile/data/products/product_under_category_response_model.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/controller/product_controller.dart';
import 'package:dexter_mobile/presentation/customer/widget/animated_column.dart';
import 'package:dexter_mobile/presentation/customer/widget/circular_loading_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ProductPreview extends StatefulWidget {
  final ProductUnderCategory? productUnderCategory;
  const ProductPreview({Key? key, this.productUnderCategory,}) : super(key: key);

  @override
  State<ProductPreview> createState() => _ProductPreviewState();
}

class _ProductPreviewState extends State<ProductPreview> {
  final productController = Get.put(ProductController());
  late int quantity = 1;

  late Function updateSetState;

  void showRestaurantBottomSheet({required String imagePath, required String name,
    required String description, required String price, required bool inStock}){
    Get.bottomSheet(
      StatefulBuilder(builder: (context, update){
        updateSetState = update;
        return Container(decoration: BoxDecoration(color: white,borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),),
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/1.8,),
          child: Column(
            children: [
              Container(height: MediaQuery.of(context).size.height / 4, width: double.maxFinite,
                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(imagePath), fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                padding: EdgeInsets.only(left: 18, right: 18, top: 20),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        GestureDetector(
                          onTap: (){
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
              const SizedBox(height: 19,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.bodyText1?.copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 14),),
                    const SizedBox(height: 5,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(description, overflow: TextOverflow.ellipsis, maxLines: 5,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 14),)),
                        const SizedBox(width: 20,),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                if(quantity == 1){
                                  null;
                                }else{
                                  updateSetState((){
                                    quantity--;
                                  });
                                }
                              },
                              child: Container(
                                height: 26, width: 26,
                                decoration: BoxDecoration(color: Color(0xffE6E6E6), shape: BoxShape.circle),
                                child: Center(child: Icon(Icons.remove, color: white,size: 15)),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Text("${quantity}", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 18),),
                            const SizedBox(width: 5,),
                            GestureDetector(
                              onTap: (){
                                updateSetState((){
                                  quantity++;
                                });
                              },
                              child: Container(
                                height: 26, width: 26,
                                decoration: BoxDecoration(color: greenPea, shape: BoxShape.circle,),
                                child: Center(child: Icon(Icons.add, color: white, size: 15),),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 16,),
                    Text("₦ ${price}", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 16),),
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  onTap: (){
                    if(inStock == true){
                      Get.back();
                      productController.addProductToCart(shopId: widget.productUnderCategory!.shopId!.toString(), productId: widget.productUnderCategory!.id!, quantity: quantity);
                    }else{
                      Get.snackbar("Failed", "This product is out of stock. Kindly check later for availability", backgroundColor: Color(0xffC61F2A), colorText: Colors.white);
                    }
                  },
                  child: Container(width: double.infinity, height: 50,
                    decoration: BoxDecoration(color: inStock == true ? greenPea : Colors.grey, borderRadius: BorderRadius.circular(30)),
                    child:Center(child: Center(
                      child: Text(
                        "Continue",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: white, fontWeight: FontWeight.w400, fontSize: 16),),
                    ),
                  ),
                ),
              ))
            ],
          ),
        );
      }), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),),
      isScrollControlled: true, isDismissible: false,
    );
  }

  @override
  void initState() {
    productController.getProductId(productId: widget.productUnderCategory!.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: ProductController(),
        builder: (controller){
      return  controller.productReviewsLoadingState == true  && controller.productReviewsErrorState == false ? CircularLoadingWidget() :
        SafeArea(top: false, bottom: false,
          child: Scaffold(
            backgroundColor: const Color(0xffEEEEEE),
            appBar: AppBar(
              backgroundColor: const Color(0xffEEEEEE),
              elevation: 1,
              title: Text("Details", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 18, fontWeight: FontWeight.w500),),
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
            ),
            body: AnimatedColumn(
                children: [
                  const SizedBox(height: 20,),
                  Container(
                    height: MediaQuery.of(context).size.height/2.7, width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child:  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(widget.productUnderCategory?.image ?? imagePlaceHolder, fit: BoxFit.cover,),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Divider(),
                  Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Product Details",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black)),
                          const SizedBox(height: 5,),
                          Text(widget.productUnderCategory?.description ?? "", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Color(0xffD9F2EA),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Text(
                                  "Rating: ${widget.productUnderCategory?.averageRating?.substring(0,3) ?? ""}",
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w600),
                                ),),
                              RatingBar.builder(
                                glowColor:  const Color(0xffF2994A),
                                itemSize: 12,
                                initialRating: 5.0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star, size: 12,
                                  color: Color(0xffF2994A),
                                ),
                                onRatingUpdate: (rating) {
                                  if (kDebugMode) {
                                    print(rating);
                                  }
                                },
                              ),
                            ],
                          ),
                          const Divider(),
                          const Text("Product Category",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black)),
                          const SizedBox(height: 5,),
                          Text(widget.productUnderCategory?.category?.name ?? "", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),),
                          const SizedBox(height: 10,),
                          const Text("Price",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black)),
                          const SizedBox(height: 5,),
                          Text("₦ ${widget.productUnderCategory?.price ?? ""}", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),),
                        ],
                      )
                  ),
                  const SizedBox(height: 10,),
                  const Text("Date added",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black)),
                  const SizedBox(height: 5,),
                  Text(CustomDate.slash(widget.productUnderCategory?.createdAt?.toString() ?? DateTime.now().toString()),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),),
                  const SizedBox(height: 10,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Availability status",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black)),
                          const SizedBox(height: 5,),
                          Text(widget.productUnderCategory?.inStock == true ? "In stock" : "Out of Stock",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),),
                        ],
                      ),
                      widget.productUnderCategory?.inStock == true ? const SizedBox() : Image.asset("assets/png/out-of-stock.png", height: 20, width: 20,)
                    ],
                  ),
                  const SizedBox(height: 15,),
                  const Text("Reviews",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black)),
                  const SizedBox(height: 10,),
                  controller.productReviewsResponse!.data!.isNotEmpty ? Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, physics: BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          ...List.generate(controller.productReviewsResponse!.data!.length, (index){
                            final reviews = controller.productReviewsResponse?.data?[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: black)),
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          child: Image.network(profilePicturePlaceHolder),
                                          radius: 15, backgroundColor: Colors.transparent,
                                        ),
                                        const SizedBox(width: 10,),
                                        Text("${reviews?.user?.firstName} ${reviews?.user?.lastName }",
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    Text(reviews!.comment!, overflow: TextOverflow.ellipsis, maxLines: 5,)
                                  ],
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ) : const SizedBox(),
                  const SizedBox(height: 50,),
                  GestureDetector(
                    onTap: (){
                      quantity = 1;
                      showRestaurantBottomSheet(imagePath: widget.productUnderCategory?.image ?? "",
                          name: widget.productUnderCategory?.name ?? '',
                          description: widget.productUnderCategory?.description ?? '',
                          price: widget.productUnderCategory?.price ?? '',
                        inStock: widget.productUnderCategory!.inStock!
                      );
                    },
                    child: Container(width: double.infinity, height: 50,
                      decoration: BoxDecoration(color: greenPea, borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          "Add to cart",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: white, fontWeight: FontWeight.w400, fontSize: 16),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50,),
                ], padding: EdgeInsets.symmetric(horizontal: 20)),
          )
      );
    });
  }
}

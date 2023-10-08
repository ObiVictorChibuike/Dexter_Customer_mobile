import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ProductPalleteWidget extends StatefulWidget {
  final int index;
  const ProductPalleteWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<ProductPalleteWidget> createState() => _ProductPalleteWidgetState();
}

class _ProductPalleteWidgetState extends State<ProductPalleteWidget> {
  final homeController = Get.put(HomeController());
  final _scrollController = ScrollController();
  @override
  void initState() {
    homeController.getProductsInCategory(categoryId: widget.index.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
        builder: (controller){
      return SizedBox(
        child: GridView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1 / 1.9, crossAxisCount: 2, mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemCount: controller.productsInCategoryResponse!.products!.length,
          itemBuilder: (_,index){
            final item = controller.productsInCategoryResponse!.products?[index];
            return Card(elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                // height: MediaQuery.of(context).size.height * .43,
                width: MediaQuery.of(context).size.width * .42,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 130, width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: item?.image == null || item?.image == "" ?
                                const NetworkImage(imagePlaceHolder) :
                                NetworkImage(item!.image!),fit: BoxFit.cover,)),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          Expanded(
                            child: Text(item?.name.toString() ?? "",
                                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2,),
                      RatingBar.builder(
                        glowColor:  const Color(0xffF2994A),
                        itemSize: 10,
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
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          Expanded(
                            child: Text(item?.description.toString() ?? "",
                                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xff4F4F4F))),
                          ),
                        ],
                      ),
                      Spacer(),
                      const Divider(),
                      const SizedBox(height: 5,),
                      Text('₦ ${item?.price.toString()}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 5,),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

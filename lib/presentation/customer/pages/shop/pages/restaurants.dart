import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_text_field.dart';
import 'package:dexter_mobile/app/shared/widgets/empty_screen.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/controller/restaurant_controller.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/pages/shop_details_and_menu.dart';
import 'package:dexter_mobile/presentation/customer/widget/circular_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Restaurants extends StatefulWidget {
  final String ServiceId;
  final String ServiceName;
  const Restaurants({Key? key, required this.ServiceId, required this.ServiceName}) : super(key: key);

  @override
  State<Restaurants> createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  final query = TextEditingController();
  final _ctrl = Get.put(RestaurantController());

  @override
  void initState() {
    _ctrl.getRestaurantsAroundYou();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantController>(
      init: RestaurantController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: white, scrolledUnderElevation: 0.0,
              elevation: 0.0,
              leading: GestureDetector(
                  onTap: () async {
                    Get.back();
                    query.clear();
                    await _ctrl.getRestaurantsAroundYou();
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
              title: Text("Food Delivery", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 18, fontWeight: FontWeight.w600),),),
            body: _ctrl.restaurantAroundYouLoadingState == true ? CircularLoadingWidget() :
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 30,),
                  DexterTextField(
                    controller: query,
                      onChanged: (value) async {
                      if(query.text.isEmpty){
                        await _ctrl.getRestaurantsAroundYou();
                      }else{
                        final shops = _ctrl.shopsAroundYouResponse?.data?.where((restaurants){
                          final nameLowerCase = restaurants.name!.toLowerCase();
                          final queryLowerCase = query.text.toLowerCase();
                          return nameLowerCase.contains(queryLowerCase);
                        }).toList();
                        setState(() {
                          _ctrl.shopsAroundYouResponse?.data = shops;
                        });}
                      },
                      filledColor: Colors.transparent,
                      minLines: null, maxLines: 1, expands: false,
                      hintText: "Search Restaurants",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(AssetPath.search),
                      )
                  ), _ctrl.shopsAroundYouResponse == null || _ctrl.shopsAroundYouResponse!.data!.isEmpty || _ctrl.shopsAroundYouResponse!.data == [] || _ctrl.shopsAroundYouResponse!.data == null ?
                  EmptyScreen(emptyScreenMessage: "No item found",
                    icon: Lottie.asset('assets/lottie/empty.json', height: 220, width: 220),
                  ) :
                  Column(
                    children: [
                      ...List.generate(_ctrl.shopsAroundYouResponse!.data!.length, (index) =>
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: GestureDetector(
                              onTap: (){
                                Get.to(()=> ShopDetailsAndMenu(id: _ctrl.shopsAroundYouResponse!.data![index].id.toString(), name: _ctrl.shopsAroundYouResponse!.data![index].name!,));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white,
                                      boxShadow: [
                                      BoxShadow(
                                      color: Colors.grey,
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3), // Shadow position (bottom)
                                ),
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: const Offset(-3, 0), // Shadow position (left)
                                ),
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: const Offset(3, 0), // Shadow position (right)
                                ),
                                ],),
                                  height: 265, width: MediaQuery.of(context).size.width / 1.1,
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                                        height: 140, width: double.maxFinite,
                                        child: Image.network(_ctrl.shopsAroundYouResponse!.data![index].coverImage ?? imagePlaceHolder,
                                          fit: BoxFit.cover,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                RatingBar.builder(
                                                  itemSize: 8,
                                                  initialRating: double.parse(_ctrl.shopsAroundYouResponse!.data![index].averageRating ?? "0.0"),
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                                  itemBuilder: (context, _) => Icon(
                                                    Icons.star, size: 10,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                                _ctrl.shopsAroundYouResponse!.data![index].averageRating!.length <= 1 ?
                                                Text(_ctrl.shopsAroundYouResponse!.data![index].averageRating ?? "",
                                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12,color: black, fontWeight: FontWeight.w700,),) :
                                                Text(_ctrl.shopsAroundYouResponse!.data![index].averageRating?.substring(0,3) ?? "",
                                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12,color: black, fontWeight: FontWeight.w700,),),
                                              ],
                                            ),
                                            Text(_ctrl.shopsAroundYouResponse!.data![index].name!,
                                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),),
                                            Row(
                                              children: [
                                                Text("Location: ", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w500),),
                                                Expanded(
                                                  child: Text(
                                                    "${_ctrl.shopsAroundYouResponse!.data![index].contactAddress?.fullAddress ?? ""}", overflow: TextOverflow.ellipsis, maxLines: 2,
                                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w300, ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text("${_ctrl.shopsAroundYouResponse!.data![index].biography}", overflow: TextOverflow.ellipsis, maxLines: 2,
                                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: greenPea, fontSize: 12, fontWeight: FontWeight.w400),),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
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

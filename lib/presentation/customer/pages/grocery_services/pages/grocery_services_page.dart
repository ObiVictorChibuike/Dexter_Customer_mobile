import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


class GroceryServicesPage extends StatefulWidget {
  const GroceryServicesPage({Key? key}) : super(key: key);

  @override
  State<GroceryServicesPage> createState() => _GroceryServicesPageState();
}

class _GroceryServicesPageState extends State<GroceryServicesPage> {
  final searchQueryController = TextEditingController();
  final _scrollController = ScrollController();

  final groceries = [
    {
      "assets": AssetPath.papaya,
      "title": "Fruits & \nVegetables"
    },
    {
      "assets": AssetPath.breakfast,
      "title": "Breakfast"
    },
    {
      "assets": AssetPath.beverages,
      "title": "Beverages"
    },
    {
      "assets": AssetPath.meat,
      "title": "Meat & Fish"
    },
    {
      "assets": AssetPath.snacks,
      "title": "Snacks"
    },
    {
      "assets": AssetPath.diary,
      "title": "Diary"
    },

  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: white,
            elevation: 0.0,
            leading: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Icon(Icons.arrow_back, color: black,)),
            title: Text("Grocery Shopping", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 16, fontWeight: FontWeight.w600),),),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 30,),
                DexterTextField(
                    controller: searchQueryController,
                    onChanged: (value){},
                    filledColor: Colors.transparent,
                    minLines: null, maxLines: 1, expands: false,
                    hintText: "Search items to buy",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(AssetPath.search),
                    )
                ),
                GridView(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 130,
                      childAspectRatio: 3 / 6,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20
                  ),
                  physics: BouncingScrollPhysics(),
                  children: List.generate(groceries.length, (index){
                    return GestureDetector(
                      onTap: (){},
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: white),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        height: 80, width: 80,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(image: NetworkImage(groceries[index]["assets"]!), fit: BoxFit.cover)
                                        ),
                                      )),
                                  const SizedBox(width: 8,),
                                  Text(groceries[index]["title"]!, overflow: TextOverflow.fade,
                                    style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12,color: black, fontWeight: FontWeight.w700,),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        )
    );
  }
}

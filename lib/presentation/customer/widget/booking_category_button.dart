import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingCategoryButton extends StatelessWidget {
  final int? selected;
  final Function? callback;
  final List<String>? category;
  const BookingCategoryButton({this.selected, this.callback, this.category, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller){
          return Container(
            height: 35,
            // decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(100)),
            child: ListView.separated(
              scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => callback!(index),
                child: Container(
                  // width: 72.5,
                    padding: EdgeInsets.symmetric(
                      // horizontal: index == selected ? 32 : 0, vertical: 7),
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                        color: index == selected && selected == 0
                            ? thunder : index == selected && selected == 1 ? tulipTree
                            : index == selected && selected == 2 ? Colors.deepOrangeAccent : index == selected && selected == 3 ? greenPea :
                        index == selected && selected == 4 ? persianRed : Colors.transparent,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Text(category![index], maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: index == selected ? white
                                : dustyGray,
                            fontFamily: 'Euclid Circular',
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      ),
                    )),
              ),
              separatorBuilder: (_, __) => SizedBox(
                width: 10,
              ),
              itemCount: category!.length,
            ),
          );
        });
  }
}

import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryTimeButton extends StatelessWidget {
  final int? selected;
  final Function? callback;
  final List<String?>? category;
  final Widget? buttonIcon;
  const CategoryTimeButton({this.selected, this.callback, this.category, Key? key, this.buttonIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45, decoration: BoxDecoration(shape: BoxShape.circle),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListView.separated(
        scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => callback!(index),
          child: Container(
              padding: EdgeInsets.all(8), width: 85,
              decoration: BoxDecoration(color: index == selected ? greenPea : Color(0xffE6E6E6),
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buttonIcon ?? SizedBox(),
                    buttonIcon != null ? const SizedBox(width: 5,) : SizedBox(),
                    Expanded(
                      child: Text(category![index] ?? "", overflow: TextOverflow.ellipsis, maxLines: 1, textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: index == selected ? white : Colors.black45, fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              )),
        ),
        separatorBuilder: (_, __) => SizedBox(
          width: 8,
        ),
        itemCount: category!.length,
      ),
    );
  }
}

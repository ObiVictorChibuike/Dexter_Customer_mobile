import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class FoodTile extends StatelessWidget {
  final String title;
  final String label;
  final String imagePath;
  const FoodTile({Key? key, required this.title, required this.label, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20), decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(14)),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(imagePath),
          const SizedBox(width: 10,),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text(label)
            ],
          )
        ],
      ),
    );
  }
}

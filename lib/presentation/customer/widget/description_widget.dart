import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String? firstHalf;
  String? secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 100) {
      firstHalf = widget.text.substring(0, 100);
      secondHalf = widget.text.substring(100, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf!.isEmpty
          ?  Text(firstHalf!, textAlign: TextAlign.start,)
          :  Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Text(flag ? (firstHalf! + "...") : (firstHalf! + secondHalf!), textAlign: TextAlign.start,),
           InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                 Text(
                  flag ? "show more" : "show less",
                  style: TextStyle(color: greenPea, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
          ),
        ],
      ),
    );
  }
}
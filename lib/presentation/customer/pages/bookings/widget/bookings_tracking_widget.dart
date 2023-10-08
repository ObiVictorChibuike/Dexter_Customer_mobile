import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

// ignore: must_be_immutable
class VerticalStepper extends StatefulWidget {
  List<MyStep>? steps;
  double? dashLength;
  Color? iconColor;
  VerticalStepper({this.steps, this.dashLength, this.iconColor});

  @override
  _VerticalStepperState createState() => _VerticalStepperState();
}

class _VerticalStepperState extends State<VerticalStepper> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              height: 1000,
              top: 23,
              left: 24,
              child: DottedLine(
                lineThickness: 2,
                dashLength: widget.dashLength != null ? widget.dashLength! : 5.0,
                direction: Axis.vertical,
                lineLength: double.infinity,
                dashColor: Color(0xffE6E6E6),
              ),
            ),
            Column(
              children: [
                for (int i = 0; i < widget.steps!.length - 1; i++)
                  Container(
                    child: widget.steps![i],
                  )
              ],
            )
          ],
        ),
        Stack(
          children: [
            Positioned(
              top: 4,
              left: 24,
              child: DottedLine(
                direction: Axis.vertical,
                lineThickness: 2,
                lineLength: 22,
                dashColor: Color(0xffE6E6E6),
                dashLength: widget.dashLength!,
              ),
            ),
            Container(
              child: widget.steps!.last,
            )
          ],
        )
      ],
    );
  }
}

class MyStep extends StatefulWidget {
  final String? title;
  final Widget? content;
  final Color? iconStyle;
  final bool? shimmer;
  final bool? isExpanded;
  final Function(bool)? onExpansion;

  const MyStep({
    this.title,
    this.content,
    this.iconStyle,
    this.shimmer = false,
    this.isExpanded = true,
    this.onExpansion,
  });

  @override
  _StepState createState() => _StepState();
}

class _StepState extends State<MyStep> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        trailing: SizedBox(),
        initiallyExpanded: widget.isExpanded!,
        onExpansionChanged: widget.onExpansion,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        leading: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                child: Stack(children: [
                  Container(
                    height: 18, width: 18,
                    decoration: BoxDecoration(
                      color: widget.iconStyle != null
                          ? widget.iconStyle
                          : Colors.white,
                        shape: BoxShape.circle
                    ),
                    child: Center(
                      child: Icon(Icons.check, size: 15, color: Colors.white,),
                    ),
                  ),
                ]),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title!, style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600, fontSize: 16, color: greenPea),),
            const SizedBox(height: 3,),
            Column(
              children: [widget.content!],
            ),
          ],
        ),
      ),
    );
  }
}
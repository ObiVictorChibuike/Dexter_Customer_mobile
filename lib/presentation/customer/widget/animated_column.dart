import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimatedColumn extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  const AnimatedColumn({Key? key, required this.children, required this.padding, this.crossAxisAlignment, this.mainAxisAlignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: AnimationLimiter(
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 200),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

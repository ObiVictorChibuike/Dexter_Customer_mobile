import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class EmptyScreen extends StatelessWidget {
  final String? emptyScreenMessage;
  final Widget icon;
  const EmptyScreen({Key? key, this.emptyScreenMessage, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              Text(emptyScreenMessage ?? "", style: TextStyle(color: Color(0xFF52575C), fontSize: 15),),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 70),
                child: SizedBox(height: 48, width: double.maxFinite,),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
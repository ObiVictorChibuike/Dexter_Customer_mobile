import 'package:flutter/material.dart';

class EmptyScreenWidget extends StatelessWidget {
  final String message;
  final Widget icon;
  final double height;
  const EmptyScreenWidget({Key? key, required this.message, required this.icon, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(height: height,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 10,),
          Text(message, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, color: Colors.red, fontWeight: FontWeight.w400),),
        ],
      ),
    ) ;
  }
}

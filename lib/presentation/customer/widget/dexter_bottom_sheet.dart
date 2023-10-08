import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class MyBottomSheet{
  void showDismissibleBottomSheet({required BuildContext context, required List<Widget> children, double? height,}){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),),
        isScrollControlled: true, context: context,
        builder: (ctx) => Container(constraints: BoxConstraints(maxHeight: height ?? MediaQuery.of(context).size.height/1.8,),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Container(height: 5, width: 50,
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5),),),
              const SizedBox(height: 30,),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: children
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void showNonDismissibleBottomSheet({
    required BuildContext context,
    required List<Widget> children,
    double? height,
  }){
    showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
        ),
        isScrollControlled: true,
        context: context,
        builder: (ctx) => Container(
          constraints: BoxConstraints(maxHeight: height ?? MediaQuery.of(context).size.height/1.8,),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: white,),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              // Container(height: 5, width: 50,
              //   decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5),),),
              // const SizedBox(height: 30,),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: children
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

}
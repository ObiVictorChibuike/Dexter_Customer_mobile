import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElectricalVendorDetail extends StatefulWidget {
  const ElectricalVendorDetail({Key? key}) : super(key: key);

  @override
  State<ElectricalVendorDetail> createState() => _ElectricalVendorDetailState();
}

class _ElectricalVendorDetailState extends State<ElectricalVendorDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: white,
            elevation: 0.0,
            leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back, color: black,)),
            title: Text("New Service Request", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 16, fontWeight: FontWeight.w600),),),
          body: ListView(
            children: [
              const SizedBox(height: 32,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey),),
                child: Column(
                  children: [
                    Text("Electrical Repair", style: Theme.of(context).textTheme.bodySmall!.
                    copyWith(color: Color(0xff131313), fontSize: 16, fontWeight: FontWeight.w600),),
                    const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("AC Repair", style: Theme.of(context).textTheme.bodySmall!.
                      copyWith(color: Color(0xff5B5B5B), fontSize: 16, fontWeight: FontWeight.w600),),
                    ),
                    const SizedBox(height: 16,),
                    Text("Message", style: Theme.of(context).textTheme.bodySmall!.
                    copyWith(color: Color(0xff5B5B5B), fontSize: 12, fontWeight: FontWeight.w600),),
                    const SizedBox(height: 8,),
                    Container(width: double.infinity, decoration: BoxDecoration(color: Color(0xffD6D8DB),
                          border: Border.all(color: Color(0xff999999),),
                          borderRadius: BorderRadius.circular(16)),
                      child: Text("My air conditioning unit has been experiencing "
                            "some issues lately, such as blowing hot air "
                            "and making loud noises. I am concerned that "
                            "the problem will worsen if left unattended, "
                            "and I would like to have it fixed as soon as possible.", textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodySmall!.
                        copyWith(color: Color(0xff999999), fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Text("Scheduled Appointment", style: Theme.of(context).textTheme.bodySmall!.
                    copyWith(color: Color(0xff5B5B5B), fontSize: 12, fontWeight: FontWeight.w600),),
                    const SizedBox(height: 8,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("4th May, 2023", style: Theme.of(context).textTheme.bodySmall!.
                        copyWith(color: Color(0xff131313), fontSize: 12, fontWeight: FontWeight.w600),),

                        Text("Evening", style: Theme.of(context).textTheme.bodySmall!.
                        copyWith(color: Color(0xff131313), fontSize: 12, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    Text("Location", style: Theme.of(context).textTheme.bodySmall!.
                    copyWith(color: Color(0xff5B5B5B), fontSize: 12, fontWeight: FontWeight.w600),),
                    const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("Lekki Phase 1", style: Theme.of(context).textTheme.bodySmall!.
                      copyWith(color: Color(0xff5B5B5B), fontSize: 12, fontWeight: FontWeight.w600),),
                    ),
                    const SizedBox(height: 16,),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                              padding: EdgeInsets.all(10), decoration: BoxDecoration(color: greenPea, borderRadius: BorderRadius.circular(15)),
                              child: Text("Accept",
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(color: white, fontSize: 14, fontWeight: FontWeight.w600),)),
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                              padding: EdgeInsets.all(10), decoration: BoxDecoration(color: Color(0xffFCEFEF), borderRadius: BorderRadius.circular(15)),
                              child: Text("Decline", style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Color(0xffCC2929), fontSize: 14, fontWeight: FontWeight.w600),)),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}

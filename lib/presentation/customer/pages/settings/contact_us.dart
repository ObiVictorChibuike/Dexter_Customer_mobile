import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: Color(0xffFAFAFA),
          appBar: AppBar(
            backgroundColor: Color(0xffFAFAFA),
            elevation: 0.0,
            title: Text("Contact Us", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 16),),
            leading: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back, color: black,)),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(width: 28,),
                Container(width: double.infinity,
                  padding: EdgeInsets.all(16), decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(6)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AssetPath.customerService, height: 35, width: 35,),
                          const SizedBox(width: 16,),
                          Text("Customer Service", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 14),),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: black, size: 16,),
                    ],
                  ),
                ),
                const SizedBox(width: 16,),
                Container(width: double.infinity,
                  padding: EdgeInsets.all(16), decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(6)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AssetPath.web, height: 35, width: 35,),
                          const SizedBox(width: 16,),
                          Text("Website", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 14),),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: black, size: 16),
                    ],
                  ),
                ),
                const SizedBox(width: 16,),
                Container(width: double.infinity,
                  padding: EdgeInsets.all(16), decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(6)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AssetPath.mail, height: 35, width: 35,),
                          const SizedBox(width: 16,),
                          Text("Mail", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 14),),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: black,size: 16),
                    ],
                  ),
                ),
                const SizedBox(width: 16,),
                Container(width: double.infinity,
                  padding: EdgeInsets.all(16), decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(6)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AssetPath.instagram, height: 35, width: 35,),
                          const SizedBox(width: 16,),
                          Text("Instagram", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 14),),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: black,size: 16),
                    ],
                  ),
                ),
                const SizedBox(width: 16,),
                Container(width: double.infinity,
                  padding: EdgeInsets.all(16), decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(6)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AssetPath.twitter, height: 35, width: 35,),
                          const SizedBox(width: 16,),
                          Text("Twitter", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 14),),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: black,size: 16),
                    ],
                  ),
                ),
                const SizedBox(width: 16,),
              ],
            ),
          ),
        )
    );
  }
}

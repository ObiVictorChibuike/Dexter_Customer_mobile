import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';


class Faqs extends StatefulWidget {
  const Faqs({Key? key}) : super(key: key);

  @override
  State<Faqs> createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  final pageController = PageController();
  int selectedIndex = 0;

  void changeIndex(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  final faqOptions = [
    "General",
    "Account",
    "Bookings",
    "Payment",
  ];

  final faq = [
    {
      "question": "How can I use DexterApp as a customer ?",
      "answer": "1. Visit getdexterapp.com or download the customer app on Playstore/Appstore @DexterApp "
                "\n\n2. Sign in if you are a registered user or Create an Account here. "
                "\n\n3. Browse through a wide range of our services and pick any of your choice"
    },
    {
      "question": "How can I use DexterApp as a Vendor ?",
      "answer": "1. Visit getdexterapp.com or download the Vendor app on Playstore/Appstore @DexterApp "
                "\n\n2. Sign in if you are a registered user or Create an Account here. "
                "\n\n3. Browse through a wide range of our services and pick any of the service you offer"
    },
    {
      "question": "Is Dexter free to use ?",
      "answer":   "Yes DexterApp is absolutely free to use"
    },
    {
      "question": "How do I report a scam case?",
      "answer": "In a scam or if you have suspicions that one of our users may deceive "
                 "people, please tell us about it via email @ support@dexterapp.com "
                 "Share a link to the profile of such a user and describe all the details you "
                 "have. Attach screenshots of your conversations and other pictures or "
                 "materials that can give us more information in taking the necessary steps."
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: Color(0xffFAFAFA),
          appBar: AppBar(
            backgroundColor: Color(0xffFAFAFA),
            elevation: 0.0,
            title: Text("FAQs", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 16),),
            leading: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
                child: Icon(Icons.arrow_back, color: black,)),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 24,),
                ...List.generate(faq.length, (index){
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: ExpandableNotifier(
                      child: Column(
                        children: [
                          ScrollOnExpand(
                            scrollOnExpand: true, scrollOnCollapse: true,
                            child: ExpandablePanel(
                              theme: const ExpandableThemeData(headerAlignment: ExpandablePanelHeaderAlignment.center, tapBodyToCollapse: true,),
                              header: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text(faq[index]["question"]!, style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14, fontWeight: FontWeight.w700,),),
                              ),
                              collapsed: const SizedBox(height: 20,),
                              expanded:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10,),
                                  Text(faq[index]["answer"]!, textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14),),
                                ],
                              ),
                              builder: (_, collapsed, expanded) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                  child: Expandable(
                                    collapsed: collapsed,
                                    expanded: expanded,
                                    theme: const ExpandableThemeData(crossFadePoint: 0),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        )
    );
  }
}

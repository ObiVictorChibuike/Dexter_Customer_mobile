import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'chat_screen.dart';


class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final chats = [
    {
      "assets": AssetPath.dp1,
      "title": "Schowalter LLC",
      "subtitle": "...Thank you,"
    },
    {
      "assets": AssetPath.dp2,
      "title": "Wuckert - Price",
      "subtitle": "Soluta natus quisquam omnis nobis vel non reiciendis et et."
    },
    {
      "assets": AssetPath.dp3,
      "title": "Johnston and Sons",
      "subtitle": "Doloremque fugiat maxime repellat necessitatibus voluptatem unde quos velit."
    },
    {
      "assets": AssetPath.dp4,
      "title": "Treutel Group",
      "subtitle": "Pariatur perferendis corporis corrupti est voluptatem et nostrum ut quia."
    },
    {
      "assets": AssetPath.dp5,
      "title": "Bradtke Group",
      "subtitle": "Fugiat eligendi et cumque dolor voluptates praesentium dolorem."
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: SvgPicture.asset(AssetPath.search),
              ),
            ],
            elevation: 0.0, backgroundColor: white,
            title: Text("Messages", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 20, fontWeight: FontWeight.w600),),
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 30,),
              ...List.generate(chats.length, (index){
                return GestureDetector(
                  onTap: (){
                    Get.to(()=> ChatScreen(chatName: chats[index],));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    height: 80, width: double.maxFinite,
                    child: Row(
                      children: [
                        Image.asset(chats[index]["assets"]!, height: 60, width: 60,),
                        const SizedBox(width: 20,),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(chats[index]["title"]!, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),),
                              const SizedBox(height: 5,),
                              Text(chats[index]["subtitle"]!, maxLines: 1,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray, fontSize: 12, fontWeight: FontWeight.w600),),
                            ],
                          ),
                        ),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 20, width: 20,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: greenPea),
                              child: Center(child: Text("4", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: white, fontSize: 12, fontWeight: FontWeight.w600),),),
                            ),
                            const SizedBox(height: 5,),
                            Text("11:37am", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray, fontSize: 12, fontWeight: FontWeight.w600),)
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        )
    );
  }
}

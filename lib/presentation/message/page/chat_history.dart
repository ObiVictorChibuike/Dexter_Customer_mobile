import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/widgets/message_history_widget.dart';
import 'package:dexter_mobile/presentation/message/controller/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'contact_page.dart';


class ChatHistory extends StatefulWidget {
  const ChatHistory({Key? key}) : super(key: key);

  @override
  State<ChatHistory> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          elevation: 0.0, backgroundColor: Colors.white,
          title: Text("Message", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 20, fontWeight: FontWeight.w700),),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){Get.to(()=> const ContactPage());},
          child: Image.asset("assets/png/contact-us.png", color: Colors.white, height: 35, width: 35,), backgroundColor: greenPea,
        ),
        body: MessageHistoryWidget(),
      ),
    );
  }
}

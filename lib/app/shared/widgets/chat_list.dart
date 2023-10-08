import 'package:dexter_mobile/app/shared/widgets/chat_left_item.dart';
import 'package:dexter_mobile/presentation/message/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_right_item.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (controller){
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 50),
        child: CustomScrollView(
          reverse: true, controller: controller.scrollController,
          slivers: [
            SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index){
                       var item = controller.messageContentList[index];
                       if(controller.currentUserId == item.uid){
                         return chatRightItem(item);
                       }
                       return chatLeftItem(item);
                    },
                  childCount: controller.messageContentList.length
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

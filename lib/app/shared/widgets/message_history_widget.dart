import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/utils/date.dart';
import 'package:dexter_mobile/datas/model/chat/msg.dart';
import 'package:dexter_mobile/presentation/message/controller/contact_controller.dart';
import 'package:dexter_mobile/presentation/message/controller/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageHistoryWidget extends StatefulWidget {
  const MessageHistoryWidget({Key? key}) : super(key: key);

  @override
  State<MessageHistoryWidget> createState() => _MessageHistoryWidgetState();
}

class _MessageHistoryWidgetState extends State<MessageHistoryWidget> {
  final _controller = Get.put(MessageController());
  final contactController = Get.put(ContactController());
  Widget messageListItem(QueryDocumentSnapshot<Msg> item){
    return Container(
      padding: EdgeInsets.only(top: 10, left: 0, right: 15),
      child: InkWell(
        onTap: () {
          contactController.moveToChat(item: item);
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(padding: EdgeInsets.only(top: 0, left: 15, right: 15),
              child: SizedBox(
                height: 45, width: 45,
                child: CachedNetworkImage(
                  imageUrl: item.data().from_uid == _controller.currentUserId ?
                  item.data().to_avatar! : item.data().from_avatar!,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 45, height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(54)),
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover)),
                  ),
                  errorWidget: (context, url, error)=> Image(image: AssetImage(imagePlaceHolder),),
                ),
              ),
            ),
            Expanded(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.data().from_uid == _controller.currentUserId
                      ? item.data().to_name ! : item.data().from_name!,
                    overflow: TextOverflow.clip, maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(height: 5,),
                  item.data().last_msg == "[image ]" ?
                  Row(
                    children: [
                      const Icon(Icons.photo, size: 20,),
                      const SizedBox(width: 5,),
                      Text("Photo",
                        overflow: TextOverflow.ellipsis, maxLines: 1,
                        style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 13),
                      ),
                    ],
                  ) :
                  Text(item.data().last_msg ?? "",
                    overflow: TextOverflow.ellipsis, maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 13),
                  ),
                ],
              ),
            ),
            Text(duTimeLineFormat((item.data().last_time as Timestamp).toDate()),
              overflow: TextOverflow.clip, maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey , fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      init: MessageController(),
        builder: (controller){
      return SmartRefresher(
        enablePullDown: true,
          enablePullUp: true,
          controller: controller.refreshController,
          onLoading: controller.onLoading,
          onRefresh: controller.onRefresh,
          header: WaterDropHeader(),
          child: controller.messageList.isEmpty || controller.messageList == [] ? Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/png/empty_chat.png", height: 200, width: 150,),
                const SizedBox(height: 40,),
                Text("No message to see here!", style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w700),)
              ],
            ),
          ) :
          CustomScrollView(
            slivers: [
              SliverPadding(padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index){
                    var item = controller.messageList[index];
                    return Column(
                      children: [
                        messageListItem(item),
                        const Divider(),
                      ],
                    );
                  }, childCount: controller.messageList.length,
                  ),
                ),

              ),
            ],
          )
      );
    });
  }
}

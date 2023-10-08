import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/datas/model/chat/msgcontent.dart';
import 'package:dexter_mobile/presentation/message/page/image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget chatRightItem(MsgContent item){
  return item.type == "text" ?
  BubbleSpecialOne(
    delivered: true,
    text: "${item.content}", isSender: true, color: greenPea,
    textStyle: TextStyle(fontSize: 13, color: Colors.white),
  ) : BubbleNormalImage(
    onTap: (){
      Get.to(()=> ImageView(imageUrl: item.content,));
    },
    id: "image",
    image: CachedNetworkImage(imageUrl: "${item.content}"),
    color: greenPea,
    isSender: true,
    tail: true,
    delivered: true,
  );
}
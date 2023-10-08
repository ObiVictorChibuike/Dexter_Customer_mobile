import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  final bool? isUser;
  final String? message;
  const ChatBox({Key? key, this.isUser, this.message}) : super(key: key);

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  @override
  Widget build(BuildContext context) {
    return Align(alignment: widget.isUser == true ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: widget.isUser == true ? EdgeInsets.only(right: 12, left: 142, top: 12,) : EdgeInsets.only(left: 12, right: 142, top: 12,),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: widget.isUser == true ? greenPea : Color(0xffE6E6E6), 
              borderRadius: BorderRadius.only(topLeft: Radius.circular(widget.isUser == true ? 10 : 0), 
                  topRight: Radius.circular(widget.isUser == true ? 0 : 10), bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
          child: Text(widget.message!,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13, fontWeight: FontWeight.w400, color: widget.isUser == true ? white : black),),
        ));
  }
}

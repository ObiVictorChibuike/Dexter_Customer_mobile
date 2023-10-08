import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_text_field.dart';
import 'package:dexter_mobile/presentation/customer/pages/messages/widget/chat_box.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  final dynamic chatName;
  const ChatScreen({Key? key, required this.chatName}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Widget> chats = [
    ChatBox(
      message: "Hi, Good Morning I just booked you for tomorrow",
      isUser: true,
    ),
    ChatBox(
      message: "Hi, Good Morning",
      isUser: false,
    ),
    ChatBox(
      message: "Alright, I’ve received your order I’ll see you tomorrow at 8pm",
      isUser: false,
    ),
    ChatBox(
      message: "Thank you, I look forward to see you",
      isUser: false,
    ),
  ];
  final messageController = TextEditingController();
  bool messageMode = false;
  ScrollController? _scrollController;

  void scrollToBottom() {
    final bottomOffset = _scrollController!.position.maxScrollExtent;
    _scrollController!.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
                child: Icon(Icons.arrow_back, color: black,)),
            elevation: 0.0, backgroundColor: white,
            title: Text(widget.chatName["title"], style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 16, fontWeight: FontWeight.w600),),
          ),
          body: Column(
            children: [
              Expanded(
                  child: ListView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ...chats,
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 41),
                child: Row(
                  children: [
                    Expanded(
                        child: DexterTextField(
                          controller: messageController,
                          filledColor: Colors.transparent,
                          minLines: null, maxLines: 1, expands: false,
                          hintText: "Type here",
                        ),
                    ),
                    const SizedBox(width: 10,),
                   GestureDetector(
                     onTap: (){
                       if(messageController.text.isEmpty){
                         null;
                       }else{
                         chats.add(
                             ChatBox(
                               message: messageController.text,
                               isUser: true,
                             )
                         );
                       }
                       messageController.clear();
                       setState(() {});
                     },
                     child: Container(
                        height: 50, width: 50, decoration: BoxDecoration(color: greenPea, shape: BoxShape.circle),
                        child: Center(child: Icon(Icons.send, color: white,),),
                      ),
                   )
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/widgets/chat_list.dart';
import 'package:dexter_mobile/presentation/message/controller/chat_controller.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' as foundation;

class ChatScreen extends StatefulWidget {
  final String? docId;
  final String? toUid;
  final String? toName;
  final String? toAvatar;
  const ChatScreen({Key? key, this.docId, this.toUid, this.toName, this.toAvatar}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  void showImagePickerDialog(BuildContext context) async {
    return showDialog(context: context,
      builder: (context) {
        return GetBuilder<ChatController>(
            init: ChatController(),
            builder: (controller){
              return SimpleDialog(
                backgroundColor: Colors.white,
                title: Text('Upload Image', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18, fontWeight: FontWeight.w700),),
                children: [
                  SimpleDialogOption(
                    padding: EdgeInsets.all(20),
                    child: Text('Take a photo'),
                    onPressed: () async {
                      controller.onUploadImage(ImageSource.camera, widget.docId!);
                      Get.back();
                      setState(() {});
                    },
                  ),
                  SimpleDialogOption(
                    padding: EdgeInsets.all(20),
                    child: Text('Choose from Gallery'),
                    onPressed: () async {
                      controller.onUploadImage(ImageSource.gallery, widget.docId!);
                      Get.back();
                      setState(() {});
                    },
                  ),
                  SimpleDialogOption(
                    padding: EdgeInsets.all(20),
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
    );
  }
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
        init: ChatController(),
        builder: (controller){
          return SafeArea(top: false, bottom: false,
              child: Scaffold(
                backgroundColor: white,
                appBar: AppBar(
                  leading: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      }, child: Icon(Icons.arrow_back, color: white,)),
                  elevation: 0.0, backgroundColor: greenPea, centerTitle: false,
                  title: Container(padding: EdgeInsets.only(top: 0.0, bottom: 0.0, right: 0.0),
                    color: greenPea,
                    child: Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 0.0, bottom: 0.0, right: 0.0),
                          child: InkWell(
                            child: SizedBox(height: 44, width: 44,
                              child: CachedNetworkImage(
                                  imageUrl: widget.toAvatar ?? "",
                                  imageBuilder: (context, imageProvider){
                                    return Container(height: 44, width: 44,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(44),),
                                          image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
                                    );
                                  },
                                  errorWidget: (context,url, error)=>Container(height: 44, width: 44,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(44),),
                                      image: DecorationImage(image: NetworkImage(imagePlaceHolder)),
                                    ),
                                  )
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Container(width: 180, padding: EdgeInsets.only(top: 0.0, bottom: 0.0, right: 0.0),
                          color: greenPea,
                          child: Row(
                            children: [
                              SizedBox(width: 180, height: 30,
                                child: GestureDetector(
                                  onTap: (){},
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(widget.toName!, overflow: TextOverflow.clip, maxLines: 1,
                                        style: Theme.of(context).textTheme.bodySmall!.
                                        copyWith(color: white, fontSize: 16, fontWeight: FontWeight.w600),),
                                      Text(controller.toLocation ?? "Unknown Location", overflow: TextOverflow.clip, maxLines: 1,
                                        style: Theme.of(context).textTheme.bodySmall!.
                                        copyWith(color: white, fontSize: 12, fontWeight: FontWeight.w400),),                              ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  flexibleSpace: Container(
                    decoration: BoxDecoration(color: greenPea),
                  ),
                ),
                body: WillPopScope(
                  child: SafeArea(
                    child: Column(
                      children: [
                        Expanded(child: ChatList()),
                        Container(
                          height: 70, color: Color(0xffEFEFF0),
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(width: 10,),
                              InkWell(
                                child: Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: greenPea,
                                  size: 24,
                                ),
                                onTap: () {
                                  setState(() {
                                    controller.isEmojiVisible = !controller.isEmojiVisible;
                                    controller.focusNode.unfocus();
                                    controller.focusNode.canRequestFocus = true;
                                  });
                                },
                              ),
                              const SizedBox(width: 10,),
                              InkWell(
                                child: Icon(
                                  Icons.photo_outlined,
                                  color: greenPea,
                                  size: 24,
                                ),
                                onTap: () {
                                  showImagePickerDialog(context);
                                },
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: Container(
                                  child: TextField(
                                    focusNode: controller.focusNode,
                                    controller: controller.messageController,
                                    keyboardType: TextInputType.multiline,
                                    textCapitalization: TextCapitalization.sentences,
                                    minLines: 1,
                                    maxLines: 3,
                                    onChanged: (value){},
                                    decoration: InputDecoration(
                                      hintText: "Type your message here",
                                      hintMaxLines: 1,
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 10),
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                          width: 0.2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: const BorderSide(
                                          color: Colors.black26,
                                          width: 0.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              InkWell(
                                child: Icon(Icons.send, color: greenPea, size: 24,),
                                onTap: () {
                                  if(controller.messageController.text.isEmpty || controller.messageController.text == "" || controller.messageController.text == null){
                                    null;
                                  }else{
                                    controller.sendMessage(docId: widget.docId!);
                                  }
                                },
                              ),
                              const SizedBox(width: 10,),
                            ],
                          ),
                        ),
                        Offstage(
                          offstage: !controller.isEmojiVisible,
                          child: SizedBox(
                            height: 250,
                            child: EmojiPicker(
                              onEmojiSelected: (category, emoji) {
                                controller.messageController.text = controller.messageController.text+emoji.emoji;
                              },
                              onBackspacePressed: () {},
                              textEditingController: textEditingController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                              config: Config(
                                columns: 7,
                                emojiSizeMax: 32 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                                verticalSpacing: 0,
                                horizontalSpacing: 0,
                                gridPadding: EdgeInsets.zero,
                                initCategory: Category.RECENT,
                                bgColor: Color(0xFFF2F2F2),
                                indicatorColor: Colors.blue,
                                iconColor: Colors.grey,
                                iconColorSelected: Colors.blue,
                                backspaceColor: Colors.blue,
                                skinToneDialogBgColor: Colors.white,
                                skinToneIndicatorColor: Colors.grey,
                                enableSkinTones: true,
                                recentTabBehavior: RecentTabBehavior.RECENT,
                                recentsLimit: 28,
                                noRecents: const Text(
                                  'No Recents',
                                  style: TextStyle(fontSize: 20, color: Colors.black26),
                                  textAlign: TextAlign.center,
                                ), // Needs to be const Widget
                                loadingIndicator: const SizedBox.shrink(), // Needs to be const Widget
                                tabIndicatorAnimDuration: kTabScrollDuration,
                                categoryIcons: const CategoryIcons(),
                                buttonMode: ButtonMode.MATERIAL,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  onWillPop: (){
                    if(controller.isEmojiVisible){
                      setState(() {
                        controller.isEmojiVisible = false;
                      });
                    }else{
                      Get.back();
                    }
                    return Future.value(false);
                  },
                ),
              )
          );
        });
  }
}

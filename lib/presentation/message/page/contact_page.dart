import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/presentation/message/controller/contact_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0, backgroundColor: white,
            centerTitle: false,
            title: Text("Contact", style:
            Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),),
            leading: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Icon(Icons.arrow_back_outlined, color: Colors.black,)),
          ),
          body: GetBuilder<ContactController>(
              init: ContactController(),
              builder: (controller){
                return controller.isLoadingContacts == true && controller.userChatModel == [] ?
                Center(
                  child: CupertinoActivityIndicator(),
                ) :
                controller.isLoadingContacts == false && controller.userChatModel.isEmpty || controller.userChatModel == [] ?
                Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/png/chat_contact.png", height: 200, width: 150,),
                      const SizedBox(height: 40,),
                      Text("No chat contact!", style:
                      Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w700),)
                    ],
                  ),
                ) : CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index){
                          var item = controller.userChatModel[index];
                          return GestureDetector(
                            onTap: (){
                              if(item.id != null) {
                                controller.goChat(item);
                              }
                            },
                            child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(shape: BoxShape.circle),
                                    child: Image.network(
                                      item.photourl!,
                                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: SizedBox(
                                            height: 20, width: 20,
                                            child: CircularProgressIndicator(
                                              color: greenPea,
                                              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder: (context, object, stackTrace) {
                                        return Icon(Icons.account_circle, size: 43,
                                          color: Color(0xffaeaeae),
                                        );
                                      },
                                      width: 50, height: 50, fit: BoxFit.cover,
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                ),
                                const SizedBox(width: 15,),
                                Expanded(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 20,),
                                        Text(item.name ?? "", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500, fontSize: 16),),
                                      ],
                                    )
                                )
                              ],
                            ),
                          );
                        }, childCount: controller.userChatModel.length
                        ),
                      ),
                    )
                  ],
                );
              }
          ),
        )
    );
  }
}


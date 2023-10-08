import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexter_mobile/app/shared/constants/firestore_constants.dart';
import 'package:dexter_mobile/datas/model/chat/msg.dart';
import 'package:dexter_mobile/datas/model/user/user.dart';
import 'package:dexter_mobile/domain/local/local_storage.dart';
import 'package:get/get.dart';
import '../page/chat_screen.dart';

class ContactController extends GetxController{
  final firebaseFireStore = FirebaseFirestore.instance;
  List<UserData> userChatModel = <UserData>[].obs;
  List<UserData>  singleUserChatModel = <UserData>[].obs;
  String? currentUserId;
  bool? isLoadingContacts;
  bool? isLoadingSingleContact;
  String? docId;

  goChat(UserData toUserChatModel) async{
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final currentUserId = await LocalCachedData.instance.getCurrentUserId();
   var fromMessage = await firebaseFireStore.collection(FirestoreConstants.pathMessageCollection).withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options)=>msg.toFirestore()).
   where("from_uid", isEqualTo: currentUserId).where("to_uid", isEqualTo:  toUserChatModel.id).get();

   var toMessage = await firebaseFireStore.collection(FirestoreConstants.pathMessageCollection).withConverter(
       fromFirestore: Msg.fromFirestore,
       toFirestore: (Msg msg, options)=>msg.toFirestore()).
   where("from_uid", isEqualTo: toUserChatModel.id).where("to_uid", isEqualTo: currentUserId).get();
   if(fromMessage.docs.isEmpty && toMessage.docs.isEmpty){
     UserLoginResponseEntity profile = await LocalCachedData.instance.fetchUserDetails();
     var messageData = Msg(
       from_uid: profile.userId,
       to_uid: toUserChatModel.id,
       from_name: profile.displayName,
       to_name: toUserChatModel.name,
       from_avatar: profile.photoUrl,
       to_avatar: toUserChatModel.photourl,
       last_msg: "",
       last_time: Timestamp.now(),
       msg_num: 0,
     );
     firebaseFireStore.collection(FirestoreConstants.pathMessageCollection).withConverter(
         fromFirestore: Msg.fromFirestore,
         toFirestore: (Msg msg, options)=>msg.toFirestore()).add(messageData).then((value){
           docId = value.id;
           Get.to(()=> ChatScreen(
             docId: value.id,
             toUid: toUserChatModel.id ?? "",
             toName: toUserChatModel.name ?? "",
             toAvatar: toUserChatModel.photourl ?? "",
           ));
     });
   }else{
     if(fromMessage.docs.isNotEmpty){
       docId = fromMessage.docs.first.id;
       Get.to(()=> ChatScreen(
         docId: fromMessage.docs.first.id,
         toUid: toUserChatModel.id ?? "",
         toName: toUserChatModel.name ?? "",
         toAvatar: toUserChatModel.photourl ?? "",
       ));
     }
     if(toMessage.docs.isNotEmpty){
       docId = toMessage.docs.first.id;
       Get.to(()=> ChatScreen(
         docId: toMessage.docs.first.id,
         toUid: toUserChatModel.id ?? "",
         toName: toUserChatModel.name ?? "",
         toAvatar: toUserChatModel.photourl ?? "",
       ));
     }
   }
  }

  moveToChat({required QueryDocumentSnapshot<Msg> item}) async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final currentUserId = await LocalCachedData.instance.getCurrentUserId();
    if(item.data().from_uid == currentUserId){
      docId = item.id;
      Get.to(()=> ChatScreen(
        docId: item.id,
        toUid: item.data().to_uid ?? "",
        toName: item.data().to_name ?? "",
        toAvatar: item.data().to_avatar ?? "",
      ));
    }else{
      docId = item.id;
      Get.to(()=> ChatScreen(
        docId: item.id,
        toUid: item.data().from_uid ?? "",
        toName: item.data().from_name ?? "",
        toAvatar: item.data().from_avatar ?? "",
      ));
    }
  }

  asyncLoadData() async {
   try{
     isLoadingContacts = true;
     update();
     Get.put<LocalCachedData>(await LocalCachedData.create());
     final currentUserId = await LocalCachedData.instance.getCurrentUserId();
     await firebaseFireStore.collection(FirestoreConstants.pathUserCollection).where("id", isNotEqualTo: currentUserId).where("user_type", isEqualTo: "Vendor")
         .withConverter(fromFirestore: UserData.fromFirestore,
         toFirestore: (UserData userChatModel, options)=> userChatModel.toFirestore()).get().then((value){
       for(var doc in value.docs){
         isLoadingContacts = false;
         userChatModel.add(doc.data());
         update();
       }
     });
   }catch(error){
     isLoadingContacts = false;
     log(error.toString());
   }
  }

  asyncLoadSingleUserData({required String vendorId}) async {
    try{
      isLoadingSingleContact = true;
      update();
      Get.put<LocalCachedData>(await LocalCachedData.create());
      await firebaseFireStore.collection(FirestoreConstants.pathUserCollection).where("id", isEqualTo: vendorId).where("user_type", isEqualTo: "Vendor")
          .withConverter(fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userChatModel, options)=> userChatModel.toFirestore()).get().then((value){
        for(var doc in value.docs){
          isLoadingSingleContact = false;
          singleUserChatModel.add(doc.data());
          update();
        }
      });
    }catch(error){
      isLoadingSingleContact = false;
      log(error.toString());
    }
  }

  @override
  void onInit() {
    asyncLoadData();
    super.onInit();
  }
}
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexter_mobile/app/shared/constants/firestore_constants.dart';
import 'package:dexter_mobile/app/shared/utils/security.dart';
import 'package:dexter_mobile/datas/model/chat/msgcontent.dart';
import 'package:dexter_mobile/datas/model/user/user.dart';
import 'package:dexter_mobile/domain/local/local_storage.dart';
import 'package:dexter_mobile/presentation/message/controller/contact_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ChatController extends GetxController{
  final _controller = Get.put(ContactController());
  var isEmojiVisible = false;
  FocusNode focusNode = FocusNode();
  List<MsgContent> messageContentList = <MsgContent>[].obs;
  final messageController = TextEditingController();
  ScrollController? scrollController = ScrollController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FocusNode contentNode = FocusNode();
  var listener;
  var currentUserId;
  String? docId;

  Future<void> getUserId() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    currentUserId = await LocalCachedData.instance.getCurrentUserId();
  }

  sendMessage({required String docId}) async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final currentUserId = await LocalCachedData.instance.getCurrentUserId();
    String messageContent = messageController.text;
    final content = MsgContent(
      uid: currentUserId,
      content: messageContent,
      type: "text",
      addtime: Timestamp.now(),
    );
    await firebaseFirestore.collection(FirestoreConstants.pathMessageCollection).doc(docId).collection(FirestoreConstants.messageList).withConverter(
        fromFirestore: MsgContent.fromFirestore,
        toFirestore: (MsgContent msgContent, options)=>msgContent.toFirestore()
    ).add(content).then((value){
      log("Document snapshot added with id, ${docId}");
      messageController.clear();
      Get.focusScope?.unfocus();
    });
    await firebaseFirestore.collection(FirestoreConstants.pathMessageCollection).doc(docId).update({
      "last_msg": messageContent,
      "last_time": Timestamp.now()
    });
    update();
  }


  @override
  void onReady() {
    var messages = firebaseFirestore.collection(FirestoreConstants.pathMessageCollection).doc(_controller.docId).collection(FirestoreConstants.messageList).withConverter(
        fromFirestore: MsgContent.fromFirestore,
        toFirestore: (MsgContent msgContent, options)=>msgContent.toFirestore()
    ).orderBy(FirestoreConstants.addTime, descending: false);
    messageContentList.clear();
    update();
    listener = messages.snapshots().listen((event) {
      for(var change in event.docChanges){
        switch(change.type){
          case DocumentChangeType.added:
            if(change.doc.data() != null){
              messageContentList.insert(0, change.doc.data()!);
              update();
            }
            break;
          case DocumentChangeType.modified:
            update();
            break;
          case DocumentChangeType.removed:
            update();
            break;
        }
      }
    },
    onError: (error)=> print("Listen failed: $error")
    );
    update();
    super.onReady();
  }

  @override
  void onInit() {
    getUserId();
    super.onInit();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    listener.cancel();
    super.dispose();
  }

  sendImageMessage(String url, String docId) async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final currentUserId = await LocalCachedData.instance.getCurrentUserId();
    final content = MsgContent(
      uid: currentUserId,
      content: url,
      type: "image",
      addtime: Timestamp.now()
    );
    await firebaseFirestore.collection(FirestoreConstants.pathMessageCollection).doc(docId).collection(FirestoreConstants.messageList).withConverter(
        fromFirestore: MsgContent.fromFirestore,
        toFirestore: (MsgContent msgContent, options)=>msgContent.toFirestore()
    ).add(content).then((value){
      log("Document snapshot added with id, ${docId}");
      messageController.clear();
      Get.focusScope?.unfocus();
    });
    await firebaseFirestore.collection(FirestoreConstants.pathMessageCollection).doc(docId).update({
      "last_msg": "[image ]",
      "last_time": Timestamp.now()
    });
    update();
  }
  File? imageFile;

  final picker = ImagePicker();
  void onUploadImage(ImageSource source, String docId) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if(pickedFile != null){
        imageFile = File(pickedFile.path);
        uploadFile(docId);
        update();
      }else{
        print("No image selected");
      }
    } catch (e) {
      final pickImageError = e;
      update();
    }
  }

  Future getImageUrl(String name) async {
    final spaceRef = FirebaseStorage.instance.ref(FirestoreConstants.chat).child(name);
    var str = await spaceRef.getDownloadURL();
    return str ?? "";
  }


  Future uploadFile(String docId) async {
    if(imageFile == null) return;
    final fileName = getRandomString(15)+extension(imageFile!.path);
    try{
      final ref = FirebaseStorage.instance.ref(FirestoreConstants.chat).child(fileName);
      await ref.putFile(imageFile!).snapshotEvents.listen((event) async{
        switch(event.state){
          case TaskState.running:
            break;
          case TaskState.paused:
            break;
          case TaskState.success:
            String imgUrl = await getImageUrl(fileName);
            sendImageMessage(imgUrl, docId);
        }
      });
    }catch(error){
      print("There's an error $error");
    }
    getLocation();
  }

  String? toLocation;

  getLocation()async{
    try{
      var userLocation = await firebaseFirestore.collection(FirestoreConstants.pathUserCollection).where("id", isEqualTo: currentUserId).withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, options)=>userData.toFirestore()
      ).get();
      var location = userLocation.docs.first.data().location;
      if(location != ""){
        toLocation = location ?? "Unknown";
      }
      update();
    }catch(error){
      print("We have error $error");
    }
  }
}
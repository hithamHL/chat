
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:medicen_app/model/messages_model.dart';
import 'package:medicen_app/utils/constants.dart';
import 'package:medicen_app/utils/global.dart';


enum MessageType {text, image}

class MessageController extends GetxController{

  static Rx<List<MessagesModel>> chatList = Rx<List<MessagesModel>>([]);

  List<MessagesModel> get chats => chatList.value.obs;



  final chatId;
  MessageController(this.chatId);

  @override
  void onInit() {
    super.onInit();
    print(chatId);
    chatList.bindStream(getChatStream(chatId));
  }


  Stream<List<MessagesModel>> getChatStream(String groupChatId) {
    return firebaseFirestore
        .collection(ConstantsName.chatDoc)
        .doc(groupChatId)
        .collection(ConstantsName.messageDoc).orderBy("dateCreated")
        .get().asStream()
        .map((QuerySnapshot query) {
      List<MessagesModel> chats = [];
      for (var chat in query.docs) {
        final chatModel = MessagesModel.fromDocumentSnapshot(documentSnapshot: chat);
        chats.add(chatModel);
      }
      return chats;
    });
  }

 static  sendMessage(MessagesModel messagesModel,String groupChatId) async {
     firebaseFirestore
        .collection(ConstantsName.chatDoc)
        .doc(groupChatId)
        .collection(ConstantsName.messageDoc)
        .doc().set(messagesModel.toJson())
        .asStream();

     chatList.value.add(messagesModel);
     chatList.refresh();

  }

  static Future<UploadTask> uploadFile(File image, String fileName) async{
    Reference reference = firebaseStorage.ref(ConstantsName.messageDoc).child(fileName);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  // @override
  // void onClose() {
  //   scrollController?.dispose();
  //   _listWorker?.dispose();
  //   super.onClose();
  // }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicen_app/model/chat_model.dart';
import 'package:medicen_app/model/users_model.dart';
import 'package:medicen_app/utils/constants.dart';
import 'package:medicen_app/utils/global.dart';

class ChatController extends GetxController{


  Rx<List<ChatModel>> chatList = Rx<List<ChatModel>>([]);

  List<ChatModel> get chats => chatList.value.obs;
  Rx<List<UserModel>> doctorsList = Rx<List<UserModel>>([]);

  List<UserModel> get allDoctors => doctorsList.value.obs;

  final TextEditingController controllerText=TextEditingController();
  final uid=sharedPreferences!.getString("uid");

  @override
  void onInit() {
    super.onInit();

    chatList.bindStream(chatListStream());
    doctorsList.bindStream(doctorList());
  }



  Stream<List<ChatModel>> chatListStream() {

    return firebaseFirestore
        .collection(ConstantsName.chatDoc)
        .get().asStream()
        .map((QuerySnapshot query) {
        List<ChatModel> chats = [];
      for (var chat in query.docs) {
        final chatModel = ChatModel.fromDocumentSnapshot(documentSnapshot: chat);
        if(chatModel.memberTwoUid == uid || chatModel.memberOneUid== uid) {
          chats.add(chatModel);
        }
        }
      chatList.refresh();
      return chats;
    });
  }

  Stream<List<UserModel>> doctorList() {
    return firebaseFirestore
        .collection(ConstantsName.usersDoc).where("type",isEqualTo: ConstantsName.doctor)
        .get().asStream()
        .map((QuerySnapshot query) {
      List<UserModel> docList = [];
      for (var doctor in query.docs) {
        final doctorModel = UserModel.fromDocumentSnapshot(documentSnapshot: doctor);
        docList.add(doctorModel);
      }
      doctorsList.refresh();
      return docList;
    });
  }


  void filterItems(String query) {
      // Filter the data based on the query and update filteredData
      // filteredData.assignAll(originalData.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList());
      print("#########$query");
      final filteredItems = chats
          .where((item) {
        final name=ConstantsName.chatUserName(item);
        return name!.toLowerCase().contains(query.toLowerCase());
      }).toList();
      chatList.value=filteredItems;

      final filteredItemsDoctor = allDoctors.where((item) => item.full_name!.toLowerCase().contains(query.toLowerCase())).toList();
      doctorsList.value=filteredItemsDoctor;

  }

  clearFilter() {
    print("#####Empty####");
    controllerText.clear();
    chatList.bindStream(chatListStream());
    doctorsList.bindStream(doctorList());
  }








}
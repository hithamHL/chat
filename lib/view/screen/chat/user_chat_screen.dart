import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicen_app/logic/controllers/chat_controller.dart';
import 'package:medicen_app/model/chat_model.dart';
import 'package:medicen_app/model/users_model.dart';
import 'package:medicen_app/routes/routes.dart';
import 'package:medicen_app/utils/constants.dart';
import 'package:medicen_app/utils/global.dart';
import 'package:medicen_app/view/widget/empty_widget.dart';
import 'package:medicen_app/view/widget/search_bar.dart';

import 'widget/user_chat_card.dart';

class UserChatScreen extends GetView<ChatController> {
  UserChatScreen({Key? key})
      : super(key: key);

  final dataController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarWidget(
            onSubmit: (val) => dataController.filterItems(val),),
        Obx(
          () =>  dataController.allDoctors.isEmpty
              ? const Expanded(
                child: Center(
                    child: EmptyWidget(
                    message: "Sorry \n there are no message at the moment",
                    imageUrl: "images/empty.png",
                  )),
              )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: dataController.allDoctors.length,
                  itemBuilder: (BuildContext context, int index) {

                    if (index < dataController.chats.length) {
                      final _chats = dataController.chats[index];
                      // Display a widget for the product.
                      var parameters = <String, String>{"chatUid": _chats.chatUID!,
                        "imageOne": _chats.memberOneAvatar!,
                        "imageTwo": _chats.memberTwoAvatar!};
                      return ChatCardItem(
                          userName: ConstantsName.chatUserName(_chats)!,
                          lastMessage: _chats.lastMessage!,
                          chatStatus: _chats.readStatus!,
                          goToChat: () => Get.toNamed(Routes.chatScreen,
                              parameters: parameters)
                      );
                    } else {
                      final _doctor = dataController.allDoctors[index];
                      return ChatCardItem(
                          userName: _doctor.full_name!,
                          lastMessage: "",
                          chatStatus: false,
                        goToChat: () => createChat(_doctor),
                      );
                    }
                  }),
        ),
      ],
    );
  }


   createChat(UserModel userModel){
    final userUID= sharedPreferences!.getString("uid");
   final userName= sharedPreferences!.getString("name");
    final userAvatar= sharedPreferences!.getString("photoUrl");
    final chatUID=userModel.uid!+userUID!; // doctor + myUID
    ChatModel chatModel=ChatModel(chatUID,
        userModel.full_name, userName,
        userModel.uid, userUID,
        userModel.photoUrl, userAvatar,
        " ", false);
      FirebaseFirestore.instance.collection(ConstantsName.chatDoc).doc(chatUID)
          .set(chatModel.toJson()).whenComplete(() => {
            dataController.refresh(),
            Get.toNamed(Routes.chatScreen,arguments: chatUID)});
    }

}

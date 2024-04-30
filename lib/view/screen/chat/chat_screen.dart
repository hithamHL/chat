import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicen_app/logic/controllers/message_controller.dart';
import 'package:medicen_app/model/messages_model.dart';
import 'package:medicen_app/utils/theme.dart';
import 'package:medicen_app/view/widget/message_item.dart';
import '../../../routes/routes.dart';
import '../../../utils/global.dart';
import '../../widget/app_bar_extensions.dart';

class ChatScreen extends GetView<MessageController> {
  List<MessagesModel> listMessage = [];

  final argParameter = Get.parameters;

  bool isLoading = false;
  bool isShowSticker = false;

  File? imageFile;
  String imageUrl = "";

  final ScrollController listScrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();

  final isDoctor = sharedPreferences!.getString("userType");

  @override
  Widget build(BuildContext context) {
    print("##############$isDoctor");
    print("##############${Get.parameters["chatUid"]}");

    // listScrollController.addListener(_scrollListener);
    return Scaffold(
      appBar: AppBar().addCustomActionButton(
          icon: Icon(Icons.add, color: Colors.black),
          onPressed: () {
            Get.toNamed(Routes.medicenOrder,arguments: "user");
          },
          title: "Message",
          isVisible: isDoctor == "doctor" ? true : false),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                // List of messages
                buildListMessage(),

                // Sticker
                // isShowSticker ? buildSticker() : SizedBox.shrink(),

                // Input content
                buildInput(),
              ],
            ),

            // Loading
            // buildLoading()
          ],
        ),
      ),
    );
  }

  ///functions//////////////////////////////////////////////////////////////////

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker
        .pickImage(source: ImageSource.gallery)
        .catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
      return null;
    });
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        isLoading = true;

        uploadFile();
      }
    }
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask =
        await MessageController.uploadFile(imageFile!, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();

      isLoading = false;
      onSendMessage("", "image", imageUrl);
    } on FirebaseException catch (e) {
      isLoading = false;

      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }

  void onSendMessage(String content, String type, String messageImage) async {
    if (content.trim().isNotEmpty || messageImage.trim().isNotEmpty) {
      textEditingController.clear();
      final userUid = sharedPreferences!.getString("uid");
      await MessageController.sendMessage(
          MessagesModel(argParameter[0], userUid, type, false, content,
              messageImage, false, Timestamp.now()),
          argParameter[0]!);
      if (listScrollController.hasClients) {
        listScrollController.animateTo(  listScrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: Colors.redAccent);
    }
  }

  Widget buildInput() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
        color: Color(0x80c7c7c7),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: Image.asset('images/upload_im.png'),
                onPressed: getImage,
              ),
            ),
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  // onSendMessage(textEditingController.text, TypeMessage.text);
                },
                // style: TextStyle(color: ColorConstants.primaryColor, fontSize: 15),
                controller: textEditingController,
                decoration: const InputDecoration.collapsed(
                  hintText: 'writing..',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                // focusNode: focusNode,
                autofocus: true,
              ),
            ),
          ),

          // Button send message
          Material(
            color: Colors.transparent,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () =>
                    onSendMessage(textEditingController.text, "text", ""),
                color: mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListMessage() {
    print("##############${Get.parameters["chatUid"]}");
    return GetX<MessageController>(
      init: Get.put<MessageController>(MessageController(argParameter)),
      builder: (MessageController messageController) {
        return Flexible(
          child: Container(
              child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: messageController.chats.length,
                  reverse: false,
                  controller: listScrollController,
                  itemBuilder: (context, index) {
                    MessagesModel messagesModel =
                        messageController.chats[index];
                    listMessage.addAll(messageController.chats);
                    return MessageItem(
                        messageContent: messagesModel.messageType == "text"
                            ? messagesModel.messageText
                            : messagesModel.messageImage,
                        messageType: messagesModel.messageType,
                        userUID: messagesModel.senderUid,
                        userAvatar: "",
                        isLiked: messagesModel.liked,
                        onPressedLiked: () {
                          if (messagesModel.liked!) {
                            // senderLiked=true;
                          } else {
                            // senderLiked=false;
                          }
                        });
                  })),
        );
      },
    );
  }

// _scrollListener() {
//   if (!listScrollController.hasClients) return;
//   if (listScrollController.offset >=
//       listScrollController.position.maxScrollExtent &&
//       !listScrollController.position.outOfRange &&
//       _limit <= listMessage.length) {
//
//       _limit += _limitIncrement;
//
//   }
// }
}

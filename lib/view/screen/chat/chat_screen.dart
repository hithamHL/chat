import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicen_app/utils/theme.dart';

import '../../widget/custom_app_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        barTitle: "Message",
        appBar: AppBar(),
      ),
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

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery)
        .catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
      return null;
    });
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        uploadFile();
      }
    }
  }

  Future uploadFile() async {
    // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    // UploadTask uploadTask = chatProvider.uploadFile(imageFile!, fileName);
    // try {
    //   TaskSnapshot snapshot = await uploadTask;
    //   imageUrl = await snapshot.ref.getDownloadURL();
    //   setState(() {
    //     isLoading = false;
    //     onSendMessage(imageUrl, TypeMessage.image);
    //   });
    // } on FirebaseException catch (e) {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   Fluttertoast.showToast(msg: e.message ?? e.toString());
    // }
  }

  void onSendMessage(String content, int type) {
    // if (content.trim().isNotEmpty) {
    //   textEditingController.clear();
    //   chatProvider.sendMessage(content, type, groupChatId, currentUserId, widget.arguments.peerId);
    //   if (listScrollController.hasClients) {
    //     listScrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    //   }
    // } else {
    //   Fluttertoast.showToast(msg: 'Nothing to send', backgroundColor: ColorConstants.greyColor);
    // }
  }

  Widget buildInput() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0x80c7c7c7),


        borderRadius: BorderRadius.all(Radius.circular(30)),),

      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: Image.asset('images/upload_img/png'),
                onPressed: getImage,

              ),
            ),
            color: Colors.transparent,
          ),


          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  // onSendMessage(textEditingController.text, TypeMessage.text);
                },
                // style: TextStyle(color: ColorConstants.primaryColor, fontSize: 15),
                // controller: textEditingController,
                decoration: InputDecoration.collapsed(
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
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => {},
                //onSendMessage(textEditingController.text, TypeMessage.text),
                color: mainColor,
              ),
            ),
            color: Colors.transparent,
          ),
        ],
      ),


    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: Container(),
      // child: groupChatId.isNotEmpty
      //     ? StreamBuilder<QuerySnapshot>(
      //     stream: chatProvider.getChatMessage(groupChatId, _limit),
      //     builder: (BuildContext context,
      //         AsyncSnapshot<QuerySnapshot> snapshot) {
      //       if (snapshot.hasData) {
      //         listMessages = snapshot.data!.docs;
      //         if (listMessages.isNotEmpty) {
      //           return ListView.builder(
      //               padding: const EdgeInsets.all(10),
      //               itemCount: snapshot.data?.docs.length,
      //               reverse: true,
      //               controller: scrollController,
      //               itemBuilder: (context, index) =>
      //                   buildItem(index, snapshot.data?.docs[index]));
      //         } else {
      //           return const Center(
      //             child: Text('No messages...'),
      //           );
      //         }
      //       } else {
      //         return const Center(
      //           child: CircularProgressIndicator(
      //             color: mainColor,
      //           ),
      //         );
      //       }
      //     })
      //     : const Center(
      //   child: CircularProgressIndicator(
      //     color: mainColor,
      //   ),
      // ),
    );
  }
}

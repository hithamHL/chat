import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesModel{
  String? chatUID;
  String? senderUid;
  String? messageType;
  bool? liked;
  String? messageText;
  String? messageImage;
  bool? readStatus;
  Timestamp? dateCreated;

  MessagesModel(this.chatUID,
      this.senderUid,this.messageType,
      this.liked,this.messageText,
      this.messageImage, this.readStatus,this.dateCreated);

  MessagesModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    chatUID = documentSnapshot.id;
    senderUid = documentSnapshot["senderUid"];
    messageType = documentSnapshot["messageType"];
    liked = documentSnapshot["liked"];
    messageText = documentSnapshot["messageText"];
    messageImage = documentSnapshot["messageImage"];
    readStatus = documentSnapshot["readStatus"];
    dateCreated = documentSnapshot["dateCreated"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatUID'] = chatUID;
    data["senderUid"]= senderUid;
    data["messageType"]=messageType;
    data["liked"]=liked;
    data["messageText"]=messageText;
    data["messageImage"]=messageImage;
    data["readStatus"]=readStatus;
    data["dateCreated"]=dateCreated;

    return data;
  }
}
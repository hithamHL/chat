import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel{
  String? chatUID;
  String? memberOneName;
  String? memberTwoName;
  String? memberOneUid;
  String? memberTwoUid;
  String? memberOneAvatar;
  String? memberTwoAvatar;
  String? lastMessage;
  bool? readStatus;


  ChatModel(
      this.chatUID,
      this.memberOneName,
      this.memberTwoName,
      this.memberOneUid,
      this.memberTwoUid,
      this.memberOneAvatar,
      this.memberTwoAvatar,
      this.lastMessage,
      this.readStatus);

  ChatModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    chatUID = documentSnapshot.id;
    memberOneName = documentSnapshot["memberOne"];
    memberOneUid = documentSnapshot["memberOneUid"];
    memberTwoName = documentSnapshot["memberTwo"];
    memberTwoUid = documentSnapshot["memberTwoUid"];
    memberOneAvatar = documentSnapshot["memberOneAvatar"];
    memberTwoAvatar = documentSnapshot["memberTwoAvatar"];
    lastMessage = documentSnapshot["lastMessage"];
    readStatus = documentSnapshot["readStatus"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatUID'] = chatUID;
    data["memberOne"]= memberOneName;
    data["memberOneUid"]=memberOneUid;
    data["memberTwo"]=memberOneName;
    data["memberTwoUid"]=memberTwoUid;
    data["memberOneAvatar"]=memberOneAvatar;
    data["memberTwoAvatar"]=memberTwoAvatar;
    data["lastMessage"]=lastMessage;
    data["readStatus"]=readStatus;
    return data;
  }
}
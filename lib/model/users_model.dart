import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String? uid;
  String? email;
  String? full_name;
  String? photoUrl;
  String? phone;
  String? status;
  String? token;
  String? type;


  UserModel(this.uid, this.email, this.full_name, this.photoUrl, this.phone,
      this.status, this.token, this.type);

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    uid = documentSnapshot.id;
    email = documentSnapshot["email"];
    full_name = documentSnapshot["full_name"];
    photoUrl = documentSnapshot["photoUrl"];
    phone = documentSnapshot["phone"];
    status = documentSnapshot["status"];
    // token = documentSnapshot["token"];
    type = documentSnapshot["type"];
  }
}
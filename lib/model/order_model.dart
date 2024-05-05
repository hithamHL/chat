import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel{
  String? orderUID;
  String? userUID;
  String? doctorUID;
  String? firstName;
  String? lastName;
  String? numberID,medicineName,timeTake,price,amount,details;



  OrderModel(
      this.orderUID,
     this.userUID,this.doctorUID,this.firstName,this.lastName,
      this.numberID,this.medicineName,this.timeTake,this.price,
      this.amount,this.details
      );

  OrderModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    orderUID=documentSnapshot.id;
    userUID = documentSnapshot["userUID"];
    doctorUID = documentSnapshot["doctorUID"];
    firstName = documentSnapshot["firstName"];
    lastName = documentSnapshot["lastName"];
    numberID = documentSnapshot["numberID"];
    medicineName = documentSnapshot["medicineName"];
    timeTake = documentSnapshot["timeTake"];
    price = documentSnapshot["price"];
    amount = documentSnapshot["amount"];
    details = documentSnapshot["details"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderUID'] = orderUID;
    data["userUID"]= userUID;
    data["doctorUID"]=doctorUID;
    data["firstName"]=firstName;
    data["lastName"]=lastName;
    data["numberID"]=numberID;
    data["medicineName"]=medicineName;
    data["timeTake"]=timeTake;
    data["price"]=price;
    data["amount"]=amount;
    data["details"]=details;
    return data;
  }
}
import 'dart:io';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart'as fStorage;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicen_app/routes/routes.dart';
import 'package:medicen_app/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/global.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  File? imageFile;
  String? imageUrl;
  void  _getFromCamera()async{

    XFile? pickeFile=await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imageFile=File(pickeFile!.path);
    });
    if(imageFile!=null){
      String fileName=DateTime.now().millisecondsSinceEpoch.toString();
      fStorage.Reference reference=fStorage.FirebaseStorage.instance.ref().child("users").child(fileName);
      fStorage.UploadTask uploadTask=reference.putFile(File(imageFile!.path));
      fStorage.TaskSnapshot taskSnapshot=await uploadTask.whenComplete((){});
      await taskSnapshot.ref.getDownloadURL().then((url){
        imageUrl=url;
        saveDataToFirestore();

      });
    }
    setState(() {

    });

  }
  void  _getFromGallery()async{

    XFile? pickeFile=await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile=File(pickeFile!.path);
    });
   if(imageFile!=null){
     String fileName=DateTime.now().millisecondsSinceEpoch.toString();
     fStorage.Reference reference=fStorage.FirebaseStorage.instance.ref().child("users").child(fileName);
     fStorage.UploadTask uploadTask=reference.putFile(File(imageFile!.path));
     fStorage.TaskSnapshot taskSnapshot=await uploadTask.whenComplete((){});
     await taskSnapshot.ref.getDownloadURL().then((url){
       imageUrl=url;
       saveDataToFirestore();
     });
   }
    setState(() {

    });

  }

  Future saveDataToFirestore()async{
    String? uid= sharedPreferences!.getString("uid");
    FirebaseFirestore.instance.collection("users").doc(uid).update({
        "photoUrl":imageUrl,

    });
    // save data locally
    sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences!.setString("photoUrl", imageUrl!);
    Fluttertoast.showToast(msg: "The Image Update in Firebase");


  }



  void _showImageDialog(){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(

            title: Text("Please Choose an Option "),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(onTap: (){
                  if (Navigator.of(context).canPop()) {
                    Navigator.pop(context); // Only pop if there's something to pop
                  }
                  _getFromCamera();
                },
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.camera,color: mainColor,),

                      ),
                      Text("Camera",style: TextStyle(color: mainColor),)
                    ],
                  ),
                ),
                InkWell(onTap: (){
                  if (Navigator.of(context).canPop()) {
                    Navigator.pop(context); // Only pop if there's something to pop
                  }
                  _getFromGallery();
                },
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.image,color: mainColor,),

                      ),
                      Text("Gallery",style: TextStyle(color: mainColor),)
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  clear_Image(){
    setState(() {
      imageFile = null;
    });

  }

  @override
  void initState() {
    super.initState();
    imageUrl=sharedPreferences!.getString("photoUrl");
    print(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                CircleAvatar(
                  radius: 65,
                  backgroundColor: mainColor,
                  child: imageUrl == null||imageUrl==""
                      ? ClipOval(child: Image.asset("images/onboard1.png",))
                      : ClipOval(
                    child: Image.network(
                      imageUrl!,
                      width: 130, // You can adjust the width and height as needed
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 20,),

               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   InkWell(
                     onTap: () async{
                       _showImageDialog();

                       },
                     child: Container(
                       width: 70,
                         height: 30,
                         decoration: BoxDecoration(
                           color: Color(0xffD9D9D9),
                           borderRadius: BorderRadius.circular(10),
                         ),

                         child: Center(child: Text("Update",style: TextStyle(fontWeight: FontWeight.bold),))),
                   ),
                      SizedBox(width: 5,),
                   InkWell(
                     onTap: () async{
                     await  ArtSweetAlert.show(
                         context: context,
                         artDialogArgs: ArtDialogArgs(
                             type: ArtSweetAlertType.question,

                             title: "Delete Image",
                             text: "Do you want to delete this image?",
                             onCancel: (){
                               Navigator.of(context, rootNavigator: true).pop();
                             },
                             cancelButtonText: "Cancel",
                             showCancelBtn: true,
                             confirmButtonText: "Ok",
                             onConfirm: (){
                               clear_Image();
                               Navigator.of(context, rootNavigator: true).pop();
                             },
                             confirmButtonColor: mainColor




                         ),
                       );


                     },
                     child: Container(
                         width: 40,
                         height: 30,
                         decoration: BoxDecoration(
                           color: Color(0xffD9D9D9),
                           borderRadius: BorderRadius.circular(10),
                         ),

                         child: Center(child: Icon(CupertinoIcons.delete,size: 20,))),
                   ),


                 ],
               ),
               SizedBox(height: 20,),

                InkWell(
                  splashColor: scandreColor,
                  onTap: (){
                    Get.toNamed(Routes.accountInfoScreen);

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Set the border color
                        width: 1.0, // Set the border width
                      ),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20) )
                    ),
                    child: ListTile(
                      title: Text("Account Information"),
                      tileColor: mainColor2,
                      leading: SvgPicture.asset("images/user2.svg"),
                    ),
                  ),
                ),

                InkWell(
                  splashColor: scandreColor,
                  onTap: (){

                    Get.toNamed(Routes.ordersScreen);

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Set the border color
                        width: 1.0, // Set the border width
                      ),
                    ),
                    child: ListTile(
                      title: Text("Order"),
                      tileColor: mainColor2,
                      leading: SvgPicture.asset("images/order.svg"),
                    ),
                  ),
                ),

                InkWell(
                  splashColor: scandreColor,
                  onTap: (){

                    Get.toNamed(Routes.addressScreen);

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Set the border color
                        width: 1.0, // Set the border width
                      ),
                    ),
                    child: ListTile(
                      title: Text("Address"),
                      tileColor: mainColor2,
                      leading: SvgPicture.asset("images/location.svg"),
                    ),
                  ),
                ),

                InkWell(
                  splashColor: scandreColor,
                  onTap: () {

                       Get.toNamed(Routes.settingScreen);
                  },


                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Set the border color
                        width: 1.0, // Set the border width
                      ),
                    ),
                    child: ListTile(
                      title: Text("Setting"),
                      tileColor: mainColor2,
                      leading: SvgPicture.asset("images/setting.svg"),
                    ),
                  ),

                ),


                InkWell(
                  splashColor: scandreColor,
                  onTap: () async{
                    ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                            type: ArtSweetAlertType.question,
                            title: "Log Out Form App",
                            text: "Do you want to log out?",
                          onCancel: (){
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          cancelButtonText: "Cancel",
                          showCancelBtn: true,
                          confirmButtonText: "Ok",
                          onConfirm: (){
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          confirmButtonColor: mainColor




                        ),
                    );


                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Set the border color
                        width: 1.0, // Set the border width
                      ),
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft:Radius.circular(20) )

                    ),
                    child: ListTile(
                      title: Text("Log out"),
                      tileColor: mainColor2,
                      leading: SvgPicture.asset("images/logout.svg"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

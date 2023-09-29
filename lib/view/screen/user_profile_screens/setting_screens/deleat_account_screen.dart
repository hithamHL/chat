import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/global.dart';
import '../../../../utils/theme.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/error_dialog.dart';
import '../../../widget/loading_dialog.dart';


class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({Key? key}) : super(key: key);

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  TextEditingController current_passwordController=TextEditingController();

  bool? isclick1=true;
  bool? isclick2=true;
  bool? rememberMe=false;
  late StreamSubscription subscription;
  var isDeviceConnected=false;
  bool isAlerSet=false;

  Future<ConnectivityResult> getConnectivityStatus() async {
    Connectivity connectivity = Connectivity();
    ConnectivityResult result = await connectivity.checkConnectivity();
    return result;
  }
  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
  formValidation()async{

    if(current_passwordController.text.isEmpty||current_passwordController.text.length<6){
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your Current Password".tr,
            );
          });
    } else{
      showDialog(
          context: context,
          builder: (c){
            return LoadingDialog(message: "wait...".tr);
          }
      );
await Future.delayed(Duration(milliseconds: 1000));
      hideLoadingDialog(context);
      // loginNow();
      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.success,
            title: "Your account has been deleted".tr,
            text: "We regret deleting your account, you can create a new account at any time.",
            onCancel: (){
              Navigator.of(context, rootNavigator: true).pop();
            },

            showCancelBtn: true,
            confirmButtonText: "Ok".tr,
            onConfirm: (){
              updatePassword();
              Navigator.of(context, rootNavigator: true).pop();

            },
            confirmButtonColor: mainColor




        ),
      );


    }
  }

  Future updatePassword() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? uid = sharedPreferences!.getString("uid");
    String? oldPassword = sharedPreferences!.getString("password"); // Retrieve the old password from SharedPreferences

    if (oldPassword != null && oldPassword == current_passwordController.text.trim()) {
      // Old password matches the one entered by the user
      // await FirebaseFirestore.instance.collection("users").doc(uid).collection("address");

      await FirebaseFirestore.instance.collection("users").doc(uid).delete();
      await user!.delete();
      await Fluttertoast.showToast(msg: "Your account has been deleted".tr);
    } else {
      // Old password does not match
      Fluttertoast.showToast(msg: "Incorrect old password".tr);
    }

    hideLoadingDialog(context);
  }


  void _showConnectivityErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Internet Connection".tr),
          content: Text("Please check your internet connection.".tr),
          actions: [
            TextButton(
              onPressed: () async {

                Navigator.pop(context,'Cancel'.tr); // Close the dialog
                setState(() {
                  isAlerSet=false;
                });
                isDeviceConnected=await InternetConnectionChecker().hasConnection;
                if(!isDeviceConnected){
                  _showConnectivityErrorDialog();
                  setState(() {
                    isAlerSet=true;
                  });
                }
              },
              child: Text("OK".tr),
            ),
          ],
        );
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xffFFFAEB),
    ));
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor2,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              "Delete Account".tr,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8),
                      child: CustomTextWidget(
                          text: "Current Password".tr,
                          textColor: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 12,),

                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFeaeaea),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextFormField(
                        controller: current_passwordController,
                        style: TextStyle(color: Colors.black),
                        obscureText: isclick1!, // Hide the entered password
                        decoration: InputDecoration(
                          hintText: "Enter your password".tr,
                          hintStyle: TextStyle(color: Color(0xffcacaca)),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SvgPicture.asset("images/lock.svg"),
                          ),
                          suffixIcon:

                          InkWell(
                            onTap: (){
                              setState(() {
                                isclick1=!isclick1!;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: SvgPicture.asset("images/eye.svg"),
                            ),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),

                    SizedBox(height: 20,),


                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          //  getConnectivity();
                          ConnectivityResult connectivityResult = await getConnectivityStatus();
                          if (connectivityResult == ConnectivityResult.none) {
                            _showConnectivityErrorDialog();
                          } else {
                            // Perform your login logic here
                          }
                          formValidation();
                        },
                        child: Text(
                            "Delete".tr
                        ),
                        style: ElevatedButton.styleFrom(

                          primary: mainColor, // Set the button color to your desired color
                          padding: EdgeInsets.all(16), // Adjust the padding as needed
                          // Set minimum width to 200
                        ),
                      ),
                    ),
                    SizedBox(height: 32,),





                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

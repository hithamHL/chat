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
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/global.dart';
import '../../../../utils/theme.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/error_dialog.dart';
import '../../../widget/loading_dialog.dart';


class ChangePasswordFromSetting extends StatefulWidget {
  const ChangePasswordFromSetting({Key? key}) : super(key: key);

  @override
  State<ChangePasswordFromSetting> createState() => _ChangePasswordFromSettingState();
}

class _ChangePasswordFromSettingState extends State<ChangePasswordFromSetting> {
  TextEditingController current_passwordController=TextEditingController();
  TextEditingController con_passwordController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool? isclick1=true;
  bool? isclick11=true;
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

  formValidation(){

     if(current_passwordController.text.isEmpty||current_passwordController.text.length<6){
    showDialog(
    context: context,
    builder: (c){
    return ErrorDialog(
    message: "check your Current Password",
    );
    });
    }

    else if(passwordController.text.isEmpty||passwordController.text.length<6){
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your New password",
            );
          });
    }
    else if(con_passwordController.text.isEmpty||con_passwordController.text!=passwordController.text){
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "your password not Confirm",
            );
          });
    }

    else{
      showDialog(
          context: context,
          builder: (c){
            return LoadingDialog(message: "wait...");
          }
      );
      updatePassword();
      //Get.toNamed(Routes.successfulResetPassword);

    }
  }

  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: false).pop();
  }

  Future updatePassword() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? uid = sharedPreferences!.getString("uid");
    String? oldPassword = sharedPreferences!.getString("password"); // Retrieve the old password from SharedPreferences

    if (oldPassword != null && oldPassword == current_passwordController.text.trim()) {
      // Old password matches the one entered by the user
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "password": con_passwordController.text.trim(),
      });
      await user!.updatePassword(con_passwordController.text.trim());
      await Fluttertoast.showToast(msg: "Password has been updated");
    } else {
      // Old password does not match
      Fluttertoast.showToast(msg: "Incorrect old password");
    }

    hideLoadingDialog(context);
  }


  void _showConnectivityErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Internet Connection"),
          content: Text("Please check your internet connection."),
          actions: [
            TextButton(
              onPressed: () async {

                Navigator.pop(context,'Cancel'); // Close the dialog
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
              child: Text("OK"),
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
              "Change Password",
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
                          text: "Current Password",
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
                          hintText: "Enter your password",
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


                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8),
                      child: CustomTextWidget(
                          text: "New Password",
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
                        controller: passwordController,
                        style: TextStyle(color: Colors.black),
                        obscureText: isclick11!, // Hide the entered password
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          hintStyle: TextStyle(color: Color(0xffcacaca)),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SvgPicture.asset("images/lock.svg"),
                          ),
                          suffixIcon:

                          InkWell(
                            onTap: (){
                              setState(() {
                                isclick11=!isclick11!;
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

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8),
                      child: CustomTextWidget(
                          text: "Confirm new Password",
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
                        controller: con_passwordController,
                        style: TextStyle(color: Colors.black),
                        obscureText: isclick2!, // Hide the entered password
                        decoration: InputDecoration(
                          hintText: "Enter your password Again",
                          hintStyle: TextStyle(color: Color(0xffcacaca)),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SvgPicture.asset("images/lock.svg"),
                          ),
                          suffixIcon:

                          InkWell(
                            onTap: (){
                              setState(() {
                                isclick2=!isclick2!;
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
                    SizedBox(height: 32,),
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
                            "Confirm"
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

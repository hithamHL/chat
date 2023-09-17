import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/global.dart';
import '../../../../utils/theme.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/custom_widget.dart';
import '../../../widget/custome_styled_text_filde.dart';
import '../../../widget/error_dialog.dart';
import '../../../widget/loading_dialog.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  TextEditingController con_passwordController=TextEditingController();
  TextEditingController numbweController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
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

  formValidation(){

     if(numbweController.text.isEmpty||numbweController.text.length!=9){
    showDialog(
    context: context,
    builder: (c){
    return ErrorDialog(
    message: "check your ID Number",
    );
    });
    }
    else if(passwordController.text.isEmpty||passwordController.text.length<6){
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your password",
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
     // updatePassword();
        Get.toNamed(Routes.successfulResetPassword);
      //  hideLoadingDialog(context);

    }
  }

  Future updatePassword() async {
    User? user = FirebaseAuth.instance.currentUser;


      await user!.updatePassword(con_passwordController.text.trim());
      await Fluttertoast.showToast(msg: "Password has been updated");


    hideLoadingDialog(context);
  }
  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: false).pop();
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: screenColor,
        body:
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "images/forget3.png",
                        height: 300,

                      ),
                    ),

                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8),
                      child: CustomTextWidget(
                          text: "Enter Number",
                          textColor: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),


                    SizedBox(height: 12,),

                    CustomStyledTextField(
                      controller: numbweController,
                      hintText: "Enter your Number ID",
                      prefixSvgPath: "images/id_number.svg",
                      keyboardType: TextInputType.number,
                    ),


                    SizedBox(
                      height: 20,
                    ),

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

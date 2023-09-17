import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medicen_app/routes/routes.dart';
import 'package:medicen_app/utils/theme.dart';
import 'package:medicen_app/view/widget/custom_text.dart';
import 'package:medicen_app/view/widget/custom_widget.dart';
import 'package:medicen_app/view/widget/custome_styled_text_filde.dart';
import 'package:medicen_app/view/widget/loading_dialog.dart';

import '../../widget/error_dialog.dart';
import '../../widget/radio.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool? isclick=true;
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

  formValidation(){
    if(emailController.text.isNotEmpty &&
        emailController.text.contains("@")&&
        emailController.text.contains(".com")&&
        passwordController.text.isNotEmpty){
      //login
        showDialog(
        context: context,
        builder: (c){
          return LoadingDialog(message: "wait...");
        }
        );
     // loginNow();

    //  hideLoadingDialog(context);
    }
    else{
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your email and password",
            );
          });
    }
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // subscription.cancel();
  // }
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      "images/login_image.png",
                      width: 281,
                      height: 175,
                    ),
                  ),

                 SizedBox(height: 20,),


                 Padding(
                   padding: const EdgeInsets.only(left: 8.0,right: 8),
                   child: CustomTextWidget(
                       text: "Email",
                       textColor: Colors.black,
                       fontSize: 18,
                       fontWeight: FontWeight.bold),
                 ),


                  SizedBox(height: 12,),

                  CustomStyledTextField(
                      controller: emailController,
                      hintText: "Enter your Email Address",
                      prefixSvgPath: "images/sms.svg"),

                  SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child: CustomTextWidget(
                        text: "Password",
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
                      obscureText: isclick!, // Hide the entered password
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
                              isclick=!isclick!;
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
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            FilledRadio(
                              value: rememberMe!,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value;
                                });
                              },
                            ),
                            SizedBox(width: 5,),
                            CustomTextWidget(
                              text: "Remember Me",
                              textColor: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Get.toNamed(Routes.forgetPassword);
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 8),
                            child: CustomTextWidget(
                              text: "Forgot Password?",
                              textColor: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                          formValidation();
                        }

                      },
                      child: Text(
                            "Login"
                        ),
                      style: ElevatedButton.styleFrom(

                        primary: mainColor, // Set the button color to your desired color
                        padding: EdgeInsets.all(16), // Adjust the padding as needed
                        // Set minimum width to 200
                      ),
                    ),
                  ),
                  SizedBox(height: 32,),
                 CustomWidget(text: "OR"),
                  SizedBox(height: 16,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 100.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Color(0x11263238),

                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            "images/face.svg",
                            color: scandreColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 100.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Color(0x11263238),

                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            "images/google.svg",
                            color: scandreColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 100.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Color(0x11263238),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            "images/ipone.svg",
                            color: scandreColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16,),

                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account already? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign up",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Get.toNamed(Routes.signUpScreen);
                            },
                          ),
                        ],
                      ),
                    ),
                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

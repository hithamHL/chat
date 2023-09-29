import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medicen_app/utils/theme.dart';
import 'package:medicen_app/view/screen/auth/type_login_screen.dart';
import 'package:medicen_app/view/screen/main_screen.dart';
import 'package:medicen_app/view/widget/custom_text.dart';

import '../../../routes/routes.dart';
import '../../../utils/global.dart';
import '../../widget/custome_styled_text_filde.dart';
import '../../widget/error_dialog.dart';
import '../../widget/loading_dialog.dart';
import '../../widget/radio.dart';

class NewLoginScreen extends StatefulWidget {
  const NewLoginScreen({Key? key}) : super(key: key);

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  TextEditingController idController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool? isclick=true;
  bool? rememberMe=false;
  late StreamSubscription subscription;
  bool argumentValue = Get.arguments ?? false;

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
    if(idController.text.isNotEmpty &&
        (idController.text.length==9||idController.text.length==7)&&
        passwordController.text.isNotEmpty){

      //login
      print(idController.text.length);
      idController.text.length==9?loginNow():loginAsDoctor();


      //  hideLoadingDialog(context);
    }
    else{
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your Number ID and password".tr,
            );
          });
    }
  }
  Future<void> loginAsDoctor() async {
    showDialog(
      context: context,
      builder: (c) {
        return LoadingDialog(
          message: "Wait...".tr,
        );
      },
    );

    User? currentUser;

    await firebaseAuth.signInWithEmailAndPassword(
      // email: idController==9?"${idController.text.trim()}@gmail.com":"${idController.text.trim()}@doctor.com",
      email: "${idController.text.trim()}@doctor.com",
      password: passwordController.text,
    ).then((auth) async {
      currentUser = auth.user;


    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (c) {
          return ErrorDialog(
            message: "Error:".tr + error.message.toString(),
          );
        },
      );
    });

    if (currentUser != null) {
      readDataAndSetDataLocally(currentUser!);
    }
  }
  Future<void> loginNow() async {
    showDialog(
      context: context,
      builder: (c) {
        return LoadingDialog(
          message: "Wait...".tr,
        );
      },
    );

    User? currentUser;

    await firebaseAuth.signInWithEmailAndPassword(
      // email: idController==9?"${idController.text.trim()}@gmail.com":"${idController.text.trim()}@doctor.com",
      email: "${idController.text.trim()}@gmail.com",
      password: passwordController.text,
    ).then((auth) async {
      currentUser = auth.user;


    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (c) {
          return ErrorDialog(
            message: "Error:".tr + error.message.toString(),
          );
        },
      );
    });

    if (currentUser != null) {
      readDataAndSetDataLocally(currentUser!);
    }
  }


  Future readDataAndSetDataLocally(User currentUser) async{
    await FirebaseFirestore.instance
        .collection("users").doc(currentUser.uid)
        .get().then((snapshot)async{
      if(snapshot.exists){
        if(idController.text.length==7&&argumentValue==false){
          await sharedPreferences!.setString("uid", currentUser.uid);
          await sharedPreferences!.setString("email", snapshot.data()!["email"]);
          await sharedPreferences!.setString("name", snapshot.data()!["f_name"]);
          await sharedPreferences!.setString("photoUrl", snapshot.data()!["photoUrl"]);
          await sharedPreferences!.setString("password", snapshot.data()!["password"]);
       //   await sharedPreferences!.setString("token", snapshot.data()!["token"]);
          await sharedPreferences!.setBool("doctor", true);
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>MainScreen()));

        }else if(idController.text.length==9&&argumentValue==true){
          await sharedPreferences!.setString("uid", currentUser.uid);
          await sharedPreferences!.setString("email", snapshot.data()!["email"]);
          await sharedPreferences!.setString("name", snapshot.data()!["f_name"]);
          await sharedPreferences!.setString("photoUrl", snapshot.data()!["photoUrl"]);
          await sharedPreferences!.setString("password", snapshot.data()!["password"]);
          await sharedPreferences!.setString("token", snapshot.data()!["token"]);
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>MainScreen()));

        }else{
          Navigator.pop(context);
         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>TypeLoginScreen()));
          showDialog(
              context: context,
              builder: (c){
                return ErrorDialog(
                  message: "You cannot register here".tr,
                );
              });
        }

      }
      else{
        firebaseAuth.signOut();
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>TypeLoginScreen()));
        showDialog(
            context: context,
            builder: (c){
              return ErrorDialog(
                message: "Use an active account".tr,
              );
            });

      }


    });
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
      statusBarColor: mainColor,
    ));
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    print(argumentValue);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 120,),

            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
              child: CustomTextWidget(
                  text: "Welcome Back !".tr,
                  textColor: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
              child: CustomTextWidget(
                  text: "Log in to continue".tr,
                  textColor: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.normal),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  width: double.infinity,


                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20),),
                    color: Colors.white,

                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),


                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8),
                            child: CustomTextWidget(
                                text: "Enter Number".tr,
                                textColor: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),


                          SizedBox(height: 12,),

                          CustomStyledTextField(
                              controller: idController,
                              hintText: "Enter your Number ID".tr,
                              prefixSvgPath: "images/id_number.svg",
                          keyboardType: TextInputType.number,
                          ),

                          SizedBox(height: 20,),

                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8),
                            child: CustomTextWidget(
                                text: "Password".tr,
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
                                padding: const EdgeInsets.only(left: 8.0,right: 8),
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
                                      text: "Remember Me".tr,
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
                                      text: "Forgot Password?".tr,
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
                                  "Sign In".tr
                              ),
                              style: ElevatedButton.styleFrom(

                                primary: mainColor, // Set the button color to your desired color
                                padding: EdgeInsets.all(16), // Adjust the padding as needed
                                // Set minimum width to 200
                              ),
                            ),
                          ),
                          SizedBox(height: 32,),

                          argumentValue==true?

                          Align(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account already? ".tr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Sign up".tr,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      Get.offAndToNamed(Routes.newSignUpScreen);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ):
                              Container()
                        ],
                      ),
                    ),
                  ),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

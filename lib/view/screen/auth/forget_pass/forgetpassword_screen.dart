import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medicen_app/utils/theme.dart';

import '../../../../routes/routes.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/custome_styled_text_filde.dart';
import '../../../widget/error_dialog.dart';
import '../../../widget/loading_dialog.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);
 static String verify="";
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  String countryCode = '+970';
  TextEditingController phoneController=TextEditingController();
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlerSet = false;

  Future<ConnectivityResult> getConnectivityStatus() async {
    Connectivity connectivity = Connectivity();
    ConnectivityResult result = await connectivity.checkConnectivity();
    return result;
  }

  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }



  void formValidation() async {
    if (phoneController.text.isEmpty || phoneController.text.length != 9) {
      showDialog(
        context: context,
        builder: (c) {
          return ErrorDialog(
            message: "Check your phone number",
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (c) {
          return LoadingDialog(message: "Wait...");
        },
      );
      try{
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: countryCode + phoneController.text,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            print("mostafa :$e");
            print("mostafa :${countryCode + phoneController.text}");
          },
          codeSent: (String verificationId, int? resendToken) {
            print("mostafa :$verificationId");
            ForgetPasswordScreen.verify=verificationId;
            Get.toNamed(Routes.verificationScreen);
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            print("mostafa :$verificationId");

          },
        );
      }catch(e){
        Fluttertoast.showToast(msg: e.toString());
      }
      // Simulate an asynchronous operation, such as a network request
      await Future.delayed(Duration(seconds: 2)); // Replace with your actual logic

      // After the operation is complete, hide the loading dialog
      hideLoadingDialog(context);

      // Navigate to the next screen
     // Get.toNamed(Routes.verificationScreen);
    }
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
                Navigator.pop(context, 'Cancel'); // Close the dialog
                setState(() {
                  isAlerSet = false;
                });
                isDeviceConnected =
                await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  _showConnectivityErrorDialog();
                  setState(() {
                    isAlerSet = true;
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
          child: Center(
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "images/forget1.png",

                      ),
                    ),


                    SizedBox(height: 20,),

                    CustomTextWidget(
                    text: "Forgot your Password?",
                        textColor: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),



                    SizedBox(height: 16,),

                    CustomTextWidget(
                        text: "Enter your Phone number to retrieve your password.",
                        textColor: Color(0xffACB7CA),
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                    SizedBox(height: 30,),

                    Row(
                      children: [
                        Container(
                          height: 50,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFeaeaea),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value:
                              countryCode, // Your selected country code value
                              onChanged: (newValue) {
                                setState(() {
                                  countryCode = newValue!;
                                });

                              },

                              items: <String>[
                                '+970',
                                '+972'
                              ] // Your list of country codes
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'images/palstin.png', // Flag of Palestine image
                                        width: 24.0, // Adjust width as needed
                                        height: 16.0, // Adjust height as needed
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(value),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: CustomStyledTextField(
                            keyboardType: TextInputType.number,
                            controller: phoneController,
                            hintText: "  592418652",
                            prefixSvgPath: "",
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20,),


                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          //  getConnectivity();
                          ConnectivityResult connectivityResult =
                          await getConnectivityStatus();
                          if (connectivityResult == ConnectivityResult.none) {
                            _showConnectivityErrorDialog();
                          } else {
                            // Perform your login logic here

                          }
                          formValidation();

                        },
                        child: Text("Send verification code"),
                        style: ElevatedButton.styleFrom(
                          primary:
                          mainColor, // Set the button color to your desired color
                          padding:
                          EdgeInsets.all(16), // Adjust the padding as needed
                          // Set minimum width to 200
                        ),
                      ),
                    ),


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

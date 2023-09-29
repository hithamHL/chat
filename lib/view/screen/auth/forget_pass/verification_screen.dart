import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medicen_app/routes/routes.dart';
import 'package:medicen_app/utils/theme.dart';
import 'package:medicen_app/view/screen/auth/forget_pass/forgetpassword_screen.dart';
import 'package:pinput/pinput.dart';

import '../../../widget/error_dialog.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

    List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
    List<TextEditingController> _controllers =
    List.generate(6, (index) => TextEditingController());

    Timer? _resendTimer;
    bool _isResendEnabled = true;
    int _resendCountdown = 55;
    FirebaseAuth auth = FirebaseAuth.instance;
    String countryCode = '+970';
    String smsCode = '';

    TextEditingController phoneController=TextEditingController();
    late StreamSubscription subscription;
    var isDeviceConnected = false;
    bool isAlerSet = false;

    Future<ConnectivityResult> getConnectivityStatus() async {
      Connectivity connectivity = Connectivity();
      ConnectivityResult result = await connectivity.checkConnectivity();
      return result;
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

    void _startResendTimer() {
      _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_resendCountdown > 0) {
          setState(() {
            _resendCountdown--;
          });
        } else {
          setState(() {
            _isResendEnabled = true;
          });
          _resendTimer!.cancel();
        }
      });
    }

    @override
    void dispose() {
      for (var node in _focusNodes) {
        node.dispose();
      }
      for (var controller in _controllers) {
        controller.dispose();
      }
      _resendTimer?.cancel();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
         
          body: Padding(
            padding: EdgeInsets.all(16.0),
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
                          "images/forget2.png",
                        ),
                      ),


                      SizedBox(height: 20,),
                      Text(
                        "Enter the verification code".tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Please check your phone to get the code for continuing.".tr,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: List.generate(
                      //     6,
                      //         (index) => Container(
                      //       width: 50,
                      //       height: 50,
                      //       alignment: Alignment.center,
                      //           decoration: BoxDecoration(
                      //             color: Color(0xFFeaeaea),
                      //             borderRadius: BorderRadius.circular(20.0),
                      //
                      //           ),
                      //
                      //       child: TextField(
                      //         controller: _controllers[index],
                      //         textAlign: TextAlign.center,
                      //         keyboardType: TextInputType.number,
                      //         maxLength: 1,
                      //         decoration: InputDecoration(
                      //           border: InputBorder.none,
                      //           focusedBorder: InputBorder.none,
                      //           enabledBorder: InputBorder.none,
                      //           counterText: "",
                      //
                      //         ),
                      //         onChanged: (text) {
                      //           if (text.isNotEmpty) {
                      //             _focusNodes[index].unfocus();
                      //             if (index < _controllers.length - 1) {
                      //               _focusNodes[index + 1].requestFocus();
                      //               smsCode=_controllers[index].text;
                      //
                      //             }
                      //           }
                      //
                      //         },
                      //
                      //         focusNode: _focusNodes[index],
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      Pinput(
                        length: 6,
                        onChanged: (value){
                          smsCode=value;
                        },
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:  ()async  {
                              try{
                                if(smsCode.isEmpty||smsCode.length!=6){
                                  showDialog(
                                    context: context,
                                    builder: (c) {
                                      return ErrorDialog(
                                        message: "Check your Verify number".tr,
                                      );
                                    },
                                  );
                                }
                                PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: ForgetPasswordScreen.verify, smsCode: smsCode);
                                print(smsCode);

                                // Sign the user in (or link) with the credential
                                 await auth.signInWithCredential(credential);
                                  Get.toNamed(Routes.changePassword);
                              }catch(e){
                                print('mostafa e : $e');
                                  }

                          }
                              ,
                          child: Text("Verify".tr),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            // Handle resending logic here
                            if (_isResendEnabled) {
                              setState(() {
                                _isResendEnabled = false;
                                _resendCountdown = 55;
                              });
                              _startResendTimer();
                            }
                          },
                          child: Text(
                            "Didn't you receive a code? Resend".tr,
                            style: TextStyle(
                              color: _isResendEnabled ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.center,

                        child: Text(
                          "Resend on 00:${_resendCountdown.toString().padLeft(2, '0')}".tr,
                          style: TextStyle(color: Colors.grey),
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

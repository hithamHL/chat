import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medicen_app/routes/routes.dart';

class SuccessfulResetPassword extends StatefulWidget {
  const SuccessfulResetPassword({Key? key}) : super(key: key);

  @override
  State<SuccessfulResetPassword> createState() => _SuccessfulResetPasswordState();
}

class _SuccessfulResetPasswordState extends State<SuccessfulResetPassword> {
  List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  List<TextEditingController> _controllers =
  List.generate(6, (index) => TextEditingController());



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
                Navigator.pop(context, 'Cancel'.tr); // Close the dialog
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
              child: Text("OK".tr),
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

        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40,),

                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "images/forget4.png",
                    ),
                  ),


                  SizedBox(height: 30,),
                  Text(
                    "Reset Password Successfully".tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Reset your password to recovery & login to your account ".tr,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                          Get.toNamed(Routes.typeLoginScreen);
                      },
                      child: Text("Log In".tr),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        "images/tree.png",
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),


    );
  }
}

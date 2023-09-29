import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medicen_app/utils/theme.dart';
import 'package:medicen_app/view/widget/custom_text.dart';
import '../../../routes/routes.dart';

class TypeLoginScreen extends StatefulWidget {
  const TypeLoginScreen({Key? key}) : super(key: key);

  @override
  State<TypeLoginScreen> createState() => _TypeLoginScreenState();
}

class _TypeLoginScreenState extends State<TypeLoginScreen> {
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "images/new_login.png",
                            width: 281,
                            height: 175,
                          ),
                        ),

                        SizedBox(height: 20),

                        CustomTextWidget(
                            text: "Log in as".tr,
                            textColor: mainColor,
                            fontSize: 22,
                            fontWeight: FontWeight.normal),

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
                                Get.toNamed(Routes.newLoginScreen,arguments: false);

                              }

                            },
                            child: Text(
                                "pharmaceutical".tr
                            ),
                            style: ElevatedButton.styleFrom(

                              primary: mainColor, // Set the button color to your desired color
                              padding: EdgeInsets.all(16), // Adjust the padding as needed
                              // Set minimum width to 200
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              // getConnectivity();
                              ConnectivityResult connectivityResult = await getConnectivityStatus();
                              if (connectivityResult == ConnectivityResult.none) {
                                _showConnectivityErrorDialog();
                              } else {
                                Get.toNamed(Routes.newLoginScreen,arguments: true);
                              }
                            },
                            child: Text(
                              "User".tr,
                              style: TextStyle(
                                color: mainColor,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white, // Set the button color to your desired color
                              padding: EdgeInsets.all(16), // Adjust the padding as needed
                              side: BorderSide(
                                color: Colors.green, // Set the border color
                                width: 2.0, // Set the border width
                              ),
                            ),
                          ),
                        ),



                      ],
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

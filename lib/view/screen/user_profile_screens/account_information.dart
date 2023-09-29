import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/global.dart';
import '../../../utils/theme.dart';
import '../../widget/custom_text.dart';
import '../../widget/custome_styled_text_filde.dart';
import '../../widget/error_dialog.dart';
import '../../widget/loading_dialog.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({Key? key}) : super(key: key);

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {

  TextEditingController f_nameController = TextEditingController();
  TextEditingController l_nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool? isclick = true;
  bool? rememberMe = false;
  String countryCode = '+970';
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

  formValidation(){
    if(f_nameController.text.isEmpty||f_nameController.text.length<3){
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your First name",
            );
          });
    }else if(l_nameController.text.isEmpty||l_nameController.text.length<3){
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your Last name",
            );
          });
    }
    else if(phoneController.text.isEmpty|| phoneController.text.length!=9)
    {
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your phone number",
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
      upDataToFirestore();


      hideLoadingDialog(context);

    }
  }



  Future upDataToFirestore() async {
    String? uid= sharedPreferences!.getString("uid");
    FirebaseFirestore.instance.collection("users").doc(uid).update({

         "phone": "0${phoneController.text.trim()}",
      "f_name": f_nameController.text.trim(),
      "l_name": l_nameController.text.trim(),
      "full_name": "${f_nameController.text.trim()} ${l_nameController.text.trim()}",
      "status": "approved",
        });

    // Save data locally (if needed)
    sharedPreferences = await SharedPreferences.getInstance();
   await sharedPreferences!.setString("name", f_nameController.text.trim());
   await sharedPreferences!.setString("phone","0${phoneController.text.trim()}");
   Fluttertoast.showToast(msg: "Account info has been Update");
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
              "Account Information".tr,
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
                      SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                                  child: CustomTextWidget(
                                      text: "First Name".tr,
                                      textColor: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                CustomStyledTextField(
                                    keyboardType: TextInputType.text,
                                    controller: f_nameController,
                                    hintText: "Enter f-Name".tr,
                                    prefixSvgPath: "images/user.svg"),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                                  child: CustomTextWidget(
                                      text: "Last Name".tr,
                                      textColor: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                CustomStyledTextField(
                                    keyboardType: TextInputType.text,
                                    controller: l_nameController,
                                    hintText: "  Enter l-Name".tr,
                                    prefixSvgPath: ""),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: CustomTextWidget(
                            text: "Phone Number".tr,
                            textColor: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12,
                      ),
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


                      SizedBox(
                        height: 20,
                      ),
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
                          child: Text("Update".tr),
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
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }
}

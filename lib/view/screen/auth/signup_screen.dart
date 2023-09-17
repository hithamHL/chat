import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../routes/routes.dart';
import '../../../utils/theme.dart';
import '../../widget/custom_text.dart';
import '../../widget/custom_widget.dart';
import '../../widget/custome_styled_text_filde.dart';
import '../../widget/error_dialog.dart';
import '../../widget/loading_dialog.dart';
import '../../widget/radio.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController f_nameController = TextEditingController();
  TextEditingController l_nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
   else if(!(idController.text.isNotEmpty &&
        idController.text.contains("@")&&
        idController.text.contains(".com"))
        ){

      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your Number ID",
            );
          });

    }else if(phoneController.text.isEmpty|| phoneController.text.length!=9)
    {
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your phone number",
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
    else{
      showDialog(
          context: context,
          builder: (c){
            return LoadingDialog(message: "wait...");
          }
      );
      // loginNow();

      //  hideLoadingDialog(context);

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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: CustomTextWidget(
                        text: "SIGN IN",
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        textColor: mainColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                                  text: "First Name",
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
                                hintText: "Enter f-Name",
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
                                  text: "Last Name",
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
                                hintText: "  Enter l-Name",
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
                        text: "Email",
                        textColor: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomStyledTextField(
                      controller: idController,
                      hintText: "Enter your Email Address",
                      prefixSvgPath: "images/sms.svg"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: CustomTextWidget(
                        text: "Phone Number",
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: CustomTextWidget(
                        text: "Password",
                        textColor: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 12,
                  ),
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
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isclick = !isclick!;
                            });
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "By Clicking “Sign up” , IAgree To ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: "Terms of Condtion",
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Get.toNamed(Routes.loginScreen);
                                },
                            ),
                            const TextSpan(
                              text: " &",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: " Privocy Police",
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //Get.toNamed(Routes.loginScreen);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
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
                      child: Text("Sign In"),
                      style: ElevatedButton.styleFrom(
                        primary:
                            mainColor, // Set the button color to your desired color
                        padding:
                            EdgeInsets.all(16), // Adjust the padding as needed
                        // Set minimum width to 200
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  CustomWidget(text: "OR"),
                  SizedBox(
                    height: 16,
                  ),
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
                  SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: "Already  have an account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(Routes.loginScreen);
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

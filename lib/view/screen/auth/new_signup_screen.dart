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
import 'package:medicen_app/view/widget/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/routes.dart';
import '../../../utils/global.dart';
import '../../widget/custome_styled_text_filde.dart';
import '../../widget/error_dialog.dart';
import '../../widget/loading_dialog.dart';
import '../../widget/radio.dart';

class NewSignUpScreen extends StatefulWidget {
  const NewSignUpScreen({Key? key}) : super(key: key);

  @override
  State<NewSignUpScreen> createState() => _NewSignUpScreenState();
}

class _NewSignUpScreenState extends State<NewSignUpScreen> {
  TextEditingController numbweController = TextEditingController();
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
    else if(numbweController.text.length!=9){

      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your Number",
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

      authenticateSellerAndSignUp();
      hideLoadingDialog(context);

    }
  }

  void authenticateSellerAndSignUp() async {
    User? currentUser;

    try {
      final authResult = await firebaseAuth.createUserWithEmailAndPassword(
        email: "${numbweController.text.trim()}@gmail.com",
        password: passwordController.text,
      );

      currentUser = authResult.user;

      if (currentUser != null) {
        print("User created: $currentUser");

        // Generate a Firebase Authentication token for the new user
        final User user = FirebaseAuth.instance.currentUser!;
        final idTokenResult = await user.getIdTokenResult();
        final String? token = idTokenResult.token;

        // Save the token and other user data to Firestore
        await saveDataToFirestore(currentUser, token!);

        // Navigate to the main screen or your desired destination
        Get.toNamed(Routes.mainScreen);
      }
    } catch (error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (c) {
          return ErrorDialog(
            message: "خطأ" + error.toString(),
          );
        },
      );
    }
  }

  Future saveDataToFirestore(User currentUser, String token) async {
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "uid": currentUser.uid,
      "number": numbweController.text.trim(),
      "email": "${numbweController.text.trim()}@gmail.com",
      "phone": "0${phoneController.text.trim()}",
      "f_name": f_nameController.text.trim(),
      "l_name": l_nameController.text.trim(),
      "password": passwordController.text.trim(),
      "full_name": "${f_nameController.text.trim()} ${l_nameController.text.trim()}",
      "photoUrl": "",
      "status": "approved",
      "token": token, // Save the token in Firestore
    });

    // Save data locally (if needed)
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", "${numbweController.text.trim()}@gmail.com");
    await sharedPreferences!.setString("name", f_nameController.text.trim());
    await sharedPreferences!.setString("number", numbweController.text.trim());
    await sharedPreferences!.setString("password", passwordController.text.trim());
    await sharedPreferences!.setString("token", token);
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
        backgroundColor: mainColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70,),

            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CustomTextWidget(
                  text: "Welcome Back !",
                  textColor: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CustomTextWidget(
                  text: "Log in to continue",
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
                                        Get.offAndToNamed(Routes.newLoginScreen);
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
            ),
          ],
        ),
      ),
    );
  }
}

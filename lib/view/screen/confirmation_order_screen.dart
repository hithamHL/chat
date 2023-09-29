import 'dart:async';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medicen_app/routes/routes.dart';
import 'package:medicen_app/view/widget/custom_text.dart';
import 'package:medicen_app/view/widget/custome_styled_text_filde.dart';
import 'package:medicen_app/view/widget/radio.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../utils/global.dart';
import '../../utils/theme.dart';

class ConfirmationOrderScreen extends StatefulWidget {
  const ConfirmationOrderScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmationOrderScreen> createState() => _ConfirmationOrderScreenState();
}
enum RadioValue { option1, option2 }
enum RadioValue2 { option1, option2 }
class _ConfirmationOrderScreenState extends State<ConfirmationOrderScreen> {
  String? uid;
  bool? r1=false;
 TextEditingController number=TextEditingController();
 TextEditingController name=TextEditingController();
 TextEditingController expiretion=TextEditingController();
 TextEditingController code=TextEditingController();
  RadioValue selectedValue = RadioValue.option1;
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



  RadioValue2 selectedValue2 = RadioValue2.option1;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xffFFFAEB),
    ));
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    uid = sharedPreferences!.getString("uid");
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
              "Confirmation",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    child: Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 120,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(uid)
                                .collection("address")
                                .where("status", isEqualTo: "true")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(child: Text("Error: ${snapshot.error}"));
                              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                return Center(child: Text("No addresses found."));
                              } else {
                                // Render the list of addresses
                                return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final addressData =
                                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                                    return InkWell(
                                      onTap: (){
                                        Get.toNamed(Routes.addressScreen);
                                      },
                                      child: Card(
                                        elevation: 3,
                                        color: mainColor2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${addressData["f_name"]} ${addressData["l_name"]}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(
                                                "${addressData["email"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 4.0),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "${addressData["details_address"]}, ${addressData["city"]}, ${addressData["governorate"]}",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),

                                            Icon(Icons.arrow_back_ios_outlined,color: Colors.black,)

                                        ],
                                              ),
                                              SizedBox(height: 4.0),

                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                        Divider(thickness: 1,),
                        SizedBox(height: 8.0),
                        CustomTextWidget(
                            text: "Receive options",
                            textColor: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        SizedBox(height: 16.0),

                        Row(
                          children: [
                            FilledRadio(
                              value: selectedValue == RadioValue.option1,
                              onChanged: (bool value) {
                                setState(() {
                                  if (value) {
                                    selectedValue = RadioValue.option1;
                                  }
                                });
                              },
                            ),
                            SizedBox(width: 8,),
                            CustomTextWidget(
                                text: "Delivery",
                                textColor: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ],
                        ),
                        SizedBox(height: 16.0),

                        Row(
                          children: [
                            FilledRadio(
                              value: selectedValue == RadioValue.option2,
                              onChanged: (bool value) {
                                setState(() {
                                  if (value) {
                                    selectedValue = RadioValue.option2;
                                  }
                                });
                              },
                            ),
                            SizedBox(width: 8,),

                            CustomTextWidget(
                                text: "Pick it up",
                                textColor: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ],
                        ),
                        SizedBox(height: 16.0),

                        Divider(thickness: 1,),
                        SizedBox(height: 8.0),
                        CustomTextWidget(
                            text: "Payment Method",
                            textColor: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        SizedBox(height: 16.0),

                        Row(
                          children: [
                            FilledRadio(
                              value: selectedValue2 == RadioValue2.option1,
                              onChanged: (bool value) {
                                setState(() {
                                  if (value) {
                                    selectedValue2 = RadioValue2.option1;
                                  }
                                });
                              },
                            ),
                            SizedBox(width: 8,),
                            CustomTextWidget(
                                text: "Paiement when recieving",
                                textColor: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ],
                        ),
                        SizedBox(height: 16.0),

                        Row(
                          children: [
                            FilledRadio(
                              value: selectedValue2 == RadioValue2.option2,
                              onChanged: (bool value) {
                                setState(() {
                                  if (value) {
                                    selectedValue2 = RadioValue2.option2;
                                  }
                                });
                              },
                            ),
                            SizedBox(width: 8,),

                            CustomTextWidget(
                                text: "Cridet card",
                                textColor: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ],
                        ),



                        selectedValue2 == RadioValue2.option2?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 16.0),
                                Divider(thickness: 1,),
                                SizedBox(height: 8.0),
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
                                                text: "Card Number",
                                                textColor: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          ),

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

                                          CustomStyledTextField(
                                              keyboardType: TextInputType.text,
                                              controller: number,
                                              hintText: "  0000-0000-0000-0000",
                                              prefixSvgPath: ""),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
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
                                                text: "Name On Card",
                                                textColor: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          ),

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

                                          CustomStyledTextField(
                                              keyboardType: TextInputType.text,
                                              controller: name,
                                              hintText: "  Enter your name",
                                              prefixSvgPath: ""),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
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
                                                text: "Expiration(MM/YY)",
                                                textColor: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          ),

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

                                          CustomStyledTextField(
                                              keyboardType: TextInputType.text,
                                              controller: expiretion,
                                              hintText: "  05/24",
                                              prefixSvgPath: ""),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
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
                                                text: "Security Code",
                                                textColor: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          ),

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

                                          CustomStyledTextField(
                                              keyboardType: TextInputType.text,
                                              controller: code,
                                              hintText: "  Security Code",
                                              prefixSvgPath: ""),


                                        ],
                                      ),
                                    ),
                                  ],
                                ),


                              ],
                            )
                            :Container(),
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
                              // formValidation();
                            },
                            child: Text("Confirmation Order"),
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
      ),
    );
  }
}

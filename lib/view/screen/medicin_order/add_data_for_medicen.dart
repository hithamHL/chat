import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medicen_app/view/widget/error_dialog.dart';

import '../../../utils/theme.dart';
import '../../widget/custom_text.dart';
import '../../widget/custome_styled_text_filde.dart';
import '../../widget/loading_dialog.dart';



class AddDataForMedicen extends StatefulWidget {
  const AddDataForMedicen({Key? key}) : super(key: key);

  @override
  State<AddDataForMedicen> createState() => _AddDataForMedicenState();
}

class _AddDataForMedicenState extends State<AddDataForMedicen> {
  String? uid;
  bool? r1=false;
  TextEditingController idController = TextEditingController();
  TextEditingController f_nameController = TextEditingController();
  TextEditingController l_nameController = TextEditingController();
  TextEditingController nameMedicineController = TextEditingController();
  TextEditingController numberTakeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController countController = TextEditingController();
  TextEditingController detailsToTakeController = TextEditingController();

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

  formValidation(){
    if(f_nameController.text.isEmpty||f_nameController.text.length<3){
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your First name".tr,
            );
          });
    }else if(l_nameController.text.isEmpty||l_nameController.text.length<3){
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your Last name".tr,
            );
          });
    }
    else if(idController.text.length!=9){

      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your Number".tr,
            );
          });

    }

    else if(nameMedicineController.text.isEmpty||nameMedicineController.text.length<3){
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your Medicine Name input".tr,
            );
          });
    }
    else if(numberTakeController.text.isEmpty){
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your Number To Take Medicine input".tr,
            );
          });
    }
    else if(priceController.text.isEmpty){
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your price input".tr,
            );
          });
    }
    else if(countController.text.isEmpty){
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your Amount input".tr,
            );
          });
    }
    else if(detailsToTakeController.text.isEmpty||detailsToTakeController.text.length<7){
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your Details input".tr,
            );
          });
    }
    else{
      showDialog(
          context: context,
          builder: (c){
            return LoadingDialog(message: "wait...".tr);
          }
      );
      // loginNow();

     // authenticateSellerAndSignUp();
      hideLoadingDialog(context);

    }
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xffFFFAEB),
    ));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          // backgroundColor: mainColor2,
          appBar: AppBar(
            elevation: 2,
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
              "Add Medicine".tr,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0,),
                  child: Container(
                    width: double.infinity,





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
                              padding: const EdgeInsets.only(left: 8.0,right: 8),
                              child: CustomTextWidget(
                                  text: "Number Id".tr,
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




                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: CustomTextWidget(
                                  text: "Medicine Name".tr,
                                  textColor: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 12,
                            ),

                            CustomStyledTextField(
                              controller: nameMedicineController,
                              hintText: "Enter Medicine Name".tr,
                              prefixSvgPath: "images/ne3.svg",
                              keyboardType: TextInputType.text,
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: CustomTextWidget(
                                  text: "Time Of Take The Medicine".tr,
                                  textColor: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 12,
                            ),

                            CustomStyledTextField(
                              controller: numberTakeController,
                              hintText: "Enter The Number here".tr,
                              prefixSvgPath: "images/ne1.svg",
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: CustomTextWidget(
                                  text: "Price".tr,
                                  textColor: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 12,
                            ),

                            CustomStyledTextField(
                              controller: priceController,
                              hintText: "Enter The Price here".tr,
                              prefixSvgPath: "images/ne2.svg",
                              keyboardType: TextInputType.number,
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: CustomTextWidget(
                                  text: "Amount".tr,
                                  textColor: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 12,
                            ),

                            CustomStyledTextField(
                              controller: countController,
                              hintText: "Enter Amount here".tr,
                              prefixSvgPath: "images/id_number.svg",
                              keyboardType: TextInputType.number,
                            ),


                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: CustomTextWidget(
                                  text: "Details To Take Medicine".tr,
                                  textColor: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 12,
                            ),

                            CustomStyledTextField(
                              controller: detailsToTakeController,
                              hintText: "Enter Details here".tr,
                              prefixSvgPath: "images/ne1.svg",
                              keyboardType: TextInputType.text,
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
                                child: Text("Add Medicine".tr),
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
      ),
    );
  }
}

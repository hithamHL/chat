import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../../utils/global.dart';
import '../../../../utils/theme.dart';
import '../../../widget/custom_style_dropdown.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/custome_styled_text_filde.dart';
import '../../../widget/error_dialog.dart';
import '../../../widget/loading_dialog.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController f_nameController = TextEditingController();
  TextEditingController l_nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String _selectedOption = 'Option 1';
  String _selectedOption2 = 'Option 1';
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
  Future saveDataToFirestore() async {
    String? uid = sharedPreferences!.getString("uid");

    // Generate a unique identifier for the address document (e.g., a timestamp)
    String addressDocumentId = DateTime.now().millisecondsSinceEpoch.toString();

    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("address")
        .doc(addressDocumentId) // Use the generated ID here
        .set({
      "phone": "0${phoneController.text.trim()}",
      "f_name": f_nameController.text.trim(),
      "email": emailController.text.trim(),
      "l_name": l_nameController.text.trim(),
      "city": _selectedOption,
      "addressDocumentId": addressDocumentId,
      "governorate": _selectedOption2,
      "details_address": addressController.text.trim(),
      "full_name": "${f_nameController.text.trim()} ${l_nameController.text.trim()}",
      "status": "approved",
    });

    await Fluttertoast.showToast(msg: "The Address has been Added");
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
    else if(!(emailController.text.isNotEmpty &&
        emailController.text.contains("@")&&
        emailController.text.contains(".com"))
    ){

      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your email",
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
    else if(_selectedOption=="Option 1"){
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your City Input",
            );
          });
    }
    else if(_selectedOption2=="Option 1"){
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your Governorate Input",
            );
          });
    }
    else if(addressController.text.isEmpty||addressController.text.length<7){
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "check your Address Details",
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
      saveDataToFirestore();

        hideLoadingDialog(context);

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
              "Add Address",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

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
                        controller: emailController,
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
                            text: "City",
                          textColor: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: double.infinity,
                      child: CustomStyledDropdown(
                        value: _selectedOption,
                        items: [

                          DropdownMenuItem(
                            child: Text('  City'),
                            value: 'Option 1',
                          ),

                          DropdownMenuItem(
                            child: Text('  Gaza'),
                            value: 'Gaza',
                          ),
                          DropdownMenuItem(
                            child: Text('  West Bank'),
                            value: 'West Bank',
                          ),

                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: CustomTextWidget(
                          text: "Governorate",
                          textColor: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: double.infinity,
                      child: CustomStyledDropdown(
                        value: _selectedOption2,
                        items: [
                          DropdownMenuItem(
                            child: Text('  Governorate'),
                            value: 'Option 1',
                          ),
                          DropdownMenuItem(
                            child: Text('  Ramallah'),
                            value: 'Ramallah',
                          ),
                          DropdownMenuItem(
                            child: Text('  Bethlehem'),
                            value: 'Bethlehem',
                          ),DropdownMenuItem(
                            child: Text('  Hebron'),
                            value: 'Hebron',
                          ),DropdownMenuItem(
                            child: Text('  Nablus'),
                            value: 'Nablus',
                          ),DropdownMenuItem(
                            child: Text('  Jericho'),
                            value: 'Jericho',
                          ),DropdownMenuItem(
                            child: Text('  Jenin'),
                            value: 'Jenin',
                          ),DropdownMenuItem(
                            child: Text('  Tulkarm'),
                            value: 'Tulkarm',
                          ),DropdownMenuItem(
                            child: Text('  Qalqilya'),
                            value: 'Qalqilya',
                          ),DropdownMenuItem(
                            child: Text('  Bethlehem'),
                            value: 'Bethlehem',
                          ),DropdownMenuItem(
                            child: Text('  Beit Jala'),
                            value: 'Beit Jala',
                          ),DropdownMenuItem(
                            child: Text('  Beit Sahour'),
                            value: 'Beit Sahour',
                          ),DropdownMenuItem(
                            child: Text('  Salfit'),
                            value: 'Salfit',
                          ),DropdownMenuItem(
                            child: Text('  Abu Dis'),
                            value: 'Abu Dis',
                          ),DropdownMenuItem(
                            child: Text('  Gaza City'),
                            value: 'Gaza City',
                          ),DropdownMenuItem(
                            child: Text('  Rafah'),
                            value: 'Rafah',
                          ),DropdownMenuItem(
                            child: Text('  Khan Yunis'),
                            value: 'Khan Yunis',
                          ),DropdownMenuItem(
                            child: Text('  Beit Hanoun '),
                            value: 'Beit Hanoun',
                          ),DropdownMenuItem(
                            child: Text('  Deir al-Balah'),
                            value: 'Deir al-Balah',
                          ),DropdownMenuItem(
                            child: Text('  Jabalia'),
                            value: 'Jabalia',
                          ),DropdownMenuItem(
                            child: Text('  Nuseirat'),
                            value: 'Nuseirat',
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedOption2 = value!;
                          });
                        },
                      ),
                    ),


                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: CustomTextWidget(
                          text: "Address details (street & Near place)",
                          textColor: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CustomStyledTextField(
                        controller: addressController,
                        hintText: "  Enter your Address details",
                        prefixSvgPath: ""),

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
                        child: Text("Add Address"),
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

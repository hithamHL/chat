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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../utils/global.dart';
import '../../../utils/theme.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String? uid;
  bool? isclick1=true;
  bool? isclick2=true;
  bool? rememberMe=false;
  late StreamSubscription subscription;
  var isDeviceConnected=false;
  bool isAlerSet=false;

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
              "Address".tr,
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
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          //  getConnectivity();
                          ConnectivityResult connectivityResult = await getConnectivityStatus();
                          if (connectivityResult == ConnectivityResult.none) {
                            _showConnectivityErrorDialog();
                          } else {
                            // Perform your login logic here
                            Get.toNamed(Routes.addAddressScreen);
                          }

                        },
                        child: Text(
                            "Add Address".tr
                        ),
                        style: ElevatedButton.styleFrom(

                          primary: mainColor, // Set the button color to your desired color
                          padding: EdgeInsets.all(16), // Adjust the padding as needed
                          // Set minimum width to 200
                        ),
                      ),

                    ),
                    SizedBox(height: 10,),
                    Divider(thickness: 1,),

                    Container(
                      height: 560,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(uid)
                            .collection("address")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text("Error: ${snapshot.error}".tr));
                          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return Center(child: Text("No addresses found".tr));
                          } else {
                            // Render the list of addresses
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final addressData =
                                snapshot.data!.docs[index].data() as Map<String, dynamic>;
                                void deleteAddress() async {
                                  // Delete the address document from Firestore
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(uid)
                                      .collection("address")
                                      .doc(snapshot.data!.docs[index].id)
                                      .delete();
                                }
                                void updateStatus() async {
                                  // Delete the address document from Firestore
                                  final addressesQuery = FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(uid)
                                      .collection("address");

                                  // Retrieve all addresses
                                  final addresses = await addressesQuery.get();

                                  // Update all addresses to "status: false"
                                  for (final doc in addresses.docs) {
                                    await addressesQuery.doc(doc.id).update({"status": "false"});
                                  }


                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(uid)
                                      .collection("address")
                                      .doc(snapshot.data!.docs[index].id)
                                      .update({
                                    "status": "true",
                                  });
                                }
                                return GestureDetector(
                                  onLongPress: (){
                                    ArtSweetAlert.show(
                                      context: context,
                                      artDialogArgs: ArtDialogArgs(
                                          type: ArtSweetAlertType.question,
                                          title: "Delete Address".tr,
                                          text: "Do you want to delete address?".tr,
                                          onCancel: (){
                                            Navigator.of(context, rootNavigator: true).pop();
                                          },
                                          cancelButtonText: "Cancel".tr,
                                          showCancelBtn: true,
                                          confirmButtonText: "Ok".tr,
                                          onConfirm: (){
                                            deleteAddress();
                                            Navigator.of(context, rootNavigator: true).pop();
                                            Fluttertoast.showToast(msg: "the address has been deleted".tr);
                                          },
                                          confirmButtonColor: mainColor




                                      ),
                                    );
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
                                          SizedBox(height: 8.0),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${addressData["phone"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              InkWell(
                                                  onTap: (){
                                                    var url='tel://${addressData["phone"]}';
                                                    launchUrlString(url);
                                                  },
                                                  child: Icon(Icons.phone_outlined,color: mainColor,))
                                            ],
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            "${addressData["details_address"]}, ${addressData["city"]}, ${addressData["governorate"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 8.0),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                              onTap: (){
                                                updateStatus();
                                                Fluttertoast.showToast(msg: "the address be default".tr);
                                              },
                                              child: Text(
                                                "Default Address".tr,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blue
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
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
                    )

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

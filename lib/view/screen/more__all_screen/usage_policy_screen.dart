import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medicen_app/utils/theme.dart';

import '../../../routes/routes.dart';
import '../../../services/json_file/all_categries.dart';

class UsagePolicyScreen extends StatefulWidget {
  const UsagePolicyScreen({Key? key}) : super(key: key);

  @override
  State<UsagePolicyScreen> createState() => _UsagePolicyScreenState();
}

class _UsagePolicyScreenState extends State<UsagePolicyScreen> {
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
              "Usage Policy",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Usage Policy",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Welcome to our app's Usage Policy. This policy governs the use of our mobile application and outlines the terms and conditions you agree to when using our app. By using our app, you are agreeing to comply with and be bound by the following usage policy. Please read it carefully and ensure that you fully understand its contents.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "1. Acceptance of Terms",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "By using our app, you acknowledge that you have read and agree to these terms and conditions. If you do not agree with any part of this policy, please do not use our app.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "2. Appropriate Use",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "You agree to use our app only for lawful purposes and in a way that does not infringe on the rights of others, violate any laws, or interfere with the operation of the app. Unacceptable use may result in the termination of your access to the app.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                // Add more sections and text as needed for your usage policy.
              ],
            ),
          ),
        ),
      ),
    );
  }
}

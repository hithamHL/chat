import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

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
              "Notification".tr,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [

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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medicen_app/utils/theme.dart';

import '../../../routes/routes.dart';
import '../../../services/json_file/all_categries.dart';

class AboutAusScreen extends StatefulWidget {
  const AboutAusScreen({Key? key}) : super(key: key);

  @override
  State<AboutAusScreen> createState() => _AboutAusScreenState();
}

class _AboutAusScreenState extends State<AboutAusScreen> {
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
              "About App".tr,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Welcome to our pharmacy app, where we offer a wide range of medical and beauty supplies for all ages, along with continuous communication between the pharmacist and the customer.".tr,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Features of Our App:".tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "• Browse and purchase your favorite medical and beauty supplies with ease from anywhere, at any time.".tr,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "• Communicate with our professional pharmacy team through the app to get the necessary health advice and consultations.".tr,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "• Receive notifications and updates about our exclusive offers and discounts on health and beauty products.".tr,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "• Browse a diverse range of products that cater to all family needs, including children and seniors.".tr,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "• Enjoy a convenient delivery service that makes obtaining your products easy and hassle-free.".tr,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Our app is committed to providing high-quality service and trusted products to help you take care of your health and beauty. Feel free to try it out and enjoy its full benefits for your health and beauty needs with ease and convenience.".tr,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

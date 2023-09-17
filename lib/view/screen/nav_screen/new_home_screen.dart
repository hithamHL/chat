import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medicen_app/routes/routes.dart';
import 'package:medicen_app/utils/theme.dart';
import 'package:medicen_app/view/widget/custom_text.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({Key? key}) : super(key: key);

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
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
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomTextWidget(
                      text: "Good For You".tr,
                      textColor: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  Icon(
                    Icons.favorite,
                    color: mainColor,
                  ),
                  CustomTextWidget(
                      text: ".",
                      textColor: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    width: 175,
                  ),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.notificationScreen);

                    },
                    child: Stack(
                      children: <Widget>[
                        Icon(CupertinoIcons.bell_fill,color: Colors.grey,size: 25,),

                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: mainColor,
                            ),
                            child: Text(
                              '5', // Replace with your desired number
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextWidget(
                  text: "Great For Life .",
                  textColor: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: 8,
              ),
              Image.asset("images/home_image.png"),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Our pharmacy application offers a range of amazing features. Speed ​​of delivery is one of the most important of these features, as we are committed to delivering medicines and products to your doorstep as quickly as possible. We understand how important time is to our customers and always strive to ensure a fast and efficient delivery service.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

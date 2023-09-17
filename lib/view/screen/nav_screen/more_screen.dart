import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medicen_app/routes/routes.dart';
import 'package:medicen_app/utils/theme.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {


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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Hello, how can we help you?",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                    )
                ),
              ),

              SizedBox(
                height: 150,

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Get.toNamed(Routes.aboutAusScreen);

                          },
                          child: Stack(
                            children:[
                              ClipPath(
                                  clipper: HomeClipper(),
                                  child: ColoredBox(
                                    color: mainColor,
                                    child: SizedBox(width: double.maxFinite, height: 200),
                                  )),

                              Center(child: Text(
                                  "About the app",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  )
                              )
                              )

                            ] ,
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Get.toNamed(Routes.privacyAndPolicyScreen);
                          },
                          child: Stack(
                            children:[
                              ClipPath(
                                  clipper: HomeClipper(),
                                  child: ColoredBox(
                                    color: mainColor,
                                    child: SizedBox(width: double.maxFinite, height: 200),
                                  )),

                              Center(child: Text(
                                  "privacy policy",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  )
                              )
                              )

                            ] ,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 150,
                width: 195,
                child: Align(
                 alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(


                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              Get.toNamed(Routes.usagePolicyScreen);
                            },
                            child: Stack(
                              children:[
                                ClipPath(
                                    clipper: HomeClipper(),
                                    child: ColoredBox(
                                      color: mainColor,
                                        child: SizedBox(width: double.maxFinite, height: 200),


                                         )
                                ),

                                Center(
                                  child: Text(
                                    "Usage policy",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),


                                  ),
                                )

                              ] ,
                            ),
                          ),
                        ),



                      ],
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


class HomeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    var path = Path();
    path.moveTo(0, 33.8629);
    path.cubicTo(2.91896, 25.5254, 7.17122, 24.2713, 86.5569, 0.858575);
    path.cubicTo(88.4549, 0.2988, 90.4764, 0.314737, 92.3654, 0.904371);
    path.cubicTo(171.156, 25.4985, 174, 29.3656, 174, 33.7407);
    path.lineTo(174, 106);
    path.cubicTo(174, 111.523, 169.523, 116, 164, 116);
    path.lineTo(10, 116);
    path.cubicTo(4.47715, 116, 0, 111.523, 0, 106);
    path.lineTo(0, 33.8629);
    path.close();


    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

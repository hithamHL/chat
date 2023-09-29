import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicen_app/routes/routes.dart';
import 'package:medicen_app/utils/global.dart';
import 'package:medicen_app/utils/theme.dart';
import 'dart:async';

import 'package:medicen_app/view/widget/custom_text.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  AnimationController? _animationController;
  Animation<double>? _animation;
  String? name;
  bool? loginTime;

  getDataFromShared()async{

    bool? endBoard;
    bool? endlogin;
    // final prefs = await SharedPreferences.getInstance();
    // name = prefs.getString("user_name");
    endBoard= sharedPreferences!.getBool("End_Boarding");
    // endlogin= prefs.getBool("is_login");


    if(endBoard==true){
      Timer(Duration(seconds: 3),()=>Get.offAndToNamed(Routes.typeLoginScreen));

    }else{
      Timer(Duration(seconds: 3),()=>Get.offAndToNamed(Routes.onBoardingScreen));

    }

    // if(endBoard==true){
    //   if(endlogin==null||endlogin==false ){
    //     Timer(Duration(seconds: 3),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>LoginScreen())));
    //   }else{
    //     Timer(Duration(seconds: 3),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>MainScreen())));
    //   }
    // }else{
    //   Timer(Duration(seconds: 3),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>OnBoardScreen())));
    // }


  }



  @override
  void initState() {
    getDataFromShared();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController!);
    _animationController!.forward();
    // Future.delayed(Duration(seconds: 3,),(){
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (context) => OnBoardScreen(),)
    //     ,);
    // },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animationController!,
            builder: (BuildContext context, Widget? child) {
              return Center(
                  child: Transform.scale(
                    scale: _animation!.value,
                    child: Padding(padding: EdgeInsets.only(left: 80,right: 80),
                        child: Container(
                          width: 2000,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: AssetImage('images/logo2.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                    ),
                  )
              );

            },

          ),
          Text("PharmaCare\nHealth care",style: TextStyle(
            color: mainColor,
            letterSpacing: 2,
            fontSize: 24,

            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          ),

        ],
      )
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();

  }
}

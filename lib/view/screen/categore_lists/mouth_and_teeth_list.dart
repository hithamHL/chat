import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medicen_app/utils/theme.dart';

class MouthAndTeethList extends StatefulWidget {
  const MouthAndTeethList({Key? key}) : super(key: key);

  @override
  State<MouthAndTeethList> createState() => _MouthAndTeethListState();
}

class _MouthAndTeethListState extends State<MouthAndTeethList> {

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
      child:

      AnnotatedRegion<SystemUiOverlayStyle>(
        value:SystemUiOverlayStyle.dark,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor2,
            leading: IconButton(icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.black,
              size: 20,
            ), onPressed: () {
              Get.back();
            },),
            title: Row(
              children: [
                Image.asset("images/f4.png"),
                SizedBox(width: 5,),
                Text("Mouth And Teeth List",style: TextStyle(color: Colors.black,fontSize: 16),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

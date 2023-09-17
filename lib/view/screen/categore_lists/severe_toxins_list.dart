import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medicen_app/utils/theme.dart';

class SevereToxinsList extends StatefulWidget {
  const SevereToxinsList({Key? key}) : super(key: key);

  @override
  State<SevereToxinsList> createState() => _SevereToxinsListState();
}

class _SevereToxinsListState extends State<SevereToxinsList> {

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
                Image.asset("images/f6.png"),
                SizedBox(width: 5,),
                Text("Severe Toxins List",style: TextStyle(color: Colors.black,fontSize: 16),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

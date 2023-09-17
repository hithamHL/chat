import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medicen_app/utils/theme.dart';

import '../../../services/json_file/all_categries.dart';

class BabyCareList extends StatefulWidget {
  const BabyCareList({Key? key}) : super(key: key);

  @override
  State<BabyCareList> createState() => _BabyCareListState();
}

class _BabyCareListState extends State<BabyCareList> {

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
                Image.asset("images/f2.png"),
                SizedBox(width: 5,),
                Text("Baby care",style: TextStyle(color: Colors.black,fontSize: 16),),
              ],
            ),
          ),

          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 items per row
                mainAxisSpacing: 10.0, // Vertical spacing between items
                crossAxisSpacing: 10.0, // Horizontal spacing between items
              ),
              itemCount: Categories().babyCategory.length,
              //  scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                var items = Categories().babyCategory[index];
                return SizedBox(
                  width: 80, // Set the desired width for each item

                  child: Container(
                    child: InkWell(
                      onTap: () {
                        if(index==0){
                          //Get.toNamed(Routes.medicineList);
                        }else if(index==1){
                         // Get.toNamed(Routes.babyCareList);
                        }else if(index==2){
                         // Get.toNamed(Routes.skinCareList);
                        }else if(index==3){
                        //  Get.toNamed(Routes.mouthAndTeethList);
                        }else if(index==4){
                       //   Get.toNamed(Routes.nutritionalSupplementsList);
                        }else if(index==5){
                        //  Get.toNamed(Routes.severeToxinsList);
                        }else if(index==6){
                        //  Get.toNamed(Routes.mildToxinsList);
                        }

                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: mainColor2,
                            child: Image.asset(
                              items["image"],
                              width: 40,
                              height: 40,
                              fit: BoxFit.fitWidth,
                            ),
                          ),

                          Text(
                            items["text"] + "  ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        ),
      ),
    );
  }
}

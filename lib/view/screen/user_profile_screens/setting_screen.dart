import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medicen_app/routes/routes.dart';

import '../../../utils/theme.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

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
              "Setting",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4),
                  child: InkWell(
                    splashColor: scandreColor,
                    onTap: ()async{
final storage = GetStorage();
                      await ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                          type: ArtSweetAlertType.question,
                          title: "Select Language",
                          text: "Choose your preferred language:",
                          onCancel: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          cancelButtonText: "Cancel",
                          showCancelBtn: true,
                          confirmButtonText: "Ok",
                          confirmButtonColor: mainColor,
                          customColumns: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: ()async {
                                    storage.write('language', 'ar');
                                    Navigator.of(context, rootNavigator: true).pop();
                                     Fluttertoast.showToast(msg: "Will close the app in a moment...");
                                    await Future.delayed(Duration(seconds: 2));
                                    SystemNavigator.pop();

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image.asset('images/palstin.png', width: 50, height: 50), // Replace with your flag image
                                        Text('عربي', style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async{
                                    storage.write('language', 'en');
                                    Navigator.of(context, rootNavigator: true).pop();
                                    Fluttertoast.showToast(msg: "Will close the app in a moment...");
                                    await Future.delayed(Duration(seconds: 2));
                                    SystemNavigator.pop();

                                      // You can add code here to change the app's language to English.
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image.asset('images/englant.png', width: 50, height: 50), // Replace with your flag image
                                        Text('English', style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text("Change Language"),

                      leading: SvgPicture.asset("images/translation.svg"),
                    trailing: Icon(Icons.arrow_forward_ios,size: 18,),
                    ),
                  ),
                ),
                Divider(thickness: 0.5,color: Colors.grey,),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                  child: InkWell(
                    splashColor: scandreColor,
                    onTap: (){

                      Get.toNamed(Routes.changePasswordFromSetting);

                    },
                    child: ListTile(
                      title: Text("Change Password"),
                     // tileColor: mainColor2,
                      leading: SvgPicture.asset("images/ch_pass.svg"),
                      trailing: Icon(Icons.arrow_forward_ios,size: 18,),

                    ),
                  ),
                ),
                Divider(thickness: 0.5,color: Colors.grey,),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                  child: InkWell(
                    splashColor: scandreColor,
                    onTap: () async{
                      ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                            type: ArtSweetAlertType.question,
                            title: "Are you sure ?",
                            text: "If you delete your account, you will lose all of your registered information.",
                            onCancel: (){
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            cancelButtonText: "Cancel",
                            showCancelBtn: true,
                            confirmButtonText: "Ok",
                            onConfirm: (){
                              Navigator.of(context, rootNavigator: true).pop();
                              Get.toNamed(Routes.deleteAccountScreen);
                            },
                            confirmButtonColor: mainColor




                        ),
                      );


                    },
                    child: ListTile(
                      title: Text("Delete Account"),
                      //tileColor: mainColor2,
                      leading: SvgPicture.asset("images/del.svg"),
                      trailing: Icon(Icons.arrow_forward_ios,size: 18,),

                    ),
                  ),
                ),
                Divider(thickness: 0.5,color: Colors.grey,),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                  child: InkWell(
                    splashColor: scandreColor,
                    onTap: (){

                    },
                    child: ListTile(
                      title: Text("Add Account"),
                     // tileColor: mainColor2,
                      leading: SvgPicture.asset("images/add_lang.svg"),
                      trailing: Icon(Icons.arrow_forward_ios,size: 18,),

                    ),
                  ),
                ),
                Divider(thickness: 0.5,color: Colors.grey,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/theme.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

   final AppBar appBar;
   final String barTitle;
   CustomAppBar({Key? key, required  this.barTitle,required this.appBar}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: mainColor2,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.black,
          size: 20,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      title: Text(
        barTitle.tr,
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}

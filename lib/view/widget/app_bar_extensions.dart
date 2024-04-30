import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/theme.dart';

extension CustomAppBarExtensions on AppBar {
  AppBar addCustomActionButton({
    Widget? icon,
    VoidCallback? onPressed,
    required String title,
    bool isVisible = false,
  }) {

    return AppBar(
      actions: isVisible == true && icon != null && onPressed != null? [
        IconButton(
          icon: icon,
          onPressed: onPressed,
        ),
        ...?this.actions,
      ]: [],
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
        title.tr,
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomStyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  final String prefixSvgPath; // Provide the path to your SVG asset
  final TextInputType keyboardType;

  CustomStyledTextField({
    required this.controller,
    required this.hintText,
    required this.prefixSvgPath,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Color(0xFFeaeaea),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.black),

        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xffcacaca)),
          prefixIcon: prefixSvgPath==""?
          null:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SvgPicture.asset(prefixSvgPath),
          ),

          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}

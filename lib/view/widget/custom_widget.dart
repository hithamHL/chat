import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  final String text;
  final double dividerThickness;


  const CustomWidget({
    required this.text,
    this.dividerThickness = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: dividerThickness,
            color: Color(0xffACB7CA),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(text,style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black),),
        ),
        Expanded(
          child: Divider(
            thickness: dividerThickness,
            color: Color(0xffACB7CA),
          ),
        ),
      ],
    );
  }
}
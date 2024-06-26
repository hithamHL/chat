import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorDialog extends StatelessWidget
{
  final String? message;

  ErrorDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message!,textAlign: TextAlign.center,),
      actions: [
        ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child:  Center(
              child: Text("Ok".tr),
            ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        ),
      ],
    );
  }
}

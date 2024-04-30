import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key,this.message,this.imageUrl}) : super(key: key);
  final String? message;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message!,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              imageUrl!,
              height: 150,
              width: 150,
            ),
          ),
        ],
      ),
    );
  }
}

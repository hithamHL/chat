import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicen_app/routes/routes.dart';
import 'package:medicen_app/utils/theme.dart';

class ChatCardItem extends StatelessWidget {
   ChatCardItem({Key? key,required this.userName,
     required this.lastMessage, required this.chatStatus,required this.goToChat}) : super(key: key);
  String userName, lastMessage="";
  bool chatStatus=false;
  Function goToChat;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => goToChat(),
      child: Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(14),
        color: Color(0xfff8f8f8),
        child: Row(
          children: [
            Stack(
              children: [
                Icon(
                  Icons.person_2_outlined,
                  color: scandreColor,
                  size: 36,
                ),
                chatStatus == true
                    ? Positioned(
                  top: 22,
                  right: 20,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: mainColor),
                  ),
                )
                    : Container(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Text(
                    lastMessage,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

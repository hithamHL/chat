import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicen_app/utils/global.dart';
import 'package:medicen_app/utils/theme.dart';

class MessageItem extends StatelessWidget {
   MessageItem({Key? key,this.messageType,this.userUID,this.userAvatar,this.isLiked,this.onPressedLiked,this.messageContent}) : super(key: key);
  bool? isLiked=false;
  final String? userUID,userAvatar,messageContent,messageType;
  VoidCallback? onPressedLiked;

  //usertype , messageStatus, messageType ,
  //
  String? uid = sharedPreferences!.getString("uid");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: messageBody(context) ,
    );
  }
  //
  //
  Widget messageBody(context){
    return Directionality(
      textDirection: uid==userUID ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(top:8.0,bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(child: Image.network(userAvatar!),radius: 16,),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.75,
              decoration:  uid==userUID ?
              BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.all(Radius.circular(30)),) :
              const BoxDecoration(
                color: Color(0x80c7c7c7),
                borderRadius: BorderRadius.all(Radius.circular(8)),),
              child:Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    messageType == "text" ?
                    Text(messageContent!,textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white),)
                        :
                    GestureDetector(onTap: (){},child: Image.network(messageContent!)),


                   SizedBox(
                     height: 25,
                     child: Align(
                            alignment: uid==userUID ?  Alignment.bottomLeft:Alignment.bottomRight,
                            child: IconButton(
                                onPressed:() => onPressedLiked,
                                icon: isLiked == true ?
                                const Icon(Icons.favorite,color: Colors.green,) :
                                const Icon(Icons.favorite,color: Colors.white,))),
                   ),

                  ],
                )

              )
            )

          ],
        ),
      ),
    );

  }
  //
  // Widget messageImage(){
  //
  // }
  //
  // Widget messageText(){
  //
  // }


}

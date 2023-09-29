import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicen_app/view/widget/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../routes/routes.dart';
import '../../../utils/theme.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController searchText=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        barTitle: "Message",
        appBar: AppBar(),
      ),
      body: Container(
        color: Color(0xfff5F5F5),
        width: MediaQuery.of(context).size.width,
        child:  Column(
          children: [
            searchBar(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                // Build each list item using a loop
                return userItems("hitham","this is fake message",false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget emptyContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Sorry \n there are no message at the moment",textAlign: TextAlign.center,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "images/empty.png",
            height: 150,
            width: 150,
          ),


        ),
      ],
    );
  }
  // Widget getMessages(){
  //   return Container(
  //     child: StreamBuilder(
  //       stream: Firestore.instance.collection('users').limit(_limit).snapshots(),
  //       builder: (context, snapshot) {
  //         if (!snapshot.hasData) {
  //           return Center(
  //             child: CircularProgressIndicator(
  //               valueColor: AlwaysStoppedAnimation<Color>(themeColor),
  //             ),
  //           );
  //         } else {
  //           return ListView.builder(
  //             padding: EdgeInsets.all(10.0),
  //             itemBuilder: (context, index) => buildItem(context, snapshot.data.documents[index]),
  //             itemCount: snapshot.data.documents.length,
  //           );
  //         }
  //       },
  //     ),
  //   ),
  // }

Widget userItems(userName,lastMessage,chatStatus){
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.chatScreen),
      child: Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(14),
        color: Color(0xfff8f8f8),
        child: Row(
          children: [
            Stack(
              children: [
                Icon(Icons.person_2_outlined,color: scandreColor,size: 36,),
               chatStatus == true ? Positioned(
                  top: 22,
                  right: 20,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mainColor),
                  ),
                ):  Container(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName,style: TextStyle(color: Colors.black,fontSize: 18),),
                  Text(lastMessage,style: TextStyle(color: Colors.grey,fontSize: 14),),
                ],
              ),
            )
          ],
        ),
      ),
    );
}

Widget searchBar(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        textInputAction: TextInputAction.search,
        cursorColor: mainColor2,
        controller: searchText,
        decoration: InputDecoration(

          hintText: 'Search for member',
          hintStyle: TextStyle(color: Colors.grey),

          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          prefixIcon: const Icon(Icons.search, color: Colors.green,),


          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)), // Adjust the radius as needed
            borderSide: BorderSide(
              color: Colors.green, // Adjust the border color as needed
              width: 2.0, // Adjust the border width as needed
            ),
          ),



          ),
        ),

    );
}



@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchText.dispose();
  }

}

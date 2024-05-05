import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicen_app/logic/controllers/chat_controller.dart';
import 'package:medicen_app/model/chat_model.dart';
import 'package:medicen_app/routes/routes.dart';
import 'package:medicen_app/utils/constants.dart';
import 'package:medicen_app/view/screen/chat/widget/user_chat_card.dart';
import 'package:medicen_app/view/widget/empty_widget.dart';
import 'package:medicen_app/view/widget/search_bar.dart';


class DoctorChatScreen extends GetView<ChatController> {
  DoctorChatScreen({Key? key}) : super(key: key);
  final dataController = Get.put(ChatController());


  @override
  Widget build(BuildContext context) {
    final allChats=dataController.chats;
    print("is empty: ${allChats.isNotEmpty}");
    if (allChats.isNotEmpty) {
      return Column(
        children: [
          SearchBarWidget(
          onSubmit: (val) => dataController.filterItems(val),),
          ListView.builder(
              shrinkWrap: true,
              itemCount: allChats.length,
              itemBuilder: (BuildContext context, int index) {
                final _chats = allChats[index];
                print("all listtt ${allChats.length}");
                String? doctorUID=ConstantsName.chatUserUId(_chats);
                var parameters = <String, String>{
                  "chatUid": _chats.chatUID!,
                  "imageOne": _chats.memberOneAvatar!,
                  "imageTwo": _chats.memberTwoAvatar!,
                  "doctorUID": doctorUID!,
                  "userUID":   (doctorUID ==_chats.memberOneUid ? _chats.memberTwoUid : _chats.memberOneUid)!
                };
                return ChatCardItem(
                    userName: ConstantsName.chatUserName(_chats)!,
                    lastMessage: _chats.lastMessage!,
                    chatStatus: _chats.readStatus!,
                    goToChat: () {
                      print("##########>>${_chats.chatUID}");
                      return Get.toNamed(Routes.chatScreen, parameters: parameters);
                    });
              }),
        ],
      );
    } else {
      return const Center(child: EmptyWidget(message:  "Sorry \n there are no message at the moment", imageUrl:   "images/empty.png",));
    }
  }

// Widget searchBar() {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: TextField(
//       textInputAction: TextInputAction.search,
//       cursorColor: mainColor2,
//       controller: searchText,
//       onSubmitted: (value) {
//         // filterItems(value);
//       },
//       decoration: InputDecoration(
//         hintText: 'Search for member',
//         hintStyle: TextStyle(color: Colors.grey),
//         contentPadding:
//         EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//         prefixIcon: const Icon(
//           Icons.search,
//           color: Colors.green,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//           // Adjust the radius as needed
//           borderSide: BorderSide(
//             color: Colors.green, // Adjust the border color as needed
//             width: 2.0, // Adjust the border width as needed
//           ),
//         ),
//       ),
//     ),
//   );
// }
}

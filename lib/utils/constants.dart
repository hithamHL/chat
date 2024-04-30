import 'package:medicen_app/model/chat_model.dart';
import 'package:medicen_app/utils/global.dart';

class ConstantsName{

 static const  String chatDoc="chats";
 static const  String messageDoc="messages";
 static const  String usersDoc="users";
 static const  String doctor="doctor";










 static String? chatUserName(ChatModel chatModel){
  String? name= sharedPreferences?.getString("name");
  return name==chatModel.memberOneName ? chatModel.memberTwoName : chatModel.memberOneName;
 }

 static String? chatUserUId(ChatModel chatModel){
  String? name= sharedPreferences?.getString("uid");
  return name==chatModel.memberOneUid ? chatModel.memberTwoUid : chatModel.memberOneUid;
 }
}
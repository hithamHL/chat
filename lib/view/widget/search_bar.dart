import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medicen_app/logic/controllers/chat_controller.dart';
import 'package:medicen_app/utils/theme.dart';

class SearchBarWidget extends StatelessWidget {
   SearchBarWidget({Key? key,required this.onSubmit}) : super(key: key);
   final Function(String value) onSubmit;


   final dataController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        textInputAction: TextInputAction.search,
        cursorColor: mainColor2,
        onSubmitted: (value) => onSubmit(value),
        controller: dataController.controllerText,
        decoration: InputDecoration(
          hintText: 'Search for member',
          suffixIcon: IconButton(
            onPressed:() => {
              dataController.clearFilter()
            },
            icon: Icon(Icons.clear),
          ),
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.green,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            // Adjust the radius as needed
            borderSide: BorderSide(
              color: Colors.green, // Adjust the border color as needed
              width: 2.0, // Adjust the border width as needed
            ),
          ),
        ),
      ),
    );
  }
}

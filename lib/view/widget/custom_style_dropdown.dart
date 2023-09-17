import 'package:flutter/material.dart';
import 'package:medicen_app/utils/theme.dart';

class CustomStyledDropdown extends StatelessWidget {
  final String value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;

  CustomStyledDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFeaeaea),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items,
          onChanged: onChanged,
          dropdownColor: mainColor2,
          icon: Icon(
            Icons.arrow_drop_down_sharp,
            color: Colors.black,
            size: 30,
          ),
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}

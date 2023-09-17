
import 'package:flutter/material.dart';
import 'package:medicen_app/utils/theme.dart';

class FilledRadio extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  FilledRadio({
    required this.value,
    required this.onChanged,
  });

  @override
  _FilledRadioState createState() => _FilledRadioState();
}

class _FilledRadioState extends State<FilledRadio> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: 18.0,
        height: 18.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.value ? mainColor : Colors.transparent,
          border: Border.all(color: mainColor),
        ),
        child: widget.value
            ? Center(
          child: Icon(
            Icons.check,
            size: 12.0,
            color: Colors.white,
          ),
        )
            : Container(),
      ),
    );
  }
}





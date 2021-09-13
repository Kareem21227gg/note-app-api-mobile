import 'package:flutter/material.dart';
import 'package:note_app/core/sizeHelper.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  Function(String) onChanged;
  String hintText;
  String? errorText;
  double height;
  double width;
  double top;
  double right;
  CustomTextField({
    Key? key,
    required this.onChanged,
    required this.hintText,
    required this.errorText,
    required this.height,
    required this.width,
    required this.top,
    required this.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      height: height,
      width: width,
      child: TextField(
        onChanged: this.onChanged,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        decoration: InputDecoration(
          errorText: this.errorText,
          border: OutlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }
}

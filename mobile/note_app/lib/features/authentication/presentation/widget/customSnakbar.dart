import 'package:flutter/material.dart';
import 'package:note_app/core/colors.dart';

class CustomSnackBar extends SnackBar {
  final String? msg;
  CustomSnackBar({
    this.msg,
  }) : super(
          backgroundColor: groundColor,
          content: Text(
            msg ?? "",
            style: TextStyle(color: whiteColor),
          ),
        );
}

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app/core/colors.dart';

import 'package:note_app/core/sizeHelper.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  Function(String) onChanged;
  String hintText;
  String? errorText;
  double height;
  double width;
  double top;
  double left;
  double fontSize;
  SvgPicture? suffixIcon;
  void Function()? onPressSuffixIcon;
  late bool obscureText;
  CustomTextField({
    Key? key,
    required this.onChanged,
    required this.hintText,
    required this.errorText,
    required this.height,
    required this.width,
    required this.top,
    required this.left,
    required this.fontSize,
    this.onPressSuffixIcon,
    this.suffixIcon,
    obscureText,
  }) : super(key: key) {
    this.obscureText = obscureText ?? suffixIcon != null;
  }
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      height: widget.height,
      width: widget.width,
      child: TextField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: widget.obscureText,
        onChanged: this.widget.onChanged,
        style:
            TextStyle(fontSize: widget.fontSize, fontWeight: FontWeight.normal),
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
                  splashRadius: Material.defaultSplashRadius / 3,
                  icon: widget.suffixIcon!,
                  onPressed: () {
                    if (widget.onPressSuffixIcon != null) {
                      widget.onPressSuffixIcon!();
                    }
                    if (widget.suffixIcon != null) {
                      widget.suffixIcon = cobyWith(
                          widget.obscureText ? hintColor : primaryColor,
                          widget.suffixIcon!.pictureProvider
                              as ExactAssetPicture);
                    }
                    ;
                  },
                )
              : null,
          contentPadding: EdgeInsets.only(
            left: 12,
            top: widget.height * 6 / XD_SCREEN_HEIGHT,
            bottom: widget.height * 6 / XD_SCREEN_HEIGHT,
          ),
          errorText: this.widget.errorText,
          border: OutlineInputBorder(),
          hintText: widget.hintText,
        ),
      ),
    );
  }

  SvgPicture cobyWith(Color color, ExactAssetPicture pictureProvider) {
    print(color);
    return SvgPicture.asset(
      pictureProvider.assetName,
      color: color,
    );
  }
}

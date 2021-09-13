import 'package:flutter/material.dart';

const double XD_SCREEN_HEIGHT = 812;
const double XD_SCREEN_WIDTH = 375;

class SizeHelper {
  late double height;
  late double width;
  BuildContext context;
  SizeHelper(this.context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
  double getWidth(double width) {
    return width * this.width / XD_SCREEN_WIDTH;
  }

  double getHeight(double height) {
    return height * this.height / XD_SCREEN_HEIGHT;
    //-  MediaQuery.of(context).viewInsets.bottom;
  }

  double getLeft(double left) {
    return left * this.width / XD_SCREEN_WIDTH;
  }

  double getTop(double top) {
    return top * this.height / XD_SCREEN_HEIGHT;
  }

  double getTopWithKeybord(double top) {
    return top *
        (this.height - MediaQuery.of(context).viewInsets.bottom / 2) /
        XD_SCREEN_HEIGHT;
  }

  double getHeightWithKeybord(double height) {
    return height *
        (this.height - MediaQuery.of(context).viewInsets.bottom / 2) /
        XD_SCREEN_HEIGHT;
  }

  double getFontSizeWithKeybord(double size) {
    return getHeightWithKeybord(size);
  }

  double getFontSize(double size) {
    return getHeight(size);
    //  return (getHeight(size) + getWidth(size)) / 2;
  }
}

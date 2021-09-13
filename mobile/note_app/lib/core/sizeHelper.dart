import 'package:flutter/material.dart';

const double XD_SCREEN_HEIGHT = 812;
const double XD_SCREEN_WIDTH = 375;

class SizeHelper {
  late double height;
  late double width;
  SizeHelper(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
  double getWidth(double width) {
    return width * this.width / XD_SCREEN_WIDTH;
  }

  double getHeight(double height) {
    return height * this.height / XD_SCREEN_HEIGHT;
  }

  double getRight(double right) {
    return right * this.width / XD_SCREEN_WIDTH;
  }

  double getTop(double top) {
    return top * this.height / XD_SCREEN_HEIGHT;
  }
}

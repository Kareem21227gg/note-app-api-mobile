import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:note_app/core/sizeHelper.dart';
import 'package:note_app/features/authentication/presentation/widget/customTextField.dart';

class SingPage extends StatefulWidget {
  SingPage({Key? key}) : super(key: key);

  @override
  _SingPageState createState() => _SingPageState();
}

class _SingPageState extends State<SingPage> {
  @override
  Widget build(BuildContext context) {
    SizeHelper sh = SizeHelper(context);
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned(
              right: sh.getRight(87.93),
              top: sh.getTop(121.83),
              child: Image.asset(
                "assets/sing_icon.png",
                width: sh.getWidth(203.92),
                height: sh.getHeight(191.5),
              ),
            ),
            Positioned(
              right: sh.getRight(38),
              top: sh.getTop(646),
              child: Image.asset(
                "assets/sing_icon.png",
                width: sh.getWidth(300),
                height: sh.getHeight(52),
              ),
            ),
            CustomTextField(
              errorText: null,
              hintText: "Email Address",
              onChanged: (str) {},
              top: sh.getTop(466),
              right: sh.getRight(38),
              height: sh.getHeight(52),
              width: sh.getWidth(300),
            ),
            CustomTextField(
              errorText: null,
              hintText: "Password",
              onChanged: (str) {},
              top: sh.getTop(531),
              right: sh.getRight(38),
              height: sh.getHeight(52),
              width: sh.getWidth(300),
            ),
          ],
        ),
      ),
    );
  }
}

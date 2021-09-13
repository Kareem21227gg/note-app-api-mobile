import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app/core/colors.dart';
import 'package:note_app/core/sizeHelper.dart';
import 'package:note_app/features/authentication/presentation/page/singPage.dart';
import 'package:note_app/features/authentication/presentation/widget/customTextField.dart';

class SingUp extends StatefulWidget {
  SizeHelper sh;
  SingUp({
    Key? key,
    required this.sh,
  }) : super(key: key);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  Widget build(BuildContext context) {
    SizeHelper sh = widget.sh;
    return Center(
      child: Stack(
        children: [
          Positioned(
            left: sh.getLeft(87.93),
            top: sh.getTopWithKeybord(121.83),
            child: Image.asset(
              "assets/sing_icon.png",
              width: sh.getWidth(203.92),
              height: sh.getHeight(191.5),
            ),
          ),
          Positioned(
            left: sh.getLeft(38),
            top: sh.getTop(646),
            width: sh.getWidth(300),
            height: sh.getHeight(52),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Create Account",
                style: TextStyle(
                    color: whiteColor,
                    fontSize: sh.getFontSize(16),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            top: sh.getTop(749),
            left: sh.getLeft(90),
            child: Wrap(
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(
                    color: blackColor,
                    fontSize: sh.getFontSize(12),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => SingPage(
                          index: 0,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Login now',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: sh.getFontSize(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomTextField(
            fontSize: sh.getFontSize(14),
            errorText: null,
            hintText: "Name",
            onChanged: (str) {},
            top: sh.getTopWithKeybord(451),
            left: sh.getLeft(38),
            height: sh.getHeightWithKeybord(52),
            width: sh.getWidth(300),
          ),
          CustomTextField(
            fontSize: sh.getFontSize(14),
            errorText: null,
            hintText: "Email Address",
            onChanged: (str) {},
            top: sh.getTopWithKeybord(517),
            left: sh.getLeft(38),
            height: sh.getHeightWithKeybord(52),
            width: sh.getWidth(300),
          ),
          CustomTextField(
            suffixIcon: SvgPicture.asset(
              "assets/svg.svg",
              color: hintColor,
            ),
            fontSize: sh.getFontSize(14),
            errorText: null,
            hintText: "Password",
            onChanged: (str) {},
            top: sh.getTopWithKeybord(583),
            left: sh.getLeft(38),
            height: sh.getHeightWithKeybord(52),
            width: sh.getWidth(300),
          ),
        ],
      ),
    );
  }
}

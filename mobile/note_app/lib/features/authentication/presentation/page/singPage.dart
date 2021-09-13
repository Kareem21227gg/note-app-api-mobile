import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app/core/colors.dart';
import 'package:note_app/core/sizeHelper.dart';
import 'package:note_app/features/authentication/presentation/page/singin.dart';
import 'package:note_app/features/authentication/presentation/page/singup.dart';
import 'package:note_app/features/authentication/presentation/widget/customTextField.dart';

// ignore: must_be_immutable
class SingPage extends StatefulWidget {
  SingPage({
    Key? key,
  }) : super(key: key);

  @override
  _SingPageState createState() => _SingPageState();
}

class _SingPageState extends State<SingPage> {
  bool singin = true;
  late SizeHelper sh;
  late List<Widget> pages;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sh = SizeHelper(context);
    pages = [
      SingIn(
        sh: sh,
      ),
      SingUp(
        sh: sh,
      )
    ];
    return Scaffold(
      body: Stack(
        children: [
          pages[singin ? 0 : 1],
          Positioned(
            height: sh.getHeightWithKeybord(90),
            left: sh.getLeft(20),
            right: sh.getLeft(20),
            top: sh.getTopWithKeybord(337),
            child: BottomNavigationBar(
              elevation: 0,
              currentIndex: singin ? 0 : 1,
              onTap: (x) {
                setState(() {
                  singin = ((singin ? 0 : 1) == x) ? singin : !singin;
                });
              },
              items: [
                BottomNavigationBarItem(
                  label: "",
                  icon: Text(
                    "Signin",
                    style: TextStyle(
                      color: singin ? primaryColor : hintColor,
                      fontSize: sh.getFontSizeWithKeybord(40),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "",
                  icon: Text(
                    "Signup",
                    style: TextStyle(
                      color: !singin ? primaryColor : hintColor,
                      fontSize: sh.getFontSizeWithKeybord(40),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

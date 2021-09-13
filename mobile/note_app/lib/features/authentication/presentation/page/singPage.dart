import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app/core/colors.dart';
import 'package:note_app/core/sizeHelper.dart';
import 'package:note_app/features/authentication/presentation/page/singin.dart';
import 'package:note_app/features/authentication/presentation/page/singup.dart';
import 'package:note_app/features/authentication/presentation/widget/customTextField.dart';

// ignore: must_be_immutable
class SingPage extends StatefulWidget {
  int? index;
  SingPage({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  _SingPageState createState() => _SingPageState();
}

class _SingPageState extends State<SingPage> {
  int? index;
  late SizeHelper sh;
  late List<Widget> pages;
  @override
  void initState() {
    super.initState();
    index = widget.index ?? 0;
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
          Positioned(
            height: sh.getHeightWithKeybord(90),
            left: sh.getLeft(20),
            right: sh.getLeft(20),
            top: sh.getTopWithKeybord(337),
            child: BottomNavigationBar(
              elevation: 0,
              currentIndex: index!,
              onTap: (x) {
                setState(() {
                  index = x;
                });
              },
              items: [
                BottomNavigationBarItem(
                  label: "",
                  icon: Text(
                    "Signin",
                    style: TextStyle(
                      color: index == 0 ? primaryColor : hintColor,
                      fontSize: sh.getFontSizeWithKeybord(40),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "",
                  icon: Text(
                    "Signup",
                    style: TextStyle(
                      color: index == 1 ? primaryColor : hintColor,
                      fontSize: sh.getFontSizeWithKeybord(40),
                    ),
                  ),
                ),
              ],
            ),
          ),
          pages[index!],
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: index,
      //   onTap: (x) {
      //     setState(() {
      //       index = x;
      //     });
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       label: "Sign in",
      //       icon: Text(
      //         "Signin",
      //         style: TextStyle(fontSize: sh.getFontSizeWithKeybord(60)),
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       label: "Sign up",
      //       icon: Text(
      //         "Signup",
      //         style: TextStyle(fontSize: sh.getFontSizeWithKeybord(60)),
      //       ),
      //     ),
      //   ],
      // ),
      // body: pages[index],
    );
  }
}

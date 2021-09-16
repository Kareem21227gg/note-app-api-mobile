import 'package:flutter/material.dart';
import 'package:note_app/core/colors.dart';
import 'package:note_app/core/sizeHelper.dart';
import 'package:note_app/features/note/presentation/widget/noteWidget.dart';

class NotePage extends StatefulWidget {
  NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeHelper sh = SizeHelper(context);
    List<String> list = [
      "sssssssssssss ssssssssss s s sssssdddddddddddd d ddddd         dddd sss",
      "dddddddddddd ",
      "",
      "sssssssssssss ssssssssss s s sssssdddddddddddd d ddddd         dddd sss",
      "dddddddddddd ",
      "",
      "sssssssssssss ssssssssss s s sssssdddddddddddd d ddddd         dddd sss",
      "dddddddddddd ",
      "",
      "sssssssssssss ssssssssss s s sssssdddddddddddd d ddddd         dddd sss",
      "dddddddddddd ",
      "",
      "sssssssssssss ssssssssss s s sssssdddddddddddd d ddddd         dddd sss",
      "dddddddddddd ",
      "",
      "sssssssssssss ssssssssss s s sssssdddddddddddd d ddddd         dddd sss",
      "dddddddddddd ",
      "",
    ];
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: sh.getLeft(173),
            top: sh.getTopWithKeybord(10.16),
            child: Image.asset(
              "assets/Group 136.png",
              width: sh.getWidth(190.52),
              height: sh.getHeight(213.8),
            ),
          ),
          Positioned(
            top: sh.getTop(21),
            height: sh.getHeight(600),
            width: sh.width,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  top: sh.getHeight(20),
                  left: sh.getWidth(20),
                  right: sh.getWidth(20),
                ),
                child: Container(
                  child: NoteWidget(
                    onpress: () {},
                    sh: sh,
                    text: list[index],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: sh.getLeft(0),
            top: sh.getTopapoveKeyBord(621),
            height: sh.getHeight(204),
            width: sh.getWidth(375),
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(
                  0.24,
                ),
              ),
            ),
          ),
          Positioned(
            left: sh.getLeft(17),
            top: sh.getTopapoveKeyBord(631),
            width: sh.getWidth(338),
            height: sh.getHeight(101),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                fillColor: whiteColor,
                filled: true,
                hintText: "Note...",
                border: OutlineInputBorder(
                  gapPadding: sh.getHeight(4.0),
                ),
              ),
              expands: true,
              maxLines: null,
              minLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ),
          Positioned(
            left: sh.getLeft(38),
            top: sh.getTopapoveKeyBord(740),
            width: sh.getWidth(300),
            height: sh.getHeight(52),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Add Note",
                style: TextStyle(
                    color: whiteColor,
                    fontSize: sh.getFontSize(20),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

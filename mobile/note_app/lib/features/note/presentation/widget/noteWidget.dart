import 'package:flutter/material.dart';
import 'package:note_app/core/colors.dart';
import 'package:note_app/core/sizeHelper.dart';

class NoteWidget extends StatelessWidget {
  final SizeHelper sh;
  final String text;
  final void Function() onpress;
  const NoteWidget({
    Key? key,
    required this.sh,
    required this.text,
    required this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sh.getWidth(18)),
      width: sh.getWidth(335),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: primaryColor.withOpacity(0.17),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: sh.getsizeHeighSmart(26),
              ),
            ),
          ),
          IconButton(
            splashRadius: sh.getsizeHeighSmart(28),
            iconSize: sh.getsizeHeighSmart(28),
            onPressed: onpress,
            icon: Icon(
              Icons.remove_circle_outline,
              color: groundColor,
            ),
          ),
        ],
      ),
    );
  }
}

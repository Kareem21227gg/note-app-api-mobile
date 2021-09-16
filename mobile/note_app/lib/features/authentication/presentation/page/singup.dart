import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app/core/colors.dart';
import 'package:note_app/core/sizeHelper.dart';
import 'package:note_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:note_app/features/authentication/presentation/page/singPage.dart';
import 'package:note_app/features/authentication/presentation/widget/customTextField.dart';

class SingUp extends StatefulWidget {
  AuthBloc bloc;
  Key? key;
  SizeHelper sh;
  SingUp({
    this.key,
    required this.bloc,
    required this.sh,
  }) : super(key: key);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: widget.sh.getLeft(87.93),
          top: widget.sh.getTopWithKeybord(121.83),
          child: Image.asset(
            "assets/sing_icon.png",
            width: widget.sh.getWidth(203.92),
            height: widget.sh.getHeight(191.5),
          ),
        ),
        Positioned(
          left: widget.sh.getLeft(38),
          top: widget.sh.getTop(646),
          width: widget.sh.getWidth(300),
          height: widget.sh.getHeight(52),
          child: ElevatedButton(
            onPressed: () {
              widget.bloc.submit();
            },
            child: Text(
              "Create Account",
              style: TextStyle(
                  color: whiteColor,
                  fontSize: widget.sh.getFontSize(16),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: widget.sh.getTop(749),
          left: widget.sh.getLeft(90),
          child: Wrap(
            children: [
              Text(
                'Already have an account? ',
                style: TextStyle(
                  color: blackColor,
                  fontSize: widget.sh.getFontSize(12),
                ),
              ),
              InkWell(
                onTap: () {
                  widget.bloc.setPage(0);
                },
                child: Text(
                  'Login now',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: widget.sh.getFontSize(12),
                  ),
                ),
              ),
            ],
          ),
        ),
        CustomTextField(
          fontSize: widget.sh.getFontSize(14),
          errorText: widget.bloc.state.nameError,
          hintText: "Name",
          onChanged: (str) {
            widget.bloc.setName(str);
          },
          top: widget.sh.getTopWithKeybord(451),
          left: widget.sh.getLeft(38),
          height: widget.sh.getHeightWithKeybord(52),
          width: widget.sh.getWidth(300),
        ),
        CustomTextField(
          fontSize: widget.sh.getFontSize(14),
          errorText: widget.bloc.state.emailError,
          hintText: "Email Address",
          onChanged: (str) {
            widget.bloc.steEmail(str);
          },
          top: widget.sh.getTopWithKeybord(517),
          left: widget.sh.getLeft(38),
          height: widget.sh.getHeightWithKeybord(52),
          width: widget.sh.getWidth(300),
        ),
        CustomTextField(
          onPressSuffixIcon: () => widget.bloc
              .setPasswordVisible(!widget.bloc.state.passwordVisible!),
          obscureText: !widget.bloc.state.passwordVisible!,
          suffixIcon: SvgPicture.asset(
            "assets/svg.svg",
            color: hintColor,
          ),
          fontSize: widget.sh.getFontSize(14),
          errorText: widget.bloc.state.passwordError,
          hintText: "Password",
          onChanged: (str) {
            widget.bloc.setPassword(str);
          },
          top: widget.sh.getTopWithKeybord(583),
          left: widget.sh.getLeft(38),
          height: widget.sh.getHeightWithKeybord(52),
          width: widget.sh.getWidth(300),
        ),
      ],
    );
  }
}

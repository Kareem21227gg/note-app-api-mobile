import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:note_app/core/colors.dart';
import 'package:note_app/core/sizeHelper.dart';
import 'package:note_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:note_app/features/authentication/presentation/page/singin.dart';
import 'package:note_app/features/authentication/presentation/page/singup.dart';

import '../../../../init.dart';

// ignore: must_be_immutable
class SingPage extends StatefulWidget {
  SingPage({
    Key? key,
  }) : super(key: key);

  @override
  _SingPageState createState() => _SingPageState();
}

class _SingPageState extends State<SingPage> {
  AuthBloc bloc = sl<AuthBloc>();
  late SizeHelper sh;
  late List<Widget> pages;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sh = SizeHelper(context);
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        bloc: bloc,
        builder: (context, state) {
          bloc.setContext(context);
          pages = [
            SingIn(
              bloc: bloc,
              sh: sh,
            ),
            SingUp(
              bloc: bloc,
              sh: sh,
            ),
          ];

          return Stack(
            children: [
              pages[state.page],
              Positioned(
                height: sh.getHeightWithKeybord(90),
                left: sh.getLeft(20),
                right: sh.getLeft(20),
                top: sh.getTopWithKeybord(337),
                child: BottomNavigationBar(
                  elevation: 0,
                  currentIndex: state.page,
                  onTap: (x) {
                    bloc.setPage(x);
                  },
                  items: [
                    BottomNavigationBarItem(
                      label: "",
                      icon: Text(
                        "Signin",
                        style: TextStyle(
                          color: state.page == 0 ? primaryColor : hintColor,
                          fontSize: sh.getFontSizeWithKeybord(40),
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "",
                      icon: Text(
                        "Signup",
                        style: TextStyle(
                          color: state.page == 1 ? primaryColor : hintColor,
                          fontSize: sh.getFontSizeWithKeybord(40),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

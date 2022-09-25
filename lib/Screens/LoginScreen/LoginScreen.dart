import 'dart:ui';
import 'package:fbissalama/Widgets/Login/background.dart';
import 'package:fbissalama/Widgets/Login/behavior.dart';
import 'package:fbissalama/Widgets/Login/glasslogin.dart';
import 'package:fbissalama/utilities/assets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Background(),
                Center(
                  child: Column(
                    children: [
                      GlassLogin(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

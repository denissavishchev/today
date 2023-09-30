import 'dart:ui';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg04.png'),
                fit: BoxFit.fitWidth)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 0.1,
            sigmaY: 0.1,
          ),
          child: Container(),
        ),
      ),
    );
  }
}
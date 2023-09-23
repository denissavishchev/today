import 'package:flutter/material.dart';
import '../constants.dart';

class DailyPage extends StatelessWidget {
  const DailyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPurple.withOpacity(0.3),

    );
  }
}
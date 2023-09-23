import 'package:flutter/material.dart';

import '../constants.dart';

class HabbitPage extends StatelessWidget {
  const HabbitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kGreen.withOpacity(0.3),

    );
  }
}
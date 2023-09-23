import 'package:flutter/material.dart';

import '../constants.dart';

class FadeContainerWidget extends StatelessWidget {
  const FadeContainerWidget({Key? key,
    required this.child,
    this.height = 0.08}) : super(key: key);

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: size.width * 0.05),
      height: size.height * height,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(
              colors: [
                kOrange.withOpacity(0.3),
                Colors.transparent
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: const [0.1, 0.8]
          )
      ),
      child: child,
    );
  }
}

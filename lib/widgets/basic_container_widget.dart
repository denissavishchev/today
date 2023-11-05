import 'package:flutter/material.dart';
import '../constants.dart';
import 'glass_morph_widget.dart';


class BasicContainerWidget extends StatelessWidget {
  const BasicContainerWidget({super.key,
    required this.height,
    required this.child,
    this.width = 1,
    this.color = kOrange,});

  final double height;
  final double width;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.fromLTRB(4, 0, 4, 8),
      padding: const EdgeInsets.all(2),
      width: size.width * width,
      height: size.height * height,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: GlassMorphWidget(
        color: color,
        child: child,)
    );
  }
}
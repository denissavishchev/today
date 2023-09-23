import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphWidget extends StatelessWidget {
  const GlassMorphWidget({Key? key,
    required this.child,
    this.opacity = 0.4,
    this.opacityL = 0.23,
    this.opacityR = 0.15,
    required this.color
  }) : super(key: key);

  final Widget child;
  final double opacity;
  final double opacityL;
  final double opacityR;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4,
              sigmaY: 4,
            ),
            child: Container(),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              border: Border.all(
                color: Colors.white.withOpacity(opacity),
              ),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withOpacity(opacityL),
                    color.withOpacity(opacityR),
                  ]),
            ),
          ),
          Center(
            child: child,
          ),
        ],
      ),
    );
  }
}

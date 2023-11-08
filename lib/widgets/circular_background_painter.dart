import 'package:flutter/material.dart';
import 'package:today/constants.dart';

class CircularBackgroundPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var colors = Offset.zero & size;
    final center = Offset(size.width / 2, size.height / 2);
    final centerDark = Offset(size.width / 2, size.height / 2 + 2);
    final centerLight = Offset(size.width / 2, size.height / 2 -1);

    var paintLightShadow = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xff5e5e5c),
          Color(0xff5e5e5c),
        ],
      ).createShader(colors)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.5)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    canvas.drawCircle(centerLight, 118, paintLightShadow);

    var paintDarkShadow = Paint()
      ..shader = const LinearGradient(
        colors: [
          Colors.black,
          Colors.black,
        ],
      ).createShader(colors)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.5)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    canvas.drawCircle(centerDark, 118, paintDarkShadow);

    var paintBackground = Paint()
    ..color = const Color(0xff91918f)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 20;

    canvas.drawCircle(center, 118, paintBackground);

    var paintBorder = Paint()
      ..color = kOrange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, 128, paintBorder);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
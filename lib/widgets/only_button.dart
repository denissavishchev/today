import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class OnlyButton extends StatelessWidget {
  const OnlyButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  final Function() onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius:
          const BorderRadius.all(Radius.circular(30)),
          gradient: LinearGradient(
              colors: [
                const Color(0xffbebebc).withOpacity(0.5),
                const Color(0xff1a1a18).withOpacity(0.8),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0, 0.75]),
        ),
        child: Center(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: const Color(0xff91918f),
                  border:
                  Border.all(color: kOrange, width: 0.5),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(25)),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 3,
                        offset: Offset(0, 2)),
                    BoxShadow(
                        color: Color(0xff5e5e5c),
                        blurRadius: 1,
                        offset: Offset(0, -1)),
                  ]),
              child: SvgPicture.asset(icon,
                  colorFilter: ColorFilter.mode(
                      kOrange.withOpacity(0.7),
                      BlendMode.srcIn)
              ),
            ),
          ),
        ));
  }
}
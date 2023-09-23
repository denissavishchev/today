import 'package:flutter/material.dart';
import '../constants.dart';

class SideButtonWidget extends StatelessWidget {
  const SideButtonWidget({
    super.key,
    this.right = true,
    required this.child,
    this.width = 80,
    required this.onTap,
  });

  final bool right;
  final Widget child;
  final double width;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 65,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: right
                ? const BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30))
                : const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 3,
                  offset: const Offset(0, 2)
              ),
            ]
        ),
        child: Row(
          children: [
            right ? const Spacer() : const SizedBox(width: 5,),
            Center(
              child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    gradient: LinearGradient(
                        colors: [
                          const Color(0xffbebebc).withOpacity(0.5),
                          const Color(0xff1a1a18).withOpacity(0.8),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const [0, 0.75]
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          color: const Color(0xff91918f),
                          border: Border.all(
                              color: kOrange,
                              width: 0.5),
                          borderRadius: const BorderRadius.all(Radius.circular(25)),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 3,
                                offset: Offset(0, 2)
                            ),
                            BoxShadow(
                                color: Color(0xff5e5e5c),
                                blurRadius: 1,
                                offset: Offset(0, -1)
                            ),
                          ]
                      ),
                      child: child,
                    ),
                  )
              ),
            ),
            right ? const SizedBox(width: 5,) : const Spacer()
          ],
        ),
      ),
    );
  }
}
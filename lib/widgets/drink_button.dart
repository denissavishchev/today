import 'package:flutter/material.dart';
import '../constants.dart';

class DrinkButton extends StatelessWidget {
  const DrinkButton({
    super.key,
    required this.onTap,
    required this.quantity,
    required this.onLongPress,
  });

  final Function() onTap;
  final Function() onLongPress;
  final String quantity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Container(
        width: 120,
        height: 60,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color(0xffbebebc).withOpacity(0.5),
                  const Color(0xff1a1a18).withOpacity(0.8),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0, 0.75]
            ),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 3,
                  offset: const Offset(0, 2)
              ),
            ]
        ),
        child: Center(
          child: Container(
              width: 112,
              height: 50,
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
                  width: 144,
                  height: 60,
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
                  child: Center(child: Text(quantity, style: kOrangeStyle)),
                ),
              )
          ),
        ),
        ),
      );
  }
}

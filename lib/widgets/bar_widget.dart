import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:countup/countup.dart';

class BarWidget extends StatefulWidget {

  final int day;
  final int percent;
  final Color color;


  const BarWidget({
    Key? key, required this.day, required this.percent, required this.color,
  }) : super(key: key);

  @override
  State<BarWidget> createState() => _AbilitiesState();
}

class _AbilitiesState extends State<BarWidget> with SingleTickerProviderStateMixin{

  final duration = 1000;
  late AnimationController _animationAbilitiesController;
  late Animation<double> _animationAbilities;

  void setupAbilitiesAnimation() {
    _animationAbilitiesController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration),);
    _animationAbilities = CurvedAnimation(
        parent: _animationAbilitiesController,
        curve: const Interval(0.0, 1.0));
  }

  @override
  void initState() {
    setupAbilitiesAnimation();
    _animationAbilitiesController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationAbilitiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([_animationAbilitiesController]),
        builder: (context, _) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.day.toString(), style: const TextStyle(color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),),
                  Container(
                    width: 300,
                    height: 10,
                    color: Colors.transparent,
                    child: LinearPercentIndicator(
                      barRadius: const Radius.circular(10),
                      lineHeight: 16,
                      percent: (widget.percent / 100) * _animationAbilities.value,
                      progressColor: widget.color,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  Countup(begin: 0, end: widget.percent.toDouble(),
                    duration: Duration(milliseconds: duration),
                    style: const TextStyle(color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          );
        });
  }
}
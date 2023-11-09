import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today/providers/water_provider.dart';

import '../constants.dart';
import '../widgets/circular_background_painter.dart';

class WaterPage extends StatelessWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<WaterProvider>(
        builder: (context, data, _){
          return Container(
            height: size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg04.png'),
                    fit: BoxFit.fitWidth)),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 0.1,
                sigmaY: 0.1,
              ),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.08,),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.4,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            width: 276,
                            height: 276,
                            decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(140)),
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
                              child: CustomPaint(
                                painter: CircularBackgroundPainter(),
                              ),
                            )),
                        SizedBox(
                          width: 235,
                          height: 235,
                          child: CircularProgressIndicator(
                            value: data.percent / 100,
                            backgroundColor: kOrange.withOpacity(0.2),
                            strokeWidth: 20,
                            color: kOrange,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${data.percent.toStringAsFixed(0)}%', style: kOrangeStyle.copyWith(fontSize: 42),),
                            Text('${data.water}/3000', style: kOrangeStyle.copyWith(fontSize: 38),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.08,),
                  ElevatedButton(
                      onPressed: () => data.addWater(),
                      child: Text('Drink 100ml'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:today/providers/water_provider.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../model/water_model.dart';
import '../widgets/circular_background_painter.dart';
import '../widgets/drink_button.dart';
import '../widgets/settings_button.dart';
import '../widgets/side_button_widget.dart';

class WaterPage extends StatelessWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<WaterProvider>(
        builder: (context, data, _){
          return ValueListenableBuilder(
              valueListenable: Boxes.addWaterSettingsToBase().listenable(),
              builder: (context, box, _){
                final settings = box.values.toList().cast<WaterSettingsModel>();
                data.target = settings.isEmpty ? 0 : settings[0].target;
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
                        SizedBox(height: size.height * 0.07),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SideButtonWidget(
                              onTap: () {},
                              // Navigator.pushReplacement(context,
                              //     MaterialPageRoute(builder: (context) =>
                              //     const HabitStatisticPage())),
                              child: Icon(Icons.history_edu,
                                color: kOrange.withOpacity(0.7),
                                size: 40,),),
                            const Spacer(),
                            const Padding(
                              padding: EdgeInsets.only(right: 18.0),
                              child: SettingsButton(),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02,),
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
                                  Text('${data.water}/${data.target}', style: kOrangeStyle.copyWith(fontSize: 38),),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.08,),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DrinkButton(
                                  onTap: () => data.addWater(500),
                                  quantity: '500 ml',
                                ),
                                DrinkButton(
                                  onTap: () => data.addWater(400),
                                  quantity: '400 ml',
                                ),
                                DrinkButton(
                                  onTap: () => data.addWater(300),
                                  quantity: '300 ml',
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            DrinkButton(
                                onTap: () => data.selectQuantity(context),
                                quantity: 'Custom'),

                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}


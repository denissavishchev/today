import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/to_do_provider.dart';
import '../widgets/side_button_widget.dart';
import 'main_page.dart';
import 'package:fl_chart/fl_chart.dart';

class DailyStatisticPage extends StatelessWidget {
  const DailyStatisticPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: Consumer<ToDoProvider>(
            builder: (context, data, _) {
              return ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Container(
                    height: size.height,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/bg02.png'),
                            fit: BoxFit.cover)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 0.1,
                        sigmaY: 0.1,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.07),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SideButtonWidget(
                                  onTap: (){
                                    activePage = 1;
                                    mainPageController.initialPage = 1;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const MainPage()));
                                  },
                                  child: Icon(Icons.arrow_back,
                                    color: kOrange.withOpacity(0.7),
                                    size: 40,),),
                                const Spacer(),
                              ],
                            ),
                            SizedBox(height: size.height * 0.06,),
                            Container(
                              margin: const EdgeInsets.only(right: 12),
                              width: size.width,
                              height: 300,
                              child: LineChart(
                                LineChartData(
                                    minY: 0,
                                    maxY: 100,
                                    minX: 1,
                                    maxX: 30,
                                    borderData: FlBorderData(
                                      show: false
                                    ),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      rightTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false
                                        )
                                      ),
                                      topTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                              showTitles: false
                                          )
                                      ),
                                      leftTitles: AxisTitles(

                                          sideTitles: SideTitles(
                                              showTitles: true,
                                          )
                                      ),
                                    ),
                                    gridData: FlGridData(
                                      show: false
                                    ),
                                    lineBarsData: [
                                      LineChartBarData(
                                        isCurved: true,
                                          color: kOrange,
                                          barWidth: 3,
                                          belowBarData: BarAreaData(
                                            show: true,
                                            gradient: LinearGradient(
                                              colors: [
                                                kOrange,
                                                kOrange.withOpacity(0.0)
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter
                                            )
                                          ),
                                          spots: [
                                            FlSpot(1, 33),
                                            FlSpot(2, 55),
                                            FlSpot(3, 47),
                                            FlSpot(4, 12),
                                            FlSpot(5, 84),
                                            FlSpot(6, 36),
                                            FlSpot(7, 27),
                                            FlSpot(8, 64),
                                            FlSpot(9, 48),
                                            FlSpot(10, 99),
                                            FlSpot(11, 37),
                                            FlSpot(12, 98),
                                            FlSpot(13, 34),
                                            FlSpot(14, 56),
                                            FlSpot(15, 81),
                                            FlSpot(16, 31),
                                            FlSpot(17, 12),
                                            FlSpot(18, 54),
                                            FlSpot(19, 23),
                                            FlSpot(20, 65),
                                            FlSpot(21, 34),
                                            FlSpot(22, 98),
                                            FlSpot(23, 65),
                                            FlSpot(24, 34),
                                            FlSpot(25, 21),
                                            FlSpot(26, 12),
                                            FlSpot(27, 6),
                                            FlSpot(28, 45),
                                            FlSpot(29, 42),
                                            FlSpot(30, 11),
                                          ]
                                      )
                                    ]
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}





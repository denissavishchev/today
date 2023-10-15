import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today/providers/daily_provider.dart';
import '../constants.dart';

class DailyChartWidget extends StatelessWidget {
  const DailyChartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<int> chartValues = [33, 55, 47, 99, 45, 76, 35, 48, 95, 12, 54, 81, 8, 23, 37, 88, 34, 75];
    List<int> chartDays = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18];
    return Consumer<DailyProvider>(
        builder: (context, data, child){
          return Container(
            margin: const EdgeInsets.only(right: 18, left: 12),
            width: size.width,
            height: 300,
            child: LineChart(
              LineChartData(
                  minY: 0,
                  maxY: 100,
                  minX: 1,
                  maxX: chartValues.length.toDouble(),
                  borderData: FlBorderData(
                      show: false
                  ),
                  titlesData: const FlTitlesData(
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
                          getTitlesWidget: leftTitles,
                          reservedSize: 44,
                        )
                    ),
                    bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: bottomTitles,
                        )
                    ),
                  ),
                  gridData: const FlGridData(
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
                        spots: List.generate(chartValues.length, (index) {
                          return FlSpot(
                              chartDays[index].toDouble(),
                              chartValues[index].toDouble());
                        }),
                        // spots: chartValues.asMap().entries.map((e) {
                        //   return FlSpot((e.key + 1).toDouble(), e.value.toDouble());
                        // }).toList(),
                    )
                  ]
              ),
            ),
          );
        });
  }
}

Widget leftTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: kOrange,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 12,
    child: Text(value.toInt().toString(), style: style),
  );
}

Widget bottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: kWhite,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 0,
    child: Text(value.toInt().toString(), style: style),
  );
}





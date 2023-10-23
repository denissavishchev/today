import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today/providers/daily_provider.dart';
import '../constants.dart';
import '../model/percent_model.dart';

class DailyChartWidget extends StatelessWidget {
  const DailyChartWidget({
    super.key,
    required this.percents,
  });

  final List<PercentModel> percents;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<DailyProvider>(builder: (context, data, child) {
      return Container(
        margin: const EdgeInsets.only(right: 18, left: 12),
        width: size.width,
        height: 300,
        child: LineChart(
          LineChartData(
              minY: 0,
              maxY: 100,
              minX: 1,
              maxX: percents.length.toDouble(),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                  show: true,
                  rightTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: leftTitles,
                    reservedSize: 44,
                  )),
                  // bottomTitles: AxisTitles(
                  //     sideTitles: SideTitles(
                  //       showTitles: true,
                  //       getTitlesWidget: bottomTitles,
                  //     )
                  // ),
                  bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          interval: 5,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            const style = TextStyle(
                              color: kWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            );
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              space: 1,
                              child:
                                  Text(value.toInt().toString(), style: style),
                            );
                          })),
              ),
              gridData: const FlGridData(show: false),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  color: kOrange,
                  barWidth: 3,
                  belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                          colors: [kOrange, kOrange.withOpacity(0.0)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  spots: List.generate(percents.length, (index) {
                    return FlSpot(percents[index].day.toDouble(),
                        percents[index].percent.toDouble());
                  }),
                )
              ]),
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

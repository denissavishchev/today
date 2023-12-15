import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:today/constants.dart';
import '../model/percent_model.dart';

class StatisticChartWidget extends StatelessWidget {
  const StatisticChartWidget({
    super.key,
    required this.percents,
  });

  final List<PercentModel> percents;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.5,
      child: SfCartesianChart(
          enableAxisAnimation: true,
          primaryXAxis: DateTimeAxis(
            dateFormat: DateFormat('d MMM'),
            labelRotation: 90,
              // borderWidth: 1.0,
              borderColor: Colors.blue,
            majorGridLines: const MajorGridLines(width: 0,),
            // maximumLabels: 3
            placeLabelsNearAxisLine: false

          ),
          primaryYAxis: CategoryAxis(
            borderColor: kWhite,
            // tickPosition: TickPosition.inside,
              placeLabelsNearAxisLine: true,
            minimum: 0,
            maximum: 100,
            majorGridLines: const MajorGridLines(width: 0,),

          ),
          series: <CartesianSeries>[
            SplineAreaSeries<PercentModel, DateTime>(
                dataSource: percents,
                xValueMapper: (PercentModel data, _) => DateTime.parse(data.dateTime),
                yValueMapper: (PercentModel data, _) => data.percent,
                dataLabelSettings: const DataLabelSettings(
                    isVisible: true
                ),
                color: kOrange,
                gradient: LinearGradient(
                  colors: [kOrange, kWhite]
                ),
                splineType: SplineType.cardinal,
                markerSettings: MarkerSettings(
                  isVisible: true,
                  color: kWhite
                ),
                animationDuration: 1000
            )
          ]
      ),
    );
  }
}
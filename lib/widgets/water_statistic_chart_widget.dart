import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:today/constants.dart';
import 'package:today/model/water_daily_model.dart';

class WaterStatisticChartWidget extends StatelessWidget {
  const WaterStatisticChartWidget({
    super.key,
    required this.water,
  });

  final List<WaterDailyModel> water;

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
              labelStyle: TextStyle(color: kWhite),
              majorGridLines: const MajorGridLines(width: 0,),
              // maximumLabels: 3
              placeLabelsNearAxisLine: false

          ),
          primaryYAxis: CategoryAxis(
            borderColor: kWhite,
            // tickPosition: TickPosition.inside,
            labelStyle: TextStyle(color: kWhite),
            placeLabelsNearAxisLine: true,
            minimum: 0,
            maximum: 100,
            majorGridLines: const MajorGridLines(width: 0,),

          ),
          series: <CartesianSeries>[
            SplineAreaSeries<WaterDailyModel, DateTime>(
                dataSource: water,
                xValueMapper: (WaterDailyModel data, _) => DateTime.parse(data.dateTime),
                yValueMapper: (WaterDailyModel data, _) => data.percentMl,
                dataLabelSettings: const DataLabelSettings(
                    isVisible: true
                ),
                color: kOrange,
                gradient: LinearGradient(
                    colors: [kOrange, kWhite.withOpacity(0.6)],
                  stops: [0.5, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                ),
                splineType: SplineType.cardinal,
                markerSettings: MarkerSettings(
                    isVisible: true,
                    color: kOrange,
                    borderColor: kOrange
                ),
                animationDuration: 1000
            )
          ]
      ),
    );
  }
}
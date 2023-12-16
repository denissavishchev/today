import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:today/constants.dart';
import '../model/percent_model.dart';

class DailyStatisticChartWidget extends StatelessWidget {
  const DailyStatisticChartWidget({
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
            labelStyle: const TextStyle(color: kWhite),
            majorGridLines: const MajorGridLines(width: 0,),
          ),
          primaryYAxis: CategoryAxis(
            labelStyle: const TextStyle(color: kWhite),
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
                  isVisible: true,
                  textStyle: TextStyle(color: kWhite, fontWeight: FontWeight.bold),
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  borderColor: kGreen,
                  borderWidth: 1,
                  color: kOrange,
                  opacity: 0.8,
                ),
                borderColor: kGreen.withOpacity(0.5),
                borderWidth: 2,
                color: kOrange,
                gradient: LinearGradient(
                    colors: [kOrange.withOpacity(0.7), kWhite.withOpacity(0.4)],
                    stops: const [0.5, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                ),
                splineType: SplineType.cardinal,
                markerSettings: const MarkerSettings(
                    isVisible: true,
                    color: kOrange,
                    borderColor: kOrange,
                    width: 2,
                    height: 8
                ),
                animationDuration: 1000
            )
          ]
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:today/providers/habit_provider.dart';
import '../constants.dart';
import 'basic_container_widget.dart';

class AllHabitListWidget extends StatelessWidget {
  const AllHabitListWidget({Key? key,
    required this.name,
    required this.onTap,
    required this.time,
    required this.totalTime,
    required this.isStarted,
    required this.index
  }) : super(key: key);

  final String name;
  final VoidCallback onTap;
  final int time;
  final int totalTime;
  final bool isStarted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitProvider>(
        builder: (context, data, child){
          return GestureDetector(
            onLongPress: (){

            },
            child: BasicContainerWidget(
              height: 0.11,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: onTap,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularPercentIndicator(
                            circularStrokeCap: CircularStrokeCap.round,
                            backgroundColor: kWhite,
                            progressColor: kOrange,
                            radius: 30,
                            lineWidth: 8,
                            percent: data.percentCompleted(time, totalTime, index) < 1
                                    ? data.percentCompleted(time, totalTime, index) : 1,
                          ),
                          data.percentCompleted(time, totalTime, index) >= 1
                          ? const Icon(Icons.check, color: kOrange, size: 34,)
                          : Icon(isStarted ? Icons.pause : Icons.play_arrow, size: 34, color: kWhite,),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(name),
                        Text('${data.percentCompleted(time, totalTime, index) < 1
                            ? data.toMinSec(time) : 'Done'} / $totalTime min'),
                        Text('${(data.percentCompleted(time, totalTime, index) * 100).toStringAsFixed(0)}%')
                      ],
                    ),
                    SizedBox(
                      width: 40,
                      child: IconButton(
                          onPressed: (){

                          },
                          icon: const Icon(Icons.check, color: kOrange, size: 40,)),
                    ),

                  ],
                ),
              ),
            ),
          );
        });
  }
}

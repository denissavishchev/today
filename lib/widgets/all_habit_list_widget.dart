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
              height: 0.12,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                            lineWidth: 6,
                            percent: data.percentCompleted(time, totalTime, index) < 1
                                    ? data.percentCompleted(time, totalTime, index) : 1,
                          ),
                          data.percentCompleted(time, totalTime, index) >= 1
                          ? const Icon(Icons.check, color: kOrange, size: 34,)
                          : Icon(isStarted ? Icons.pause : Icons.play_arrow, size: 34, color: kWhite,),
                        ],
                      ),
                    ),
                    VerticalDivider(thickness: 2, color: kOrange.withOpacity(0.7),),
                    SizedBox(
                      width: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(name, style: orangeStyle,),
                          Text('${data.percentCompleted(time, totalTime, index) < 1
                              ? data.toMinSec(time) : 'Done'} / $totalTime min',
                              style: selectStyle.copyWith(fontSize: 16),),
                          Text('${(data.percentCompleted(time, totalTime, index)
                              * 100).toStringAsFixed(0)}%',
                            style: orangeStyle)
                        ],
                      ),
                    ),
                    VerticalDivider(thickness: 2, color: kOrange.withOpacity(0.7),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Days left: 23', style: orangeStyleSmall,),
                        Text('Start day: 23.11', style: orangeStyleSmall,),
                        Text('Skipped: 2', style: orangeStyleSmall,),
                        // IconButton(
                        //     onPressed: (){
                        //
                        //     },
                        //     icon: const Icon(Icons.check, color: kOrange)),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          );
        });
  }
}

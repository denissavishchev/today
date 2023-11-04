import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:today/providers/habit_provider.dart';
import '../constants.dart';
import '../model/habit_model.dart';
import 'basic_container_widget.dart';

class AllHabitListWidget extends StatelessWidget {
  const AllHabitListWidget(
      {Key? key,
      required this.onTap,
      required this.time,
      required this.isStarted,
      required this.index,
      required this.box,
      required this.habits})
      : super(key: key);

  final VoidCallback onTap;
  final int time;
  final bool isStarted;
  final int index;
  final Box<HabitModel> box;
  final List<HabitModel> habits;

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitProvider>(builder: (context, data, child) {
      return GestureDetector(
        onLongPress: () {
          data.deleteTask(index, box, context);
        },
        child: BasicContainerWidget(
          height: 0.12,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                habits[index].totalTime == 0
                    ? habits[index].isDone
                      ? const Icon(Icons.check, color: kOrange, size: 60)
                      : GestureDetector(
                        onTap: () => data.finishTask(index, box, habits, context),
                        child: const Icon(Icons.cancel_outlined, color: kOrange, size: 60))
                    : GestureDetector(
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
                              percent: data.percentCompleted(time, habits[index].totalTime, index) < 1
                                  ? data.percentCompleted(time, habits[index].totalTime, index)
                                  : 1,
                            ),
                            data.percentCompleted(time, habits[index].totalTime, index) >= 1
                                // || habits[index].isDone
                                ? const Icon(Icons.check, color: kOrange, size: 34)
                                : Icon(isStarted ? Icons.pause : Icons.play_arrow,
                                    size: 34, color: kWhite),
                          ],
                        ),
                ),
                VerticalDivider(
                  thickness: 2,
                  color: kOrange.withOpacity(0.7),
                ),
                SizedBox(
                  width: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(habits[index].name, style: kWhiteStyle),
                      Text(
                        '${data.percentCompleted(time, habits[index].totalTime, index) < 1
                            ? data.toMinSec(time)
                            : 'Done'} / ${habits[index].totalTime} min',
                        style: kWhiteStyle.copyWith(fontSize: 16),
                      ),
                      Text(
                          '${(data.percentCompleted(time, habits[index].totalTime, index) * 100).toStringAsFixed(0)}%',
                          style: kWhiteStyle)
                    ],
                  ),
                ),
                VerticalDivider(
                  thickness: 2,
                  color: kOrange.withOpacity(0.7),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Days left: ${habits[index].days}',
                      style: kWhiteStyleSmall,
                    ),
                    Text('Start day: '
                        '${habits[index].dateDay.toString().padLeft(2, '0')}'
                        ':${habits[index].dateMonth}',
                      style: kWhiteStyleSmall,
                    ),
                    Text('Skipped: ${habits[index].skipped}',
                      style: kWhiteStyleSmall,
                    ),
                    Text('done: ${habits[index].isDone}',
                      style: kWhiteStyleSmall,
                    ),
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

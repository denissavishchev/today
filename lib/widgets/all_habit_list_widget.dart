import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:today/providers/habit_provider.dart';
import '../constants.dart';
import '../model/boxes.dart';
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
    Size size = MediaQuery.of(context).size;
    return Consumer<HabitProvider>(builder: (context, data, child) {
      return GestureDetector(
        onLongPress: () {
          if(!isStarted){
            data.deleteTask(index, box, context);
          }
        },
        child: BasicContainerWidget(
          height: 0.13,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
            child: habits[index].days < 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(child: Text('Habit complete', style: kOrangeStyle,)),
                      ValueListenableBuilder<Box<HabitModel>>(
                          valueListenable: Boxes.addHabitToBase().listenable(),
                          builder: (context, box, _){
                            return GestureDetector(
                              onTap: () => data.addToStorage(
                              box,
                              index,
                              habits[index].name,
                              habits[index].description,
                              habits[index].statisticDays,
                              habits[index].skipped,
                            ),
                              child: const Icon(Icons.storage, color: kOrange, size: 34),
                            );
                          }),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                              visible: habits[index].totalTime != 0,
                              child: Text(
                                  '${(data.percentCompleted(
                                      time, habits[index].totalTime, index) * 100).toStringAsFixed(0)}%',
                                  style: kWhiteStyle.copyWith(fontSize: 18)),
                            ),
                            Padding(
                              padding: EdgeInsets.zero,
                              child: habits[index].isDone
                                  ? const Icon(Icons.check, color: kOrange, size: 40)
                                  : habits[index].totalTime == 0
                                  ? GestureDetector(
                                  onTap: () => data.finishTask(index, box, habits, context),
                                  child: const Icon(Icons.cancel_outlined, color: kOrange, size: 40))
                                  : GestureDetector(
                                      onTap: onTap,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircularPercentIndicator(
                                            circularStrokeCap: CircularStrokeCap.round,
                                            backgroundColor: kWhite,
                                            progressColor: kOrange,
                                            radius: 24,
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
                            ),
                            Visibility(
                              visible: habits[index].totalTime != 0,
                              child: Text(
                                '${data.percentCompleted(time, habits[index].totalTime, index) < 1
                                    ? data.toMinSec(time)
                                    : 'Done'}/${habits[index].totalTime}m',
                                style: kWhiteStyle.copyWith(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        thickness: 2,
                        color: kOrange.withOpacity(0.7),
                      ),
                      SizedBox(
                        width: size.width * 0.18,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Days left: ${habits[index].days}',
                              style: kWhiteStyleSmall,
                            ),
                            Text('Start: '
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
                          ],
                        ),
                      ),
                      VerticalDivider(
                        thickness: 2,
                        color: kOrange.withOpacity(0.7),
                      ),
                      SizedBox(
                        width: size.width * 0.28,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(habits[index].name, style: kOrangeStyle),
                            Text(habits[index].description,
                              style: kWhiteStyleSmall,
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

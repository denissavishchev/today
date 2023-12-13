import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:today/providers/habit_provider.dart';
import 'package:today/widgets/icon_svg_widget.dart';
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
          height: habits[index].days <= 0 ? 1 : 1.5,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
            child: habits[index].days <= 0
                ? Padding(
                  padding: EdgeInsets.only(left: size.width * 0.12, right: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Habit complete', style: kWhiteStyle,),
                        const Spacer(),
                        VerticalDivider(thickness: 2, color: kOrange.withOpacity(0.7)),
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
                                child: const SizedBox(
                                    width: 32,
                                    child: IconSvgWidget(
                                      icon: 'history',
                                      padding: 0,)),
                              );
                            }),
                      ],
                    ),
                )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.08,
                        child: habits[index].isDone
                            ? const IconSvgWidget(icon: 'check', padding: 0,)
                            : GestureDetector(
                            onTap: () => data.finishTask(index, box, habits, context),
                              child: const IconSvgWidget(icon: 'uncheck', padding: 0, color: kWhite)),
                      ),
                      VerticalDivider(thickness: 2, color: kOrange.withOpacity(0.7)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 250,
                              height: 38,
                              child: SingleChildScrollView(
                                child: Text(habits[index].name,
                                    style: kWhiteStyle),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Start: '
                                      '${habits[index].dateDay.toString().padLeft(2, '0')}'
                                      ':${habits[index].dateMonth}',
                                    style: kWhiteStyleSmall,
                                  ),
                                  Text('Days: ${habits[index].days}/${habits[index].statisticDays}',
                                    style: kWhiteStyleSmall,
                                  ),
                                  Text('Skipped: ${habits[index].skipped}',
                                    style: kWhiteStyleSmall,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      VerticalDivider(thickness: 2, color: kOrange.withOpacity(0.7)),
                      GestureDetector(
                        onTap: () {
                          if (habits[index].description != ''){
                            data.showComment(index, habits, context);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.comment,
                            color: habits[index].description != ''
                                ? kOrange : kGrey,
                            size: 32,),
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

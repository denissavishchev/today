import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:today/providers/to_do_provider.dart';
import 'package:today/widgets/icon_svg_widget.dart';
import '../constants.dart';
import '../model/to_do_model.dart';
import 'basic_container_widget.dart';

class AllToDoLists extends StatelessWidget {
  const AllToDoLists({
    super.key,
    required this.tasks,
    required this.index,
    required this.box,
  });

  final List<ToDoModel> tasks;
  final int index;
  final Box<ToDoModel> box;

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoProvider>(
        builder: (context, data, child){
          List splitDate = tasks[index].date.split('-');
          String year = splitDate[2];
          String month = int.parse(splitDate[1]) < 10
              ? '0${splitDate[1]}' : splitDate[1];
          String day = int.parse(splitDate[0]) < 10
              ? '0${splitDate[0]}' : splitDate[0];

          var time = DateTime.parse('$year-$month-$day ${tasks[index].time}');
          return GestureDetector(
            onLongPress: (){
              data.deleteTask(index, box, context);
            },
            child: BasicContainerWidget(
              height: tasks[index].time == '00:00' ? 0.07 : 0.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: GestureDetector(
                        onTap: () => data.doneTask(index, box, tasks, context),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: IconSvgWidget(icon: 'check', padding: 0,),
                          ))),
                    VerticalDivider(thickness: 2, color: kOrange.withOpacity(0.3),),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tasks[index].task,
                            overflow: TextOverflow.ellipsis,
                            style: kWhiteStyle),
                          tasks[index].date != '0-0-0000' ? Row(
                            children: [
                              Text(tasks[index].date == '0-0-0000'
                                  ? ''
                                  : tasks[index].date,
                                style: time.isAfter(DateTime.now())
                                    ? kOrangeStyleSmall : kWhiteStyleSmall),
                              const SizedBox(width: 12,),
                              Text(tasks[index].time == '00:00'
                                ? ''
                                : tasks[index].time,
                                style: time.isAfter(DateTime.now())
                                    ? kOrangeStyleSmall : kWhiteStyleSmall),
                            ],
                          ) : const SizedBox.shrink()
                        ],
                      ),
                    ),
                    VerticalDivider(thickness: 2, color: kOrange.withOpacity(0.3),),
                    SizedBox(
                        width: 40,
                        child: GestureDetector(
                            onTap: () {
                              if (tasks[index].description != ''){
                                data.showComment(index, tasks, context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: IconSvgWidget(
                                padding: 0,
                                icon: 'comment',
                                color: tasks[index].description != ''
                                  ? kOrange : kWhite,)
                            ),
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
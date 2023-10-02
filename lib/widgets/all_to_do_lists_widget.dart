import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:today/providers/to_do_provider.dart';
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
              height: 0.11,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: IconButton(
                          onPressed: (){
                            data.doneTask(index, box, tasks, context);
                          },
                          icon: const Icon(Icons.check, color: kOrange, size: 40,)),
                    ),
                    VerticalDivider(thickness: 2, color: kOrange.withOpacity(0.3),),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(tasks[index].task,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white,fontSize: 20),),
                            Text(tasks[index].time,
                              style: TextStyle(color: time.isAfter(DateTime.now())
                                  ? kOrange : kGrey, fontSize: 16),),
                            Text(tasks[index].date,
                              style: TextStyle(color: time.isAfter(DateTime.now())
                                  ? kOrange : kGrey, fontSize: 16),),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(thickness: 2, color: kOrange.withOpacity(0.3),),
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 140,
                        height: 60,
                        child: SingleChildScrollView(
                          child: Text(tasks[index].description,
                            style: const TextStyle(color: Colors.white, fontSize: 16),),
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
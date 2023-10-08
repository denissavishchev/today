import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../model/daily_model.dart';
import '../providers/daily_provider.dart';
import 'basic_container_widget.dart';

class AllDailyLists extends StatelessWidget {
  const AllDailyLists({
    super.key,
    required this.tasks,
    required this.index,
    required this.box,
  });

  final List<DailyModel> tasks;
  final int index;
  final Box<DailyModel> box;

  @override
  Widget build(BuildContext context) {
    return Consumer<DailyProvider>(
        builder: (context, data, child){
          return GestureDetector(
            onLongPress: (){
              data.deleteTask(index, box, context);
            },
            child: BasicContainerWidget(
              height: 0.11,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 140,
                              child: Text(tasks[index].task,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white,fontSize: 20),),
                            ),
                            VerticalDivider(thickness: 2, color: kOrange.withOpacity(0.9),),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(tasks[index].description,
                                maxLines: 2,
                                style: const TextStyle(color: Colors.white, fontSize: 16),),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: List.generate(tasks[index].howMany,
                                      (i) {
                                    return GestureDetector(
                                      onTap: () {
                                        data.updateTask(index, tasks[index].done, tasks[index].howMany, box, tasks, context);
                                      } ,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 2),
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            const BorderRadius.all(Radius.circular(30)),
                                            gradient: LinearGradient(
                                                colors: [
                                                  const Color(0xffbebebc).withOpacity(0.5),
                                                  const Color(0xff1a1a18).withOpacity(0.8),
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                stops: const [0, 0.75]),
                                          ),
                                          child: Center(
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color: const Color(0xff91918f),
                                                  border:
                                                  Border.all(color: kOrange, width: 0.5),
                                                  borderRadius: const BorderRadius.all(
                                                      Radius.circular(25)),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        color: Colors.black,
                                                        blurRadius: 3,
                                                        offset: Offset(0, 2)),
                                                    BoxShadow(
                                                        color: Color(0xff5e5e5c),
                                                        blurRadius: 1,
                                                        offset: Offset(0, -1)),
                                                  ]),
                                              child: Center(child: Icon(
                                                Icons.circle,
                                                color: i < tasks[index].done
                                                        ? kOrange
                                                        : Colors.transparent,
                                                size: 10,
                                              )),
                                            ),
                                          )),
                                    );
                                  }),
                            ),
                            Visibility(
                              visible: tasks[index].done == tasks[index].howMany,
                              child: const SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(Icons.check, color: kGreen,),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
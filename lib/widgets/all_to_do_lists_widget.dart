import 'package:flutter/material.dart';

import '../constants.dart';
import '../model/to_do_model.dart';
import 'basic_container_widget.dart';

class AllToDoLists extends StatelessWidget {
  const AllToDoLists({
    super.key,
    required this.tasks,
    required this.index,
  });

  final List<ToDoModel> tasks;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BasicContainerWidget(
      height: 0.11,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(tasks[index].task,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white,fontSize: 20),),
                    Text(tasks[index].time,
                      style: const TextStyle(color: kOrange, fontSize: 16),),
                    Text(tasks[index].date,
                      style: const TextStyle(color: kOrange, fontSize: 16),),
                  ],
                ),
              ),
            ),
            VerticalDivider(thickness: 2, color: kOrange.withOpacity(0.3),),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 180,
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
    );
  }
}
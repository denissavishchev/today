import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:today/constants.dart';
import 'package:today/model/habit_storage_model.dart';
import '../providers/habit_provider.dart';
import 'basic_container_widget.dart';

class AllHabitStatisticLists extends StatelessWidget {
  const AllHabitStatisticLists({
    super.key,
    required this.storage,
    required this.index,
    required this.box,
  });

  final List<HabitStorageModel> storage;
  final int index;
  final Box<HabitStorageModel> box;

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitProvider>(
        builder: (context, data, child){
          return BasicContainerWidget(
            height: storage[index].description != '' ? 0.11 : 0.07,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                children: [
                  SizedBox(
                    height: 34,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Text(storage[index].name, style: kOrangeStyle)),
                        VerticalDivider(thickness: 2, color: kOrange.withOpacity(0.7)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Days: ${storage[index].days}',
                              style: kWhiteStyleSmall,
                            ),
                            Text('Skipped: ${storage[index].skipped}',
                              style: kWhiteStyleSmall,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Text(storage[index].description, style: kWhiteStyleSmall,))),
                ],
              ),
            ),
          );
        });
  }
}


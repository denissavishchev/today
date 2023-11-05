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
    Size size = MediaQuery.of(context).size;
    return Consumer<HabitProvider>(
        builder: (context, data, child){
          return BasicContainerWidget(
            height: 0.11,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 80,
                    child: Column(
                      children: [
                        Text(storage[index].name,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: kOrangeStyle),
                        const SizedBox(height: 4),
                        Text('Days: ${storage[index].days}',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: kWhiteStyleSmall),
                        const SizedBox(height: 4),
                        Text('Skipped: ${storage[index].skipped}',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: kWhiteStyleSmall),
                      ],
                    ),
                  ),
                  VerticalDivider(thickness: 2, color: kOrange.withOpacity(0.9),),
                  SizedBox(
                    width: size.width * 0.65,
                    height: size.height * 0.1,
                    child: Text(storage[index].description,
                      style: kWhiteStyleSmall),
                  ),
                ],
              ),
            ),
          );
        });
  }
}


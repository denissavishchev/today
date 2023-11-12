import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:today/model/water_model.dart';
import '../model/boxes.dart';

class WaterProvider with ChangeNotifier {

  int water = 0;
  double percent = 0;
  String weight = '000';
  int target = 0;
  TimeOfDay initialWakeUpTime = const TimeOfDay(hour: 8, minute: 00);
  TimeOfDay initialBedTime = const TimeOfDay(hour: 22, minute: 00);

  void addWater(int quantity){
    water+=quantity;
    percent = (water / 3000) * 100;
    notifyListeners();
  }

  Future addToBase(Box<WaterSettingsModel> box) async {
    if(box.isEmpty){
      final settings = WaterSettingsModel()
        ..target = target
        ..wakeUpTime = initialWakeUpTime.toString().substring(10, 15)
        ..bedTime = initialBedTime.toString().substring(10, 15)
        ..weight = weight;
      final box = Boxes.addWaterSettingsToBase();
      box.add(settings);
    }else{
      box.putAt(0, WaterSettingsModel()
        ..target = target
        ..wakeUpTime = initialWakeUpTime.toString().substring(10, 15)
        ..bedTime = initialBedTime.toString().substring(10, 15)
        ..weight = weight
      );
    }

  }

  void setWeight(int index, int order){
    switch(order){
      case 0:
        weight = (index).toString() + weight.substring(1, 3);
        break;
      case 1:
        weight = weight.substring(0, 1) + index.toString() + weight.substring(2);
        break;
      case 2:
        weight = weight.substring(0, 2) + index.toString();
        break;
    }
    target = int.parse(weight) * 30;
    notifyListeners();
  }

  Future<void> wakeUpTimePicker(context) async {
    initialWakeUpTime = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    )) ?? const TimeOfDay(hour: 8, minute: 00);
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
  }

  Future<void> bedTimePicker(context) async {
    initialBedTime = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    )) ?? const TimeOfDay(hour: 22, minute: 00);
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
  }

  Future selectQuantity(context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  margin: const EdgeInsets.fromLTRB(32, 12, 32, 100),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            // spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(1, 1)
                        ),
                      ]
                  ),
                  child: Text('custom'),
                );
              }
          );
        });
  }


}
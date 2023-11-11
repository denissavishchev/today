import 'package:flutter/material.dart';
import 'package:today/model/water_model.dart';

import '../model/boxes.dart';

class WaterProvider with ChangeNotifier {

  int water = 0;
  double percent = 0;
  String weight = '000';
  int target = 0;
  TimeOfDay initialWakeUpTime = const TimeOfDay(hour: 8, minute: 00);
  TimeOfDay initialBedTime = const TimeOfDay(hour: 22, minute: 00);
  final TextEditingController weightController = TextEditingController();

  void addWater(){
    water+=100;
    percent = (water / 3000) * 100;
    notifyListeners();
  }

  Future addToBase() async {
    final settings = WaterSettingsModel()
      ..target = target
      ..wakeUpTime = initialWakeUpTime.toString()
      ..bedTime = initialBedTime.toString();
    final box = Boxes.addWaterSettingsToBase();
    box.add(settings);
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


}
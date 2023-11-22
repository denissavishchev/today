import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:today/model/water_daily_model.dart';
import 'package:today/model/water_model.dart';
import 'package:today/widgets/drink_button.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../model/buttons_model.dart';
import '../widgets/side_button_widget.dart';

class WaterProvider with ChangeNotifier {

  int water = 0;
  double percent = 0;
  String weight = '000';
  int target = 0;
  TimeOfDay initialWakeUpTime = const TimeOfDay(hour: 8, minute: 00);
  TimeOfDay initialBedTime = const TimeOfDay(hour: 22, minute: 00);
  List<int> ml = [];
  List<WaterDailyModel> waterDaily = [];
  List<int> totalPercents = [];
  String hydration = '0';
  late Timer timer;

  String totalPercentWater(){
    if(waterDaily.isNotEmpty){
      for(var p in waterDaily){
        totalPercents.add(p.percentMl);
      }
      var sum = totalPercents.reduce((a, b) => a + b);
      return hydration =  (sum / totalPercents.length).toStringAsFixed(0);
    }else{
      return '';
    }
  }

  Future addButton(int value) async{
    final button = ButtonsModel()
      ..buttons = value;
    final box = Boxes.addButtonToBase();
    box.add(button);
  }

  Future createMl(context, bool button, Box<WaterDailyModel> box, String date) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.45,
            margin: const EdgeInsets.fromLTRB(84, 12, 84, 150),
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
            child: ListWheelScrollView(
              onSelectedItemChanged: (index) {
                FocusManager.instance.primaryFocus?.unfocus();
                // data.setDays(index, true);
              },
              physics: const FixedExtentScrollPhysics(),
              itemExtent: 74,
              children: List.generate(10, (index){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: DrinkButton(
                      onTap: () {
                        if(button){
                          addButton((index + 1) * 100);
                        }else{
                          addPortionToBase((index + 1) * 100, box, date);
                        }
                        Navigator.of(context).pop();
                      },
                      quantity: '${(index + 1) * 100}',
                      onLongPress: (){}),
                );
              } ),
            ),
          );
        });
  }

  Future deleteMl(int index, context, Box<ButtonsModel> box) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.35,
              margin: const EdgeInsets.fromLTRB(0, 12, 0, 220),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                  border: const Border.symmetric(
                      horizontal: BorderSide(width: 0.5, color: kOrange)),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/bg04.png'),
                      fit: BoxFit.fitWidth),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        // spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(1, 1)
                    ),
                  ]
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Stack(
                        children: [
                          SideButtonWidget(
                            width: 240,
                            onTap: (){
                              box.deleteAt(index);
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.check,
                              color: kOrange.withOpacity(0.7),
                              size: 40,),),
                          Positioned.fill(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 40),
                                  child: Text('Delete button?', style: kOrangeStyle,),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SideButtonWidget(
                        width: 150,
                        right: false,
                        child: Icon(Icons.cancel,
                          color: kOrange.withOpacity(0.7),
                          size: 40,),
                        onTap: () => Navigator.of(context).pop()),
                  ),
                  const SizedBox(height: 20,),
                ],
              )
          );
        });
  }

  Future addPortionToBase(int quantity, Box<WaterDailyModel> box, String date) async {
    water = water + quantity;
    percent = (water / target) * 100;
    if(box.isEmpty) {
      final waterDaily = WaterDailyModel()
        ..dateMl = DateTime.now().day.toString()
        ..targetMl = target
        ..portionMl = water
        ..percentMl = percent.toInt()
        ..dateTime = DateTime.now().toString();
      final box = Boxes.addWaterDailyToBase();
      box.add(waterDaily);
    }else if(box.isNotEmpty && date == DateTime.now().day.toString()){
        box.putAt(box.length - 1, WaterDailyModel()
          ..dateMl = date
          ..targetMl = target
          ..portionMl = water
          ..percentMl = percent.toInt()
          ..dateTime = DateTime.now().toString());
      }else{
        final waterDaily = WaterDailyModel()
          ..dateMl = DateTime.now().day.toString()
          ..targetMl = target
          ..portionMl = water
          ..percentMl = percent.toInt()
          ..dateTime = DateTime.now().toString();
        final box = Boxes.addWaterDailyToBase();
        box.add(waterDaily);
      }
  }

  Future addSettingsToBase(Box<WaterSettingsModel> box) async {
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

  // int daysBetween(DateTime from, DateTime to) {
  //   from = DateTime(from.year, from.month, from.day);
  //   to = DateTime(to.year, to.month, to.day);
  //   return (to.difference(from).inHours / 24).round();
  // }

  Future sendNotification(TimeOfDay start, TimeOfDay end) async{
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().microsecondsSinceEpoch.remainder(200),
        channelKey: 'scheduled',
        title: '${Emojis.symbols_potable_water} Drink some water',
        body: 'Start: ${DateTime.now().hour}',
      ),
      schedule: NotificationCalendar(
          hour: start.hour,
          minute: end.minute,
          // repeats: true
      ),
    );
      timer = Timer.periodic(const Duration(hours: 1), (timer) async {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: DateTime.now().microsecondsSinceEpoch.remainder(200),
            channelKey: 'scheduled',
            title: '${Emojis.symbols_potable_water} Drink some water',
            body: 'End: ${DateTime.now().hour}',
          ),
        );
      });
    if(TimeOfDay.now() == end){
      timer.cancel();
    }
  }

}
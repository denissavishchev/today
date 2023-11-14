import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:today/model/water_model.dart';
import 'package:today/widgets/drink_button.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../widgets/side_button_widget.dart';

class WaterProvider with ChangeNotifier {

  int water = 0;
  double percent = 0;
  String weight = '000';
  int target = 0;
  TimeOfDay initialWakeUpTime = const TimeOfDay(hour: 8, minute: 00);
  TimeOfDay initialBedTime = const TimeOfDay(hour: 22, minute: 00);
  List<int> ml = [500, 400, 300];

  void addWater(int quantity){
    water = water + quantity;
    percent = (water / target) * 100;
    notifyListeners();
  }

  void addMl(int value){
    ml.add(value);
    notifyListeners();
  }

  Future createMl(context, bool button) {
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
                          addMl((index + 1) * 100);
                        }else{
                          addWater((index + 1) * 100);
                        }
                        Navigator.of(context).pop();
                      } ,
                      quantity: '${(index + 1) * 100}',
                      onLongPress: (){}),
                );
              } ),
            ),
          );
        });
  }

  Future deleteMl(int index, context) {
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
                              ml.removeAt(index);
                              notifyListeners();
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

}
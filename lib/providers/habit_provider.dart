import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/boxes.dart';
import '../model/habit_model.dart';

class HabitProvider with ChangeNotifier {

int length = 0;
late List<int> times = List.filled(length, 0);
late List<bool> inProgress = List.filled(length, false);
late List<bool> cancel = List.filled(length, false);

final TextEditingController titleController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();

bool isTimer = true;
String days = '00';
int time = 1;

Future addToBase() async {
  final habit = HabitModel()
    ..name = titleController.text.trim()
    ..description = descriptionController.text.trim()
    ..totalTime = isTimer ? time : 0
    ..days = int.parse(days)
    ..percent = 0.0
    ..dateDay = DateTime.now().day
    ..dateMonth = DateTime.now().month
    ..dateYear = DateTime.now().year
    ..skipped = 0
    ..isTimer = isTimer;
  final box = Boxes.addHabitToBase();
  box.add(habit);
}

void reset(){
  titleController.clear();
  descriptionController.clear();
  time = 1;
  isTimer = true;
}

void setTimer(){
  isTimer = !isTimer;
  notifyListeners();
}

void setTime(int index){
  time = index + 1;
  notifyListeners();
}

void setDays(int index, bool first){
  if(first){
    days = (index).toString() + days.substring(1);
  }else{
    days = days.substring(0, 1) + index.toString();
  }
  notifyListeners();
}

void resetDays(){
  days = '00';
  notifyListeners();
}

double percentCompleted(int time, int totalTime, int index){
  if(time / (totalTime * 60) < 1){
    return time / (totalTime * 60);
  }else{
    cancel[index] = true;
    return 1;
  }
}

String toMinSec(int seconds){
  String sec = (seconds % 60).toString();
  String min = (seconds / 60).toStringAsFixed(5);
  if(sec.length == 1){
    sec = '0$sec';
  }
  if(min[1] == '.'){
    min = min.substring(0, 1);
  }
  return '$min:$sec';
}

void isStarted(int index){
  var startTime = DateTime.now();
  int elapsed = times[index];
  inProgress[index] = !inProgress[index];

  if(inProgress[index]){
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(!inProgress[index] || cancel[index]){
        timer.cancel();
      }
      var currentTime = DateTime.now();
      times[index] = elapsed + currentTime.second - startTime.second +
          60 * (currentTime.minute - startTime.minute) +
          60 * 60 * (currentTime.hour - startTime.hour);
      notifyListeners();
    });
  }
}

}
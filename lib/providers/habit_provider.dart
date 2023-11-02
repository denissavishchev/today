import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HabitProvider with ChangeNotifier {

List<String> names = ['Exercise', 'Read', 'Run', 'Drink', 'Code', 'Meditate'];
List<int> times = [0, 0, 0, 0, 0, 0];
List<int> totalTimes = [2, 3, 4, 5, 1, 2];
List<bool> inProgress = [false, false, false, false, false, false];
List<bool> cancel = [false, false, false, false, false, false];

final TextEditingController titleController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();

bool isTimer = true;
String days = '00';
Duration initTime = const Duration(seconds: 0);

void setTimer(){
  isTimer = !isTimer;
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

Future showTimer(context){
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          margin: const EdgeInsets.fromLTRB(32, 12, 32, 150),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 3,
                    offset: const Offset(1, 1)
                ),
              ]
          ),
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.ms,
            initialTimerDuration: initTime,
            onTimerDurationChanged: (time){
                initTime = time;
                notifyListeners();
            },
          ),
        );
      });
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
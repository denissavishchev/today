import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../model/habit_model.dart';
import '../widgets/side_button_widget.dart';

class HabitProvider with ChangeNotifier {

  List<int> times = [];
  List<bool> inProgress = [];
  List<bool> cancel = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isTimer = true;
  String days = '00';
  int time = 1;

  void finishTask(int index, Box<HabitModel> box, List<HabitModel> habits, context){
    box.putAt(index, HabitModel()
      ..name = habits[index].name
      ..description = habits[index].description
      ..totalTime = habits[index].totalTime
      ..days = habits[index].days - 1
      ..percent = 1.0
      ..dateDay = habits[index].dateDay
      ..dateMonth = habits[index].dateMonth
      ..dateYear = habits[index].dateYear
      ..skipped = 0
      ..isTimer = habits[index].isTimer
      ..isDone = true
    );
  }

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
      ..isTimer = isTimer
      ..isDone = false;
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

  void isStarted(int index, Box<HabitModel> box, List<HabitModel> habits, context){
    var startTime = DateTime.now();
    int elapsed = times[index];
    inProgress[index] = !inProgress[index];
    if(inProgress[index]){
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if(!inProgress[index] || cancel[index]){
          inProgress[index] = false;
          times[index] = 0;
          timer.cancel();
        }
        var currentTime = DateTime.now();
        times[index] = elapsed + currentTime.second - startTime.second +
            60 * (currentTime.minute - startTime.minute) +
            60 * 60 * (currentTime.hour - startTime.hour);
        if(times[index] / 60 == habits[index].totalTime){
          finishTask(index, box, habits, context);
        }
        notifyListeners();
      });
    }
  }

  void resetTask(int index, Box<HabitModel> box, List<HabitModel> habits, context) {
    box.putAt(index, HabitModel()
      ..name = habits[index].name
      ..description = habits[index].description
      ..totalTime = habits[index].totalTime
      ..days = habits[index].days
      ..percent = 0.0
      ..dateDay = habits[index].dateDay
      ..dateMonth = habits[index].dateMonth
      ..dateYear = habits[index].dateYear
      ..skipped = habits[index].isDone
          ? habits[index].skipped
          : habits[index].skipped + 1
      ..isTimer = habits[index].isTimer
      ..isDone = false
    );
  }

  Future deleteTask(int index, Box<HabitModel> box, context) {
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
                      image: AssetImage('assets/images/bg03.png'),
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
                                  child: Text('Delete task?', style: kOrangeStyle,),
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

}
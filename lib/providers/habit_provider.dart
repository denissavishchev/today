import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class HabitProvider with ChangeNotifier {

List<String> names = ['Exercise', 'Read', 'Run', 'Drink', 'Code', 'Meditate'];
List<int> times = [0, 0, 0, 0, 0, 0];
List<int> totalTimes = [2, 3, 4, 5, 1, 2];
List<bool> inProgress = [false, false, false, false, false, false];
List<bool> cancel = [false, false, false, false, false, false];

final TextEditingController titleController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();

bool isTimer = true;
int days = 1;
Duration initTime = const Duration(seconds: 0);

void setTimer(){
  isTimer = !isTimer;
  notifyListeners();
}

void setDays(int index){
  days = index + 1;
  notifyListeners();
}

Future openDays(context){
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            margin: const EdgeInsets.fromLTRB(0, 12, 0, 80),
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
            child: GridView.count(
              scrollDirection: Axis.vertical,
                crossAxisCount: 9,
              children: List.generate(90, (index) {
                return GestureDetector(
                  onTap: () {
                    setDays(index);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      margin: const EdgeInsets.all(2),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xffbebebc).withOpacity(0.5),
                              const Color(0xff1a1a18).withOpacity(0.8),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: const [0, 0.75]),
                      ),
                      child: Center(
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              color: const Color(0xff91918f),
                              border:
                              Border.all(color: kOrange, width: 0.5),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(25)),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 3,
                                    offset: Offset(0, 2)),
                                BoxShadow(
                                    color: Color(0xff5e5e5c),
                                    blurRadius: 1,
                                    offset: Offset(0, -1)),
                              ]),
                          child: Center(
                              child: Text('${index + 1}', style: kOrangeStyle.copyWith(fontSize: 16),)
                          ),
                        ),
                      )),
                );
              }),
            ),
        );
      });
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
            initialTimerDuration: Duration.zero,
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
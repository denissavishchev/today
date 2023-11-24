import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class HiveProvider with ChangeNotifier{

  late Timer timer;

  Future<void> addNotificationData(TimeOfDay start, TimeOfDay end, int interval) async {
    Box box = Hive.box('notifications');
    box.put('start', start.toString());
    box.put('end', end.toString());
    box.put('interval', interval);
    notifyListeners();
    print(box.get('start').toString().substring(10, 12));
    print(box.get('start').toString().substring(13, 15));
    print(box.get('interval'));
  }

  Future sendNotification() async{
    Box box = Hive.box('notifications');
    for(var i = 0; i < 5; i++){
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: DateTime.now().microsecondsSinceEpoch.remainder(200),
          channelKey: 'scheduled',
          title: '${Emojis.symbols_potable_water} Drink some water',
          body: 'startTime: ${DateTime.now().hour} Time: ${DateTime.now().hour + i}',
        ),
        schedule: NotificationCalendar(
            hour: int.parse(box.get('start').toString().substring(10, 12)) + i,
            minute: int.parse(box.get('start').toString().substring(13, 15)),
            second: 0,
            repeats: true
        ),
      );
    }
    // timer = Timer.periodic(const Duration(hours: 1), (timer) async {
    //   await AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //       id: DateTime.now().microsecondsSinceEpoch.remainder(200),
    //       channelKey: 'scheduled',
    //       title: '${Emojis.symbols_potable_water} Drink some water',
    //       body: 'End: ${DateTime.now().hour}',
    //     ),
    //   );
    // });
    // if(TimeOfDay.now() == end){
    //   timer.cancel();
    // }
  }
}
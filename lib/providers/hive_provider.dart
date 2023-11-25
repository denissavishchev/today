import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class HiveProvider with ChangeNotifier{

  late Timer timer;

  // int daysBetween(DateTime from, DateTime to) {
  //   from = DateTime(from.year, from.month, from.day);
  //   to = DateTime(to.year, to.month, to.day);
  //   return (to.difference(from).inHours / 24).round();
  // }

  Future<void> addNotificationData(TimeOfDay start, TimeOfDay end, int interval) async {
    Box box = Hive.box('notifications');
    box.put('start', start.toString());
    box.put('end', end.toString());
    box.put('interval', interval);
    notifyListeners();
  }

  Future sendNotification() async{
    Box box = Hive.box('notifications');
    int start = int.parse(box.get('start').toString().substring(10, 12));
    int end = int.parse(box.get('end').toString().substring(10, 12));
    int interval = box.get('interval');
    for(var i = start; i < end; i+interval){
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: DateTime.now().microsecondsSinceEpoch.remainder(200),
          channelKey: 'scheduled',
          title: '${Emojis.animals_camel} Drink some water',
          body: 'startTime: ${DateTime.now().hour} Time: ${DateTime.now().hour + i}',
        ),
        schedule: NotificationCalendar(
            hour: i,
            minute: int.parse(box.get('start').toString().substring(13, 15)),
            second: 0,
            repeats: true
        ),
      );
    }
  }
}
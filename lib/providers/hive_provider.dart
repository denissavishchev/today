import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class HiveProvider with ChangeNotifier{

  late Timer timer;

  Future<void> addNotificationData(TimeOfDay start, TimeOfDay end, int interval) async {
    AwesomeNotifications().removeChannel('scheduled');
    AwesomeNotifications().setChannel(NotificationChannel(
            channelKey: 'scheduled',
            channelName: 'Scheduled Notifications',
            channelDescription: 'Notification channel for basic tests'));
    Box box = Hive.box('notifications');
    box.put('start', start.toString());
    box.put('end', end.toString());
    box.put('interval', interval);
    notifyListeners();
    int startTime = int.parse(box.get('start').toString().substring(10, 12));
    int endTime = int.parse(box.get('end').toString().substring(10, 12)) == 0
                  ? 24 : int.parse(box.get('end').toString().substring(10, 12));
    int intervalTime = box.get('interval');
    for(var i = 0; i < endTime - startTime + 1; i+=intervalTime){
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: DateTime.now().microsecondsSinceEpoch.remainder(200),
          channelKey: 'scheduled',
          title: '${Emojis.wheater_droplet} Drink some water',
        ),
        schedule: NotificationCalendar(
            hour: int.parse(box.get('start').toString().substring(10, 12)) + i,
            minute: int.parse(box.get('start').toString().substring(13, 15)),
            second: 0,
            repeats: true
        ),
      );
    }
  }

}
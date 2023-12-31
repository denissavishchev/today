import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:today/pages/daily_page.dart';
import 'package:today/pages/habit_page.dart';
import 'package:today/pages/water_page.dart';
import '../constants.dart';
import '../pages/to_do_page.dart';

class MainProvider with ChangeNotifier {

  void initNotifications(){
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  final List pages = [
    const ToDoPage(),
    const DailyPage(),
    const HabitPage(),
    const WaterPage(),
  ];

  final List icon = [
    'todolist',
    'routine',
    'brain',
    'drop',
  ];

  void changePage(int index) {
    activePage = index;
    notifyListeners();
  }


}
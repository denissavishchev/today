import 'package:flutter/material.dart';
import 'package:today/pages/daily_page.dart';
import 'package:today/pages/habbit_page.dart';
import 'package:today/pages/settings_page.dart';
import '../pages/to_do_page.dart';


class MainProvider with ChangeNotifier {

  final List pages = [
    const ToDoPage(),
    const DailyPage(),
    const HabbitPage(),
    const SettingsPage(),
  ];

  final List icon = [
    Icons.playlist_add_check,
    Icons.self_improvement,
    Icons.supervisor_account,
    Icons.settings,];

  final PageController mainPageController = PageController(initialPage: 0);
  int activePage = 0;

  void changePage(int index) {
    activePage = index;
    notifyListeners();
  }


}
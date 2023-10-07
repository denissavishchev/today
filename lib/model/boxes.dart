import 'package:hive/hive.dart';
import 'package:today/model/to_do_model.dart';
import 'daily_model.dart';


class Boxes {
  static Box<ToDoModel> addTaskToBase() =>
      Hive.box<ToDoModel>('to_do_page');
  static Box<DailyModel> addDailyToBase() =>
      Hive.box<DailyModel>('daily_page');
}
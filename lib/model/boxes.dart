import 'package:hive/hive.dart';
import 'package:today/model/habit_storage_model.dart';
import 'package:today/model/percent_model.dart';
import 'package:today/model/to_do_model.dart';
import 'package:today/model/water_daily_model.dart';
import 'package:today/model/water_model.dart';
import 'buttons_model.dart';
import 'daily_model.dart';
import 'habit_model.dart';

class Boxes {
  static Box<ToDoModel> addTaskToBase() =>
      Hive.box<ToDoModel>('to_do_page');
  static Box<DailyModel> addDailyToBase() =>
      Hive.box<DailyModel>('daily_page');
  static Box<PercentModel> addPercentToBase() =>
      Hive.box<PercentModel>('percents');
  static Box<HabitModel> addHabitToBase() =>
      Hive.box<HabitModel>('habits');
  static Box<HabitStorageModel> addHabitStorageToBase() =>
      Hive.box<HabitStorageModel>('storage');
  static Box<WaterSettingsModel> addWaterSettingsToBase() =>
      Hive.box<WaterSettingsModel>('water_settings');
  static Box<WaterDailyModel> addWaterDailyToBase() =>
      Hive.box<WaterDailyModel>('water_daily');
  static Box<ButtonsModel> addButtonToBase() =>
      Hive.box<ButtonsModel>('buttons');
}
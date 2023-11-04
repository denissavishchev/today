import 'package:hive/hive.dart';
part 'habit_model.g.dart';

@HiveType(typeId: 44)
class HabitModel extends HiveObject{
  @HiveField(12)
  late String name;
  @HiveField(13)
  late String description;
  @HiveField(14)
  late int totalTime;
  @HiveField(15)
  late int days;
  @HiveField(16)
  late double percent;
  @HiveField(17)
  late int dateDay;
  @HiveField(18)
  late int dateMonth;
  @HiveField(19)
  late int dateYear;
  @HiveField(20)
  late int skipped;
  @HiveField(21)
  late bool isTimer;
  @HiveField(22)
  late bool isDone;
}
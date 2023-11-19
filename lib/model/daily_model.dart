import 'package:hive/hive.dart';
part 'daily_model.g.dart';

@HiveType(typeId: 65)
class DailyModel extends HiveObject{
  @HiveField(11)
  late String task;
  @HiveField(22)
  late String description;
  @HiveField(33)
  late int howMany;
  @HiveField(44)
  late int done;
  @HiveField(55)
  late int day;
  @HiveField(66)
  late String dateTime;
}
import 'package:hive/hive.dart';
part 'daily_model.g.dart';

@HiveType(typeId: 33)
class DailyModel extends HiveObject{
  @HiveField(5)
  late String task;
  @HiveField(6)
  late String description;
  @HiveField(7)
  late int howMany;
  @HiveField(8)
  late int done;
  @HiveField(11)
  late int day;
}
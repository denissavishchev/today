import 'package:hive/hive.dart';
part 'percent_model.g.dart';

@HiveType(typeId: 4)
class PercentModel extends HiveObject{
  @HiveField(12)
  late int percent;
  @HiveField(13)
  late int day;
  @HiveField(14)
  late int month;
  @HiveField(15)
  late int year;
  @HiveField(16)
  late String dateTime;
}
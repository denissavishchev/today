import 'package:hive/hive.dart';
part 'water_model.g.dart';

@HiveType(typeId: 67)
class WaterSettingsModel extends HiveObject{
  @HiveField(0)
  late int target;
  @HiveField(1)
  late String wakeUpTime;
  @HiveField(2)
  late String bedTime;
}
import 'package:hive/hive.dart';
part 'water_model.g.dart';

@HiveType(typeId: 68)
class WaterSettingsModel extends HiveObject{
  @HiveField(0)
  late int target;
  @HiveField(1)
  late String wakeUpTime;
  @HiveField(2)
  late String bedTime;
  @HiveField(3)
  late String weight;
}
import 'package:hive/hive.dart';
part 'habit_storage_model.g.dart';

@HiveType(typeId: 55)
class HabitStorageModel extends HiveObject{
  @HiveField(24)
  late String name;
  @HiveField(25)
  late String description;
  @HiveField(26)
  late int days;
  @HiveField(27)
  late int skipped;
}
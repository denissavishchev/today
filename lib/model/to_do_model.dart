import 'package:hive/hive.dart';
part 'to_do_model.g.dart';

@HiveType(typeId: 0)
class ToDoModel extends HiveObject{
  @HiveField(0)
  late String task;
  @HiveField(1)
  late String description;
  @HiveField(2)
  late String date;
  @HiveField(3)
  late String time;
  @HiveField(4)
  late String list;
}
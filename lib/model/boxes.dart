import 'package:hive/hive.dart';
import 'package:today/model/to_do_model.dart';


class Boxes {
  static Box<ToDoModel> addToBase() =>
      Hive.box<ToDoModel>('to_do_page');

}
import 'package:intl/intl.dart';

final format = DateFormat('d-MM-yyyy');

String convertTime(int time){
  var date = DateTime.fromMillisecondsSinceEpoch(time);
  return format.format(date).toString();
}
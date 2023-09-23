import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import '../constants.dart';

class ToDoProvider with ChangeNotifier {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  ScrollController scrollController = ScrollController();
  DateTime initialDate = DateTime.now();
  DateTime? dateTime = DateTime.now();

  Future addToBase(int time, String title, String comment) async {

  }

  Future<void> datePicker(context) async {
    dateTime = await showRoundedDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      borderRadius: 16,
      imageHeader: const AssetImage('assets/images/bg09.png'),
        styleYearPicker: MaterialRoundedYearPickerStyle(
          textStyleYear: TextStyle(fontSize: 40, color: Colors.white.withOpacity(0.6)),
          textStyleYearSelected:
          const TextStyle(fontSize: 56, color: Colors.white, fontWeight: FontWeight.bold),
          heightYearRow: 100,
          backgroundPicker: Colors.grey,
        ),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        textStyleYearButton: const TextStyle(color: Colors.white, fontSize: 26),
        textStyleDayButton: const TextStyle(color: Colors.white, fontSize: 30),
        textStyleCurrentDayOnCalendar: const TextStyle(color: kOrange),
        textStyleButtonPositive: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.bold),
        textStyleButtonNegative: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.6)),
        backgroundActionBar: kOrange.withOpacity(0.2),
        backgroundPicker: Colors.grey.withOpacity(0.7),
        backgroundHeader: kOrange.withOpacity(0.5),
        decorationDateSelected: BoxDecoration(color: kOrange.withOpacity(0.7), shape: BoxShape.circle)
      )
    );
    notifyListeners();
  }

}

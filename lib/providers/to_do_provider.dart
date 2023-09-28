import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:today/functions.dart';
import 'package:today/model/boxes.dart';
import 'package:today/model/to_do_model.dart';
import '../constants.dart';
import '../widgets/select_list_widget.dart';

enum Lists{
  all,
  common,
  personal,
  shopping,
  wishlist,
  work,
  finished
}

enum AddLists{
  common,
  personal,
  shopping,
  wishlist,
  work,
}

dynamic selectedList = Lists.all;
dynamic addSelectedList = AddLists.common;

class ToDoProvider with ChangeNotifier {

  String listTitle = 'All lists';
  String addListTitle = 'Common';
  List selectList = ['Common', 'Personal', 'Shopping', 'Wishlist', 'Work'];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  ScrollController scrollController = ScrollController();
  String noDate = 'Date not set';
  String noNotification = '(without notification)';
  DateTime dateTime = DateTime.now();
  TimeOfDay initialTime = const TimeOfDay(hour: 8, minute: 00);

  Future addToBase() async {
    final date = convertTime(dateTime.millisecondsSinceEpoch);
    final hour = initialTime.hour < 10
        ? '0${initialTime.hour}'
        : '${initialTime.hour}';
    final minute = initialTime.minute < 10
        ? '0${initialTime.minute}'
        : '${initialTime.minute}';
    final task =  ToDoModel()
        ..task = titleController.text.trim()
        ..description = descriptionController.text.trim()
        ..date = date
        ..time = '$hour:$minute'
        ..list = addListTitle;
    final box = Boxes.addToBase();
    box.add(task);
  }

  void changeListValue(String text){
    listTitle = text;
    if(text == 'All lists'){
      text = 'All';
    }
    selectedList =  Lists.values.byName(text.toLowerCase());
    notifyListeners();
  }

  void changeAddListValue(String text){
    addListTitle = text;
    addSelectedList =  AddLists.values.byName(text.toLowerCase());
    notifyListeners();
  }

  Future addSelectLists(context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  margin: const EdgeInsets.fromLTRB(32, 12, 32, 150),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            // spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(1, 1)
                        ),
                      ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ScrollConfiguration(
                          behavior: const ScrollBehavior().copyWith(overscroll: false),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: ListView.builder(
                                itemCount: selectList.length,
                                itemBuilder: (context, index){
                                  return SelectListWidget(
                                    icon: Icons.list,
                                    text: selectList[index],
                                    count: 3, 
                                    onTap: () => changeAddListValue(selectList[index]),
                                  );
                                }),
                          ),
                        ),
                      ),
                      // selectList.length > 4
                      //     ? const SizedBox(height: 10,)
                      //     : const SizedBox.shrink(),
                    ],
                  ),
                );
              }
          );
        });
  }

  Future selectLists(context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    margin: const EdgeInsets.fromLTRB(32, 12, 32, 150),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: const BorderRadius.all(Radius.circular(24)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 3,
                              offset: const Offset(1, 1)
                          ),
                        ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SelectListWidget(
                          icon: Icons.home,
                          text: 'All lists',
                          count: 3, 
                          onTap: () => changeListValue('All lists')
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: ScrollConfiguration(
                            behavior: const ScrollBehavior().copyWith(overscroll: false),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: ListView.builder(
                                itemCount: selectList.length,
                                  itemBuilder: (context, index){
                                    return SelectListWidget(
                                      icon: Icons.list,
                                      text: selectList[index],
                                      count: 3, 
                                      onTap: () => changeListValue(selectList[index]),
                                    );
                                  }),
                            ),
                          ),
                        ),
                        // selectList.length > 4
                        //     ? const SizedBox(height: 10,)
                        //     : const SizedBox.shrink(),
                        SelectListWidget(
                          icon: Icons.check_circle,
                          text: 'Finished',
                          count: 3, 
                          onTap: () => changeListValue('Finished'),),
                      ],
                    ),
                );
              }
          );
        });
  }

  Future<void> datePicker(context) async {
    dateTime = (await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      borderRadius: 16,
      imageHeader: const AssetImage('assets/images/date.png'),
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
    )) ?? DateTime.now();
    noDate = convertTime(dateTime.millisecondsSinceEpoch);
    notifyListeners();
  }

  Future<void> timePicker(context) async {
    initialTime = (await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    )) ?? const TimeOfDay(hour: 8, minute: 00);
    notifyListeners();
  }

}



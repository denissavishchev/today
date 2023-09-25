import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
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

dynamic selectedList = Lists.all;

class ToDoProvider with ChangeNotifier {

  String listTitle = 'All lists';
  List selectList = ['Common', 'Personal', 'Shopping', 'Wishlist', 'Work'];
  final TextEditingController quickNoteController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  ScrollController scrollController = ScrollController();
  DateTime initialDate = DateTime.now();
  DateTime? dateTime = DateTime.now();

  Future addToBase(int time, String title, String comment) async {

  }

  void changeListValue(String text){
    listTitle = text;
    if(text == 'All lists'){
      text = 'All';
    }
    selectedList =  Lists.values.byName(text.toLowerCase());
    notifyListeners();
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
                              // spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(1, 1)
                          ),
                        ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SelectListWidget(
                          icon: Icons.home,
                          text: 'All lists',
                          count: 3,),
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
                                    );
                                  }),
                            ),
                          ),
                        ),
                        // selectList.length > 4
                        //     ? const SizedBox(height: 10,)
                        //     : const SizedBox.shrink(),
                        const SelectListWidget(
                          icon: Icons.check_circle,
                          text: 'Finished',
                          count: 3,),
                      ],
                    ),
                );
              }
          );
        });
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



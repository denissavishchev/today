import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:hive/hive.dart';
import 'package:today/functions.dart';
import 'package:today/model/boxes.dart';
import 'package:today/model/to_do_model.dart';
import 'package:today/pages/add_task_page.dart';
import 'package:today/widgets/fade_container_widget.dart';
import '../constants.dart';
import '../pages/main_page.dart';
import '../widgets/select_list_widget.dart';
import '../widgets/side_button_widget.dart';

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

  Map<String, int> listCounts = {};
  int finishedListCount = 0;
  List<String> lists = [];
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
  int editIndex = 0;
  bool isEdit = true;

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
        ..date = noDate == 'Date not set' ? '0-0-0000' : date
        ..time = noDate == 'Date not set' ? '00:00' : '$hour:$minute'
        ..list = addListTitle;
    final box = Boxes.addTaskToBase();
    box.add(task);

    List splitDate = date.split('-');
    int year = int.parse(splitDate[2]);
    int month = int.parse(splitDate[1]);
    int day = int.parse(splitDate[0]);

    if(noDate != 'Date not set'){
      sendNotification(year, month, day, int.parse(hour), int.parse(minute),
          titleController.text.trim());
    }
  }

  Future sendNotification(int year, int month, int day, int hour, int minute,
      String title) async{
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().microsecondsSinceEpoch.remainder(200),
        channelKey: 'scheduled',
        title: '${Emojis.time_alarm_clock} It`s exactly that time for:',
        body: title,
        backgroundColor: kOrange
      ),
      schedule: NotificationCalendar(
          year: year,
          month: month,
          day: day,
          hour: hour,
          minute: minute
      ),
    );
  }

  int calculateLists(){
    int sum = 0;
    List values = listCounts.values.toList();
    for(int value in values){
      sum += value;
    }
    return sum;
  }

  void changeListValue(String text){
    listTitle = text;
    if(text == 'All lists'){
      text = 'All';
    }
    selectedList = Lists.values.byName(text.toLowerCase());
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
                  height: MediaQuery.of(context).size.height * 0.45,
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
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 12, 0, 12),
                      child: ListView.builder(
                          itemCount: selectList.length,
                          itemBuilder: (context, index){
                            return SelectListWidget(
                              icon: Icons.list,
                              text: selectList[index],
                              count: 0,
                              visible: false,
                              onTap: () {
                                changeAddListValue(selectList[index]);
                                FocusManager.instance.primaryFocus?.unfocus();
                              }
                            );
                          }),
                    ),
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
                          count: calculateLists(),
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
                                      count: int.parse(listCounts[selectList[index]].toString()),
                                      onTap: () => changeListValue(selectList[index]),
                                    );
                                  }),
                            ),
                          ),
                        ),
                        SelectListWidget(
                          icon: Icons.check_circle,
                          text: 'Finished',
                          count: finishedListCount,
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
    FocusManager.instance.primaryFocus?.unfocus();
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
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
  }

  Future exitCheck(context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.35,
              margin: const EdgeInsets.fromLTRB(0, 12, 0, 220),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                  border: const Border.symmetric(
                      horizontal: BorderSide(width: 0.5, color: kOrange)),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/bg01.png'),
                      fit: BoxFit.fitWidth),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        // spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(1, 1)
                    ),
                  ]
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Stack(
                        children: [
                          SideButtonWidget(
                            width: 240,
                            onTap: (){
                              Navigator.of(context).pop();
                              titleController.clear();
                              descriptionController.clear();
                              noDate = 'Date not set';
                              addListTitle = 'Common';
                              activePage = 0;
                              mainPageController.initialPage = 0;
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const MainPage()));
                            },
                            child: Icon(Icons.check,
                              color: kOrange.withOpacity(0.7),
                              size: 40,),),
                          Positioned.fill(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 40),
                                  child: Text('Quit without saving?', style: kOrangeStyle,),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SideButtonWidget(
                        width: 150,
                        right: false,
                        child: Icon(Icons.cancel,
                          color: kOrange.withOpacity(0.7),
                          size: 40,),
                        onTap: () => Navigator.of(context).pop()),
                  ),
                  const SizedBox(height: 20,),
                ],
              )
          );
        });
  }

  Future editDeleteTask(int index, Box<ToDoModel> box, List<ToDoModel> tasks, context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.35,
              margin: const EdgeInsets.fromLTRB(0, 12, 0, 220),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                  border: const Border.symmetric(
                      horizontal: BorderSide(width: 0.5, color: kOrange)),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/bg01.png'),
                      fit: BoxFit.fitWidth),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        // spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(1, 1)
                    ),
                  ]
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Stack(
                        children: [
                          SideButtonWidget(
                            width: 200,
                            onTap: (){
                              isEdit = true;
                              editTask(
                                  index,
                                  tasks[index].task,
                                  tasks[index].description,
                                  tasks[index].date,
                                  tasks[index].time,
                                  tasks[index].list);
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) =>
                                      const AddTaskPage()));
                            },
                            child: Icon(Icons.edit,
                              color: kOrange.withOpacity(0.7),
                              size: 40,),),
                          Positioned.fill(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 40),
                                  child: Text('Edit task', style: kOrangeStyle,),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SideButtonWidget(
                        width: 120,
                        right: false,
                        child: Icon(Icons.cancel,
                          color: kOrange.withOpacity(0.7),
                          size: 40,),
                        onTap: () => Navigator.of(context).pop()),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Stack(
                        children: [
                          SideButtonWidget(
                            width: 240,
                            onTap: (){
                              box.deleteAt(index);
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.check,
                              color: kOrange.withOpacity(0.7),
                              size: 40,),),
                          Positioned.fill(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 40),
                                  child: Text('Delete task', style: kOrangeStyle,),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                ],
              )
          );
        });
  }

  void editToBase(int index, String task, String description, String date, String time, String list, Box<ToDoModel> box){
    box.putAt(index, ToDoModel()
        ..task = task
        ..description = description
        ..date = date == '0-0-0000' ? date : date.substring(0, 10)
        ..time = time.substring(10, 15)
        ..list = list
    );
  }

  void editTask(int index, String task, String description, String date, String time, String list){
    titleController.text = task;
    descriptionController.text = description;
    noDate = date;
    initialTime = TimeOfDay(
        hour: int.parse(time.substring(0, 2)),
        minute: int.parse(time.substring(3, 5)));
    addListTitle = list;
    editIndex = index;
    notifyListeners();
  }

  void doneTask(int index, Box<ToDoModel> box, List<ToDoModel> tasks, context) {
    box.putAt(index, ToDoModel()
      ..task = tasks[index].task
      ..description = tasks[index].description
      ..date = tasks[index].date
      ..time = tasks[index].time
      ..list = 'Finished');
  }

  Future showComment(int index, List<ToDoModel> tasks, context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.35,
              margin: const EdgeInsets.fromLTRB(0, 12, 0, 220),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                  border: const Border.symmetric(
                      horizontal: BorderSide(width: 0.5, color: kOrange)),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/bg01.png'),
                      fit: BoxFit.fitWidth),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        // spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(1, 1)
                    ),
                  ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: SideButtonWidget(
                        width: 80,
                        right: false,
                        child: Icon(Icons.cancel,
                          color: kOrange.withOpacity(0.7),
                          size: 40,),
                        onTap: () => Navigator.of(context).pop()),
                  ),
                  FadeContainerWidget(
                    height: 0.2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Text(tasks[index].description,
                            style: kWhiteStyle),
                        ),
                      ),),
                ],
              )
          );
        });
  }
}


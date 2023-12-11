import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:today/pages/add_dayly_page.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../model/daily_model.dart';
import '../model/percent_model.dart';
import '../widgets/fade_container_widget.dart';
import '../widgets/side_button_widget.dart';

class DailyProvider with ChangeNotifier {

  List<int> done = [];
  List<int> totalPercents = [];
  List<PercentModel> percents = [];
  String productivity = '0';
  List<int> all = [];
  List<int> percentage = [];
  String timeText = '00:00:00';
  int howMany = 1;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  ScrollController scrollController = ScrollController();
  int editIndex = 0;
  bool isEdit = true;

  Future addToBase() async {
    int done = 0;
    final task = DailyModel()
      ..task = titleController.text.trim()
      ..description = descriptionController.text.trim()
      ..howMany = howMany
      ..done = done
      ..day = DateTime.now().day
      ..dateTime = DateTime.now().toString();
    final box = Boxes.addDailyToBase();
    box.add(task);
  }

  void resetTask(int index, int howMany, Box<DailyModel> box, List<DailyModel> tasks, context) {
    box.putAt(index, DailyModel()
      ..task = tasks[index].task
      ..description = tasks[index].description
      ..howMany = howMany
      ..done = 0
      ..day = DateTime.now().day
      ..dateTime = DateTime.now().toString());
  }

  String totalPercent(){
    if(percents.isNotEmpty){
      for(var p in percents){
        totalPercents.add(p.percent);
      }
      var sum = totalPercents.reduce((a, b) => a + b);
      return productivity =  (sum / totalPercents.length).toStringAsFixed(0);
    }else{
      return '';
    }
  }

  Future percentToBase(List<DailyModel> tasks) async{
    for(var d in tasks){
      done.add(d.done);
    }
    for(var h in tasks){
      all.add(h.howMany);
    }
    for (int i = 0; i < done.length; i++) {
      int x = done[i];
      int y = all[i];
      final p = (x / y * 100).toInt();
      percentage.add(p);
    }
    var sum = percentage.reduce((a, b) => a + b);
    var percent = sum ~/ percentage.length;
    all.clear();
    done.clear();
    percentage.clear();

    final percents = PercentModel()
      ..percent = percent
      ..day = DateTime.now().day
      ..month = DateTime.now().month
      ..year = DateTime.now().year
      ..dateTime = DateTime.now().toString();
    final box = Boxes.addPercentToBase();
    if (box.containsKey(DateTime.now().day)) {
    }else{
      await box.add(percents);
    }

  }

  void setNumber(int index){
    howMany = index + 1;
    notifyListeners();
  }

  void updateTask(int index, int done, int howMany, Box<DailyModel> box, List<DailyModel> tasks, context) {
    if(done < howMany){
      box.putAt(index, DailyModel()
        ..task = tasks[index].task
        ..description = tasks[index].description
        ..howMany = howMany
        ..done = done + 1
        ..day = DateTime.now().day
        ..dateTime = tasks[index].dateTime);
    }
  }

  Future editDeleteTask(int index, Box<DailyModel> box, List<DailyModel> daily, context) {
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
                      image: AssetImage('assets/images/bg02.png'),
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
                                  daily[index].task,
                                  daily[index].description,
                                  daily[index].howMany,
                                  daily[index].done,
                                  daily[index].day,
                                  daily[index].dateTime);
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) =>
                                  const AddDailyPage()));
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

  void editToBase(int index, String task, String description, int howMany, int done, int day, String dateTime, Box<DailyModel> box){
    box.putAt(index, DailyModel()
      ..task = task
      ..description = description
      ..howMany = howMany
      ..done = done
      ..day = day
      ..dateTime = dateTime
    );
  }

  void editTask(int index, String task, String description, int how, int done, int day, String dateTime){
    titleController.text = task;
    descriptionController.text = description;
    howMany = how;
    done = done;
    day = DateTime.now().day;
    dateTime = DateTime.now().toString();
    editIndex = index;
    notifyListeners();
  }

  Future showComment(int index, List<DailyModel> tasks, context) {
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
                      image: AssetImage('assets/images/bg02.png'),
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
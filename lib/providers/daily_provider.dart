import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../model/daily_model.dart';
import '../widgets/side_button_widget.dart';

class DailyProvider with ChangeNotifier {

  String timeText = '00:00:00';
  int howMany = 0;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future addToBase() async {
    int done = 0;
    final task =  DailyModel()
      ..task = titleController.text.trim()
      ..description = descriptionController.text.trim()
      ..howMany = howMany
      ..done = done;
    final box = Boxes.addDailyToBase();
    box.add(task);
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
        ..done = done + 1);
    }
  }

  Future deleteTask(int index, Box<DailyModel> box, context) {
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
                                  child: Text('Delete task?', style: orangeStyle,),
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


}
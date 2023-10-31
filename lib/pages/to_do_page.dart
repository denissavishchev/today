import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:today/model/to_do_model.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../providers/to_do_provider.dart';
import '../widgets/all_to_do_lists_widget.dart';
import '../widgets/side_button_widget.dart';
import 'add_task_page.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Consumer<ToDoProvider>(
          builder: (context, data, _){
            return Container(
              height: size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg01.png'),
                      fit: BoxFit.fitWidth)),
              child: BackdropFilter(
                  filter: ImageFilter.blur(
                  sigmaX: 0.1,
                  sigmaY: 0.1,
                ),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.07),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              SideButtonWidget(
                                both: true,
                                width: 220,
                                onTap: (){
                                  data.selectLists(context);
                                },
                                child: Icon(Icons.list,
                                  color: kOrange.withOpacity(0.7),
                                  size: 40,),),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 40.0),
                                      child: Text(data.listTitle, style: kOrangeStyle,),
                                    )),
                              ),
                            ],
                          ),
                          const Spacer(),
                          SideButtonWidget(
                            right: false,
                            onTap: (){
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                  const AddTaskPage()));
                            },
                            child: Icon(Icons.add,
                              color: kOrange.withOpacity(0.7),
                              size: 40,),)
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.02,),
                    Expanded(
                      child: ValueListenableBuilder<Box<ToDoModel>>(
                        valueListenable: Boxes.addTaskToBase().listenable(),
                        builder: (context, box, _){
                          final tasks = box.values.toList().cast<ToDoModel>();
                          data.listCounts = {'Common' : 0, 'Personal' : 0, 'Shopping' : 0, 'Wishlist' : 0, 'Work' : 0};
                          data.finishedListCount = 0;
                          for(var t in tasks){
                            data.lists.add(t.list);
                          }
                          for (var l in data.lists) {
                            if(l != 'Finished'){
                              data.listCounts[l] = (data.listCounts[l] ?? 0) + 1;
                            }else{
                              data.finishedListCount = data.finishedListCount + 1;
                            }
                          }
                          data.lists.clear();
                          return Container(
                            clipBehavior: Clip.hardEdge,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(24)),
                                gradient: LinearGradient(
                                    colors: [
                                      kOrange.withOpacity(0.1),
                                      Colors.transparent
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: const [0.1, 0.8]
                                )
                            ),
                            child: ScrollConfiguration(
                                behavior: const ScrollBehavior().copyWith(overscroll: false),
                                child: ListView.builder(
                                  padding: EdgeInsets.only(bottom: size.height * 0.12),
                                  itemCount: tasks.length,
                                  controller: data.scrollController,
                                  reverse: false,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    if(tasks[index].list == data.listTitle){
                                      return AllToDoLists(tasks: tasks, index: index, box: box,);
                                    }if (data.listTitle == 'All lists' && tasks[index].list != 'Finished'){
                                      return AllToDoLists(tasks: tasks, index: index, box: box,);
                                    } else{
                                      return Container();
                                    }
                                  },
                                )
                            ),
                          );
                        },
                      )
                    ),
                  ],
                ),
              ),
            );
          },
        )
    );
  }
}



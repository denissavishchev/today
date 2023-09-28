import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:today/model/to_do_model.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../providers/to_do_provider.dart';
import '../widgets/basic_container_widget.dart';
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
                      fit: BoxFit.cover)),
              child: BackdropFilter(
                  filter: ImageFilter.blur(
                  sigmaX: 0.1,
                  sigmaY: 0.1,
                ),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.07),
                    Row(
                      children: [
                        Stack(
                          children: [
                            SideButtonWidget(
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
                                    child: Text(data.listTitle, style: orangeStyle,),
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
                    SizedBox(height: size.height * 0.02,),
                    Expanded(
                      child: ValueListenableBuilder<Box<ToDoModel>>(
                        valueListenable: Boxes.addToBase().listenable(),
                        builder: (context, box, _){
                          final tasks = box.values.toList().cast<ToDoModel>();
                          return Container(
                            clipBehavior: Clip.hardEdge,
                            width: size.width * 0.9,
                            // height: size.height * 0.7,
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
                                    return BasicContainerWidget(
                                      height: 0.11,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: SizedBox(
                                                width: 100,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text(tasks[index].task,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(color: Colors.white,fontSize: 20),),
                                                    Text(tasks[index].time,
                                                      style: const TextStyle(color: kOrange, fontSize: 16),),
                                                    Text(tasks[index].date,
                                                      style: const TextStyle(color: kOrange, fontSize: 16),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(thickness: 2, color: kOrange.withOpacity(0.3),),
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: SizedBox(
                                                width: 180,
                                                height: 60,
                                                child: SingleChildScrollView(
                                                  child: Text(tasks[index].description,
                                                    style: const TextStyle(color: Colors.white, fontSize: 16),),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                            ),
                          );
                        },
                      )
                    ),
                    // FadeTextFieldWidget(
                    //     textEditingController: data.quickNoteController,
                    //     hintText: 'Quick note'),
                    // const SizedBox(height: 100,),
                  ],
                ),
              ),
            );
          },
        )
    );
  }
}

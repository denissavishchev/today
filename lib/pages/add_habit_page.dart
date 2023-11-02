import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today/providers/habit_provider.dart';
import '../constants.dart';
import '../widgets/fade_container_widget.dart';
import '../widgets/fade_textfield_widget.dart';
import '../widgets/side_button_widget.dart';
import 'main_page.dart';

class AddHabitPage extends StatelessWidget {
  const AddHabitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: Consumer<HabitProvider>(
            builder: (context, data, _) {
              return ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Container(
                    height: size.height,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/bg03.png'),
                            fit: BoxFit.cover)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 0.1,
                        sigmaY: 0.1,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.07),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SideButtonWidget(
                                  onTap: (){
                                    data.titleController.clear();
                                    data.descriptionController.clear();
                                    data.days = '00';
                                    activePage = 2;
                                    mainPageController.initialPage = 2;
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => const MainPage()));
                                  },
                                  child: Icon(Icons.arrow_back,
                                    color: kOrange.withOpacity(0.7),
                                    size: 40,),),
                                const SizedBox(width: 100,),
                                SideButtonWidget(
                                  width: 120,
                                  both: true,
                                  onTap: (){
                                    data.setTimer();
                                  },
                                  child: Icon(Icons.timer,
                                    color: data.isTimer
                                        ? kOrange.withOpacity(0.7)
                                        : kWhite.withOpacity(0.3),
                                    size: 40,),),
                              ],
                            ),
                            SizedBox(height: size.height * 0.06,),
                            FadeTextFieldWidget(
                              textEditingController: data.titleController,
                              hintText: 'Task',),
                            SizedBox(height: size.height * 0.06,),
                            FadeTextFieldWidget(
                              textEditingController: data.descriptionController,
                              hintText: 'Description',),
                            SizedBox(height: size.height * 0.06,),
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.6,
                                  child: FadeContainerWidget(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12.0),
                                      child: Row(
                                        children: [
                                          Text('Days: ${data.days.startsWith('0')
                                                ? data.days.substring(1)
                                                : data.days}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 128,
                                      height: 104,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black.withOpacity(0.5),
                                                blurRadius: 3,
                                                offset: const Offset(0, 2)
                                            ),
                                          ]
                                      ),
                                    ),
                                    Container(
                                        width: 122,
                                        height: 98,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(30)),
                                          gradient: LinearGradient(
                                              colors: [
                                                const Color(0xffbebebc).withOpacity(0.5),
                                                const Color(0xff1a1a18).withOpacity(0.8),
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              stops: const [0, 0.75]),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              width: 58,
                                              height: 98,
                                              child: ListWheelScrollView(
                                                onSelectedItemChanged: (index) {
                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                  data.setDays(index, true);
                                                },
                                                physics: const FixedExtentScrollPhysics(),
                                                itemExtent: 58,
                                                children: List.generate(10, (index){
                                                  return Container(
                                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xff91918f),
                                                        border:
                                                        Border.all(color: kOrange, width: 0.5),
                                                        borderRadius: const BorderRadius.all(
                                                            Radius.circular(25)),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                              color: Colors.black,
                                                              blurRadius: 3,
                                                              offset: Offset(0, 2)),
                                                          BoxShadow(
                                                              color: Color(0xff5e5e5c),
                                                              blurRadius: 1,
                                                              offset: Offset(0, -1)),
                                                        ]),
                                                    child: Center(child: Text('$index', style: kWhiteStyle,)),
                                                  );
                                                } ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 58,
                                              height: 98,
                                              child: ListWheelScrollView(
                                                onSelectedItemChanged: (index) {
                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                  data.setDays(index, false);
                                                },
                                                physics: const FixedExtentScrollPhysics(),
                                                itemExtent: 58,
                                                children: List.generate(10, (index){
                                                  return Container(
                                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xff91918f),
                                                        border:
                                                        Border.all(color: kOrange, width: 0.5),
                                                        borderRadius: const BorderRadius.all(
                                                            Radius.circular(25)),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                              color: Colors.black,
                                                              blurRadius: 3,
                                                              offset: Offset(0, 2)),
                                                          BoxShadow(
                                                              color: Color(0xff5e5e5c),
                                                              blurRadius: 1,
                                                              offset: Offset(0, -1)),
                                                        ]),
                                                    child: Center(child: Text('$index', style: kWhiteStyle,)),
                                                  );
                                                } ),
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 26,
                                ),
                              ],
                            ),
                            SizedBox(height: data.isTimer
                                ? size.height * 0.06
                                : size.height * 0.14,),
                            Visibility(
                              visible: data.isTimer,
                              child: FadeContainerWidget(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      Text('Time: ${(data.initTime.inMinutes % 60).toString().padLeft(2, '0')}'
                                          ':${(data.initTime.inSeconds % 60).toString().padLeft(2, '0')}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            const BorderRadius.all(Radius.circular(30)),
                                            gradient: LinearGradient(
                                                colors: [
                                                  const Color(0xffbebebc).withOpacity(0.5),
                                                  const Color(0xff1a1a18).withOpacity(0.8),
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                stops: const [0, 0.75]),
                                          ),
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () => data.showTimer(context),
                                              child: Container(
                                                width: 48,
                                                height: 48,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xff91918f),
                                                    border:
                                                    Border.all(color: kOrange, width: 0.5),
                                                    borderRadius: const BorderRadius.all(
                                                        Radius.circular(25)),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: Colors.black,
                                                          blurRadius: 3,
                                                          offset: Offset(0, 2)),
                                                      BoxShadow(
                                                          color: Color(0xff5e5e5c),
                                                          blurRadius: 1,
                                                          offset: Offset(0, -1)),
                                                    ]),
                                                child: Icon(
                                                  Icons.timelapse_rounded,
                                                  color: kOrange.withOpacity(0.7),
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          )),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.06,),
                            Padding(
                              padding: const EdgeInsets.only(left: 48.0),
                              child: Row(
                                children: [
                                  SideButtonWidget(
                                      both: true,
                                      width: 200,
                                      onTap: (){
                                        // data.addToBase();
                                        Navigator.of(context).pop();
                                        data.titleController.clear();
                                        data.descriptionController.clear();
                                        data.days = '00';
                                        activePage = 2;
                                        mainPageController.initialPage = 2;
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => const MainPage()));
                                      },
                                      child: Icon(Icons.upload, color: kOrange.withOpacity(0.8), size: 40,)),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}





import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today/providers/habit_provider.dart';
import '../constants.dart';
import '../widgets/all_habit_list_widget.dart';
import '../widgets/side_button_widget.dart';
import 'add_habit_page.dart';

class HabitPage extends StatelessWidget {
  const HabitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<HabitProvider>(
        builder: (context, data, _){
          return Container(
            height: size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg03.png'),
                    fit: BoxFit.fitWidth)),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 0.1,
                sigmaY: 0.1,
              ),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.07),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SideButtonWidget(
                        onTap: () {},
                        child: Icon(Icons.water_drop,
                          color: kOrange.withOpacity(0.7),
                          size: 40,),),
                      SideButtonWidget(
                        both: true,
                        width: 90,
                        onTap: () {},
                        child: Icon(Icons.flag,
                          color: kOrange.withOpacity(0.7),
                          size: 40,),),
                      SideButtonWidget(
                        width: 100,
                        right: false,
                        onTap: () =>
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) =>
                              const AddHabitPage())),
                        child: Icon(Icons.add,
                          color: kOrange.withOpacity(0.7),
                          size: 40,),)
                    ],
                  ),
                  SizedBox(height: size.height * 0.02,),
                  Expanded(
                    child: Container(
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
                            itemCount: data.names.length,
                            // controller: data.scrollController,
                            reverse: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return AllHabitListWidget(
                                name: data.names[index],
                                time: data.times[index],
                                totalTime: data.totalTimes[index],
                                isStarted: data.inProgress[index],
                                index: index,
                                onTap: () => data.isStarted(index),
                              );
                            },
                          )
                      ),
                    ),
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
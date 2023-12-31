import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:today/pages/habit_statistic_page.dart';
import 'package:today/providers/habit_provider.dart';
import 'package:today/widgets/description_widget.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../model/habit_model.dart';
import '../widgets/all_habit_list_widget.dart';
import '../widgets/icon_svg_widget.dart';
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
          return ValueListenableBuilder(
              valueListenable: Boxes.addHabitToBase().listenable(),
              builder: (context, box, _){
                final habits = box.values.toList().cast<HabitModel>();
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
                        SizedBox(height: size.height * 0.07.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SideButtonWidget(
                              onTap: () =>
                                Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) =>
                                const HabitStatisticPage())),
                                  child: const IconSvgWidget(icon: 'history', padding: 4,),),
                            const Spacer(),
                            SideButtonWidget(
                              width: 100,
                              right: false,
                              onTap: () =>
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) =>
                                      const AddHabitPage())),
                              child: const IconSvgWidget(icon: 'add'),)
                          ],
                        ),
                        SizedBox(height: size.height * 0.02.h,),
                        Expanded(
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            width: size.width,
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
                            child: habits.isEmpty
                              ? const DescriptionWidget(
                                description: 'Create the right habits and train them every day to perfection')
                              : ScrollConfiguration(
                                behavior: const ScrollBehavior().copyWith(overscroll: false),
                                child: ListView.builder(
                                  padding: EdgeInsets.only(bottom: size.height * 0.12.h),
                                  itemCount: habits.length,
                                  // controller: data.scrollController,
                                  reverse: false,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    if(data.times.length < habits.length){
                                      data.times.add(0);
                                      data.inProgress.add(false);
                                      data.cancel.add(false);
                                    }
                                    if(habits[index].currentDay != DateTime.now().day){
                                      data.resetTask(index, box, habits, context);
                                    }
                                    return AllHabitListWidget(
                                      box: box,
                                      time: data.times[index],
                                      isStarted: data.inProgress[index],
                                      index: index,
                                      onTap: () => data.isStarted(index, box, habits, context),
                                      habits: habits,
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
              });
        },
      )
    );
  }
}

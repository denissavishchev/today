import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:today/model/habit_storage_model.dart';
import 'package:today/widgets/all_habit_statistic_lists_widget.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../providers/habit_provider.dart';
import '../widgets/side_button_widget.dart';
import 'main_page.dart';

class HabitStatisticPage extends StatelessWidget {
  const HabitStatisticPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(body: Consumer<HabitProvider>(
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
                      padding: EdgeInsets.only(top: size.height * 0.07.h),
                      child: ValueListenableBuilder<Box<HabitStorageModel>>(
                        valueListenable: Boxes.addHabitStorageToBase().listenable(),
                        builder: (context, box, _){
                          final storages = box.values.toList().cast<HabitStorageModel>();
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SideButtonWidget(
                                    onTap: () {
                                      activePage = 2;
                                      mainPageController.initialPage = 2;
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const MainPage()));
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: kOrange.withOpacity(0.7),
                                      size: 40,
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              SizedBox(height: size.height * 0.02.h),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 4.w),
                                height: size.height * 0.8,
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
                                  ),),
                                child: ScrollConfiguration(
                                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                                  child: ListView.builder(
                                      itemCount: storages.length,
                                      itemBuilder: (context, index) {
                                        return AllHabitStatisticLists(
                                          storage: storages,
                                          index: index,
                                          box: box,
                                        );
                                      }),
                                ),
                              ),
                            ],
                          );
                        },
                      )
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

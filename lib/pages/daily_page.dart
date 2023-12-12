import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:today/pages/add_dayly_page.dart';
import 'package:today/pages/daily_timer_page.dart';
import 'package:today/widgets/description_widget.dart';
import 'package:today/widgets/icon_svg_widget.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../model/daily_model.dart';
import '../providers/daily_provider.dart';
import '../widgets/all_daily_lists_widget.dart';
import '../widgets/side_button_widget.dart';
import 'daily_statistic_page.dart';

class DailyPage extends StatelessWidget {
  const DailyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Consumer<DailyProvider>(
          builder: (context, data, _){
            return ValueListenableBuilder<Box<DailyModel>>(
                valueListenable: Boxes.addDailyToBase().listenable(),
                builder: (context, box, _){
                  final tasks = box.values.toList().cast<DailyModel>();
                  if(tasks.isNotEmpty && tasks.last.day != DateTime.now().day){
                    data.percentToBase(tasks);
                  }
                  return Container(
                    height: size.height,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/bg02.png'),
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
                                      const DailyStatisticPage())),
                                child: const IconSvgWidget(icon: 'analytics', padding: 6,),),
                              SideButtonWidget(
                                both: true,
                                width: 90,
                                onTap: () => Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) =>
                                    const TimerPage())),
                                child: const IconSvgWidget(icon: 'hourglass'),),
                              SideButtonWidget(
                                width: 100,
                                right: false,
                                onTap: () {
                                  data.isEdit = false;
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) =>
                                        const AddDailyPage()));},
                                child: const IconSvgWidget(icon: 'add'),)
                            ],
                          ),
                          SizedBox(height: size.height * 0.02.h),
                          Expanded(
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                width: size.width * 0.9.w,
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
                                child: tasks.isEmpty
                                  ? const DescriptionWidget(
                                    description: 'Create your personal list of every day’s routine and have time to get everything done')
                                  : ScrollConfiguration(
                                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                                    child: ListView.builder(
                                      padding: EdgeInsets.only(bottom: size.height * 0.12.h),
                                      itemCount: tasks.length,
                                      controller: data.scrollController,
                                      reverse: false,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        if(tasks[index].day != DateTime.now().day){
                                        data.resetTask(index, tasks[index].howMany, box, tasks, context);
                                      }
                                        return AllDailyLists(tasks: tasks, index: index, box: box,);
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
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:today/pages/add_dayly_page.dart';
import 'package:today/pages/timer_page.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../model/daily_model.dart';
import '../providers/daily_provider.dart';
import '../widgets/all_daily_lists_widget.dart';
import '../widgets/side_button_widget.dart';

class DailyPage extends StatelessWidget {
  const DailyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Consumer<DailyProvider>(
          builder: (context, data, _){
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
                    SizedBox(height: size.height * 0.07),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SideButtonWidget(
                          onTap: (){

                          },
                          child: Icon(Icons.insights,
                            color: kOrange.withOpacity(0.7),
                            size: 40,),),
                        SideButtonWidget(
                          both: true,
                          width: 90,
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) =>
                              const TimerPage())),
                          child: Icon(Icons.access_alarm,
                            color: kOrange.withOpacity(0.7),
                            size: 40,),),
                        SideButtonWidget(
                          width: 100,
                          right: false,
                          onTap: () =>
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                const AddDailyPage())),
                          child: Icon(Icons.add,
                            color: kOrange.withOpacity(0.7),
                            size: 40,),)
                      ],
                    ),
                    SizedBox(height: size.height * 0.02,),
                    Expanded(
                        child: ValueListenableBuilder<Box<DailyModel>>(
                          valueListenable: Boxes.addDailyToBase().listenable(),
                          builder: (context, box, _){
                            final tasks = box.values.toList().cast<DailyModel>();
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
                                        return AllDailyLists(tasks: tasks, index: index, box: box,);

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
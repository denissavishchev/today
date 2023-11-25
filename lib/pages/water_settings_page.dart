import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:today/model/water_model.dart';
import 'package:today/providers/hive_provider.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../providers/water_provider.dart';
import '../widgets/fade_container_widget.dart';
import '../widgets/side_button_widget.dart';
import 'main_page.dart';

class WaterSettingsPage extends StatelessWidget {
  const WaterSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: Consumer2<WaterProvider, HiveProvider>(
            builder: (context, data, hiveData, _) {
              return ValueListenableBuilder(
                  valueListenable: Boxes.addWaterSettingsToBase().listenable(),
                  builder: (context, box, _){
                    final settings = box.values.toList().cast<WaterSettingsModel>();
                    return ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: SingleChildScrollView(
                        child: Container(
                          height: size.height,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/bg04.png'),
                                  fit: BoxFit.cover)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 0.1,
                              sigmaY: 0.1,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: size.height * 0.07.h),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SideButtonWidget(
                                        onTap: (){
                                          activePage = 3;
                                          mainPageController.initialPage = 3;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => const MainPage()));
                                        },
                                        child: Icon(Icons.arrow_back,
                                          color: kOrange.withOpacity(0.7),
                                          size: 40,),),
                                      const Spacer(),
                                          ],
                                        ),
                                  SizedBox(height: size.height * 0.01.h),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.44,
                                        child: FadeContainerWidget(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 12.w),
                                            child: const Row(
                                              children: [
                                                Text('Weight (kg)',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24),
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
                                            width: 192,
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
                                              width: 188,
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
                                                      controller: FixedExtentScrollController(
                                                          initialItem: settings.isEmpty
                                                          ? 0
                                                          : int.parse(settings[0].weight.toString().substring(0, 1))),
                                                      onSelectedItemChanged: (index) {
                                                        FocusManager.instance.primaryFocus?.unfocus();
                                                        data.setWeight(index, 0);
                                                      },
                                                      physics: const FixedExtentScrollPhysics(),
                                                      itemExtent: 58,
                                                      children: List.generate(10, (index){
                                                        return Container(
                                                          margin: EdgeInsets.symmetric(vertical: 4.w),
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
                                                      controller: FixedExtentScrollController(
                                                          initialItem: settings.isEmpty
                                                          ? 0
                                                          : int.parse(settings[0].weight.toString().substring(1, 2))),
                                                      onSelectedItemChanged: (index) {
                                                        FocusManager.instance.primaryFocus?.unfocus();
                                                        data.setWeight(index, 1);
                                                      },
                                                      physics: const FixedExtentScrollPhysics(),
                                                      itemExtent: 58,
                                                      children: List.generate(10, (index){
                                                        return Container(
                                                          margin: EdgeInsets.symmetric(vertical: 4.w),
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
                                                      }
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 58,
                                                    height: 98,
                                                    child: ListWheelScrollView(
                                                      controller: FixedExtentScrollController(
                                                          initialItem: settings.isEmpty
                                                          ? 0
                                                          : int.parse(settings[0].weight.toString().substring(2, 3))),
                                                      onSelectedItemChanged: (index) {
                                                        FocusManager.instance.primaryFocus?.unfocus();
                                                        data.setWeight(index, 2);
                                                      },
                                                      physics: const FixedExtentScrollPhysics(),
                                                      itemExtent: 58,
                                                      children: List.generate(10, (index){
                                                        return Container(
                                                          margin: EdgeInsets.symmetric(vertical: 4.w),
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
                                                      }
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 22.w),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.04.h,),
                                  FadeContainerWidget(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 12.w, right: 32.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Target',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,),),
                                            Text('${data.target}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 32,),),
                                          ],
                                        ),
                                      )
                                  ),
                                  SizedBox(height: size.height * 0.06.h),
                                  FadeContainerWidget(
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        Text('${data.initialWakeUpTime.hour < 10
                                            ? '0${data.initialWakeUpTime.hour}'
                                            : '${data.initialWakeUpTime.hour}'}'
                                            ':${data.initialWakeUpTime.minute < 10
                                            ? '0${data.initialWakeUpTime.minute}'
                                            : '${data.initialWakeUpTime.minute}'}',
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
                                                onTap: () => data.wakeUpTimePicker(context),
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
                                                            // spreadRadius: 2,
                                                            blurRadius: 3,
                                                            offset: Offset(0, 2)),
                                                        BoxShadow(
                                                            color: Color(0xff5e5e5c),
                                                            // spreadRadius: 2,
                                                            blurRadius: 1,
                                                            offset: Offset(0, -1)),
                                                      ]),
                                                  child: Icon(
                                                    Icons.watch_later_outlined,
                                                    color: kOrange.withOpacity(0.7),
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            )),
                                        SizedBox(width: 30.w),
                                      ],
                                    ),),
                                  SizedBox(height: size.height * 0.03.h),
                                  FadeContainerWidget(
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        Text('${data.initialBedTime.hour < 10
                                            ? '0${data.initialBedTime.hour}'
                                            : '${data.initialBedTime.hour}'}'
                                            ':${data.initialBedTime.minute < 10
                                            ? '0${data.initialBedTime.minute}'
                                            : '${data.initialBedTime.minute}'}',
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
                                                onTap: () => data.bedTimePicker(context),
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
                                                            // spreadRadius: 2,
                                                            blurRadius: 3,
                                                            offset: Offset(0, 2)),
                                                        BoxShadow(
                                                            color: Color(0xff5e5e5c),
                                                            // spreadRadius: 2,
                                                            blurRadius: 1,
                                                            offset: Offset(0, -1)),
                                                      ]),
                                                  child: Icon(
                                                    Icons.watch_later_outlined,
                                                    color: kOrange.withOpacity(0.7),
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            )),
                                        SizedBox(width: 30.w),
                                      ],
                                    ),),
                                  SizedBox(height: size.height * 0.03.h),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.76,
                                        child: FadeContainerWidget(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 12.w, right: 32.w),
                                            child: const Row(
                                              children: [
                                                Text('Interval (Hour)',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,),
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
                                            width: 64,
                                            height: 104,
                                            decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.5),
                                                borderRadius: const BorderRadius.all(Radius.circular(32)),
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
                                              width: 58,
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
                                              child: ListWheelScrollView(
                                                controller: FixedExtentScrollController(
                                                    initialItem: settings.isEmpty
                                                        ? 1
                                                        : int.parse(settings[0].interval.toString()) - 1),
                                                onSelectedItemChanged: (index) {
                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                  data.setInterval(index + 1);
                                                },
                                                physics: const FixedExtentScrollPhysics(),
                                                itemExtent: 58,
                                                children: List.generate(5, (index){
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
                                                    child: Center(child: Text('${index + 1}',
                                                      style: kWhiteStyle,)),
                                                  );
                                                } ),
                                              )
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 20.h,),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.02.h),
                                  Padding(
                                    padding: EdgeInsets.only(left: 48.w),
                                    child: Row(
                                      children: [
                                        SideButtonWidget(
                                            both: true,
                                            width: 200,
                                            onTap: () {
                                              data.addSettingsToBase(box);
                                              hiveData.addNotificationData(
                                                  data.initialWakeUpTime,
                                                  data.initialBedTime,
                                                  data.interval);
                                              activePage = 3;
                                              mainPageController.initialPage = 3;
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
                  });
            },
          )),
    );
  }
}





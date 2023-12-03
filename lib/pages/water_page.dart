import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:today/pages/water_statistic_page.dart';
import 'package:today/providers/water_provider.dart';
import 'package:today/widgets/icon_svg_widget.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../model/buttons_model.dart';
import '../model/water_daily_model.dart';
import '../model/water_model.dart';
import '../widgets/circular_background_painter.dart';
import '../widgets/drink_button.dart';
import '../widgets/only_button.dart';
import '../widgets/settings_button.dart';
import '../widgets/side_button_widget.dart';

class WaterPage extends StatelessWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<WaterProvider>(
        builder: (context, data, _){
          return ValueListenableBuilder(
              valueListenable: Boxes.addWaterSettingsToBase().listenable(),
              builder: (context, settingsBox, _){
                final settings = settingsBox.values.toList().cast<WaterSettingsModel>();
                data.target = settings.isEmpty ? 0 : settings[0].target;
                return ValueListenableBuilder(
                    valueListenable: Boxes.addWaterDailyToBase().listenable(),
                    builder: (context, box, _){
                      final daily = box.values.toList().cast<WaterDailyModel>();
                      if(daily.isNotEmpty && daily.last.dateMl != DateTime.now().day.toString()){
                        data.water = 0;
                        data.percent = 0;
                      }else if(daily.isNotEmpty){
                        data.water = daily.last.portionMl;
                        data.percent = daily.last.percentMl.toDouble();
                      }else{
                        data.water = 0;
                        data.percent = 0;
                      }
                      return Container(
                        height: size.height,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/bg04.png'),
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
                                        const WaterStatisticPage())),
                                    child: const IconSvgWidget(icon: 'history', padding: 4,),),
                                  const Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(right: 18.w),
                                    child: const SettingsButton(),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.02.h),
                              SizedBox(
                                width: size.width,
                                height: size.height * 0.36.h,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 2),
                                        width: 276,
                                        height: 276,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(140)),
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
                                          child: CustomPaint(
                                            painter: CircularBackgroundPainter(),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 235,
                                      height: 235,
                                      child: CircularProgressIndicator(
                                        value: data.percent / 100,
                                        backgroundColor: kOrange.withOpacity(0.2),
                                        strokeWidth: 20,
                                        color: kOrange,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${daily.isEmpty
                                              || daily.last.dateMl != DateTime.now().day.toString()
                                              ? 0 : daily.last.percentMl}%', style: kOrangeStyle.copyWith(fontSize: 42),),
                                        Text('${daily.isEmpty
                                              || daily.last.dateMl != DateTime.now().day.toString()
                                              ? 0 : daily.last.portionMl}/${data.target}', style: kOrangeStyle.copyWith(fontSize: 38),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.04.h),
                              ValueListenableBuilder(
                                valueListenable: Boxes.addButtonToBase().listenable(),
                                  builder: (context, buttonsBox, _){
                                    final buttons = buttonsBox.values.toList().cast<ButtonsModel>();
                                    return Column(
                                      children: [
                                        SizedBox(
                                          width: size.width,
                                          height: 60,
                                          child: SingleChildScrollView(
                                            physics: const ScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left: 4.w),
                                                  child: ListView.builder(
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: buttons.length,
                                                      itemBuilder: (context, index){
                                                        return Padding(
                                                          padding: EdgeInsets.only(right: 4.w),
                                                          child: DrinkButton(
                                                            onLongPress: () {
                                                              data.deleteMl(index, context, buttonsBox);
                                                            },
                                                            onTap: () => data.addPortionToBase(
                                                                buttons[index].buttons, box,
                                                                daily.isNotEmpty
                                                                    ? daily.last.dateMl.toString()
                                                                    : DateTime.now().day.toString()),
                                                            quantity: '${buttons[index].buttons}',
                                                          ),
                                                        );
                                                      }
                                                  ),
                                                ),
                                                OnlyButton(
                                                  onTap: () => data.createMl(
                                                      context, true, box,
                                                      daily.isNotEmpty
                                                      ? daily.last.dateMl.toString()
                                                      :DateTime.now().day.toString()),
                                                  icon: 'assets/icons/add.svg',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 40.h),
                                        DrinkButton(
                                            onLongPress: (){},
                                            onTap: () => data.createMl(
                                                context, false, box,
                                                daily.isNotEmpty
                                                    ? daily.last.dateMl.toString()
                                                    :DateTime.now().day.toString()),
                                            quantity: 'Custom'),
                                      ],
                                    );
                                  })
                            ],
                          ),
                        ),
                      );
                    });
              });
        },
      ),
    );
  }
}


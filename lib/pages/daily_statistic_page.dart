import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:today/providers/daily_provider.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../model/percent_model.dart';
import '../widgets/bar_widget.dart';
import '../widgets/side_button_widget.dart';
import 'main_page.dart';

class DailyStatisticPage extends StatelessWidget {
  const DailyStatisticPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: Consumer<DailyProvider>(
        builder: (context, data, _) {
          return ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Container(
                height: size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/bg02.png'),
                        fit: BoxFit.cover)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 0.1,
                    sigmaY: 0.1,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.07),
                    child: ValueListenableBuilder<Box<PercentModel>>(
                      valueListenable: Boxes.addPercentToBase().listenable(),
                      builder: (context, box, _){
                        final percents = box.values.toList().cast<PercentModel>();
                        percents.sort((b, a) => a.dateTime.compareTo(b.dateTime));
                        data.percents = percents;
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SideButtonWidget(
                                  onTap: () {
                                    activePage = 1;
                                    mainPageController.initialPage = 1;
                                    Navigator.push(
                                        context,
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
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 18.0),
                                      child: SideButtonWidget(
                                          width: 250,
                                          both: true,
                                          child: Center(
                                              child: Text(data.totalPercent(),
                                                style: const TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                    color: kOrange),)),
                                          onTap: () {}),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 40.0),
                                            child: Text('Productivity', style: kOrangeStyle,),
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Container(
                                clipBehavior: Clip.hardEdge,
                                margin: const EdgeInsets.symmetric(horizontal: 8),
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
                                      itemCount: percents.length < 33 ? percents.length : 33,
                                      itemBuilder: (context, index) {
                                        return BarWidget(
                                          day: '${percents[index].day}.${percents[index].month}',
                                          percent: percents[index].percent,
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

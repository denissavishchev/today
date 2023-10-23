import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../model/percent_model.dart';
import '../providers/to_do_provider.dart';
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
          body: Consumer<ToDoProvider>(
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SideButtonWidget(
                                  onTap: (){
                                    activePage = 1;
                                    mainPageController.initialPage = 1;
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
                            SizedBox(height: size.height * 0.06,),
                            ValueListenableBuilder<Box<PercentModel>>(
                              valueListenable: Boxes.addPercentToBase().listenable(),
                              builder: (context, box, _){
                                final percents = box.values.toList().cast<PercentModel>();
                                return SizedBox(
                                  height: size.height * 0.75,
                                  child: ListView.builder(
                                    itemCount: percents.length,
                                      itemBuilder: (context, index){
                                        return BarWidget(
                                          day: percents[index].day,
                                          percent: percents[index].percent,
                                          color: kOrange,);
                                      }),
                                );
                              },
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


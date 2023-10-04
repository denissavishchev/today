import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/daily_provider.dart';
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
                        Stack(
                          children: [
                            SideButtonWidget(
                              width: 160,
                              onTap: (){

                              },
                              child: Icon(Icons.list,
                                color: kOrange.withOpacity(0.7),
                                size: 40,),),
                            Positioned.fill(
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 40.0),
                                    child: Text('Title', style: orangeStyle,),
                                  )),
                            ),
                          ],
                        ),
                        SideButtonWidget(
                          both: true,
                          width: 70,
                          onTap: (){
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(builder: (context) =>
                            //     const AddTaskPage()));
                          },
                          child: Icon(Icons.access_alarm,
                            color: kOrange.withOpacity(0.7),
                            size: 40,),),
                        SideButtonWidget(
                          right: false,
                          onTap: (){
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(builder: (context) =>
                            //     const AddTaskPage()));
                          },
                          child: Icon(Icons.add,
                            color: kOrange.withOpacity(0.7),
                            size: 40,),)
                      ],
                    ),
                    SizedBox(height: size.height * 0.02,),
                  ],
                ),
              ),
            );
          },
        )
    );
  }
}
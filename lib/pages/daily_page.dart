import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today/pages/add_dayly_page.dart';

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
                        SideButtonWidget(
                          width: 90,
                          onTap: (){

                          },
                          child: Icon(Icons.list,
                            color: kOrange.withOpacity(0.7),
                            size: 40,),),
                        Stack(
                          children: [
                            SideButtonWidget(
                              both: true,
                              width: 160,
                              onTap: (){

                              },
                              child: Icon(Icons.access_alarm,
                                color: kOrange.withOpacity(0.7),
                                size: 40,),),
                            Positioned.fill(
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 24.0),
                                    child: Text('00:00', style: orangeStyle,),
                                  )),
                            ),
                          ],
                        ),
                        SideButtonWidget(
                          right: false,
                          onTap: (){
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                const AddDailyPage()));
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
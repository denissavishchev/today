import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/side_button_widget.dart';

class HabitPage extends StatelessWidget {
  const HabitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
              SizedBox(height: size.height * 0.07),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SideButtonWidget(
                    onTap: () {},
                    child: Icon(Icons.ac_unit,
                      color: kOrange.withOpacity(0.7),
                      size: 40,),),
                  SideButtonWidget(
                    both: true,
                    width: 90,
                    onTap: () {},
                    child: Icon(Icons.accessibility_sharp,
                      color: kOrange.withOpacity(0.7),
                      size: 40,),),
                  SideButtonWidget(
                    width: 100,
                    right: false,
                    onTap: () {},
                    child: Icon(Icons.account_balance_outlined,
                      color: kOrange.withOpacity(0.7),
                      size: 40,),)
                ],
              ),
              SizedBox(height: size.height * 0.02,),
              Expanded(
                child: Container(
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
                        itemCount: 10,
                        // controller: data.scrollController,
                        reverse: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(18),
                            width: 200,
                            height: 50,
                            color: Colors.grey.withOpacity(0.5),
                          );
                        },
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
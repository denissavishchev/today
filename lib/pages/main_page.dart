import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/main_provider.dart';
import '../widgets/bottom_nav_bar_widget.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Consumer<MainProvider>(builder: (context, data, _){
          return Stack(
            children: [
              ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: PageView.builder(
                    controller: data.mainPageController,
                    onPageChanged: (int index) => data.changePage(index),
                    itemCount: data.pages.length,
                    itemBuilder: (context, index) {
                      return data.pages[index % data.pages.length];
                    }),
              ),
              const BottomNavBarWidget(),
            ],
          );
        })
    );
  }
}



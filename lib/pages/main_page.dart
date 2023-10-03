import 'package:easy_localization/easy_localization.dart';
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
        body: Consumer<MainProvider>
          (builder: (context, data, _){
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
              Positioned(
                top: 20,
                  left: 200,
                  child: ElevatedButton(
                    onPressed: () {
                    context.setLocale(Locale('ru', 'RU'));
                  },
                    child: Text('ru'),
                  )),
              Positioned(
                  top: 60,
                  left: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      context.setLocale(Locale('en', 'US'));
                    },
                    child: Text('en'),
                  )),
            ],
          );
        })
    );
  }
}



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/main_provider.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      child: Consumer<MainProvider>(builder: (context, data, _){
        return Container(
          height: 70,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              border: const Border.symmetric(
                  horizontal: BorderSide(width: 0.2, color: kOrange)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 3)
                ),
              ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              data.pages.length, (index) =>
                GestureDetector(
                  onTap: (){
                    mainPageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  },
                  child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xffbebebc).withOpacity(0.5),
                              const Color(0xff1a1a18).withOpacity(0.8),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          stops: const [0, 0.75]
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xff91918f),
                            border: Border.all(
                                color: activePage == index
                                    ? kOrange
                                    : Colors.grey,
                                width: 0.5),
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                // spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 2)
                              ),
                              BoxShadow(
                                  color: Color(0xff5e5e5c),
                                  // spreadRadius: 2,
                                  blurRadius: 1,
                                  offset: Offset(0, -1)
                              ),
                            ]
                          ),
                          child: Icon(data.icon[index],
                            color: activePage == index
                                ? kOrange.withOpacity(0.7)
                                : kWhite,
                            size: 30,),
                        ),
                      )
                  ),
                ),
            ),
          ),
        );
      }
      ),
    );
  }
}

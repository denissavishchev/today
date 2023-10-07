import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/daily_provider.dart';
import '../widgets/fade_container_widget.dart';
import '../widgets/fade_textfield_widget.dart';
import '../widgets/side_button_widget.dart';
import 'main_page.dart';

class AddDailyPage extends StatelessWidget {
  const AddDailyPage({Key? key}) : super(key: key);

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
                            FadeTextFieldWidget(
                              textEditingController: data.titleController,
                              hintText: 'Task',),
                            SizedBox(height: size.height * 0.06,),
                            FadeTextFieldWidget(
                              textEditingController: data.descriptionController,
                              hintText: 'Description',),
                            SizedBox(height: size.height * 0.1,),
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.76,
                                  child: const FadeContainerWidget(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('How many sets per day',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,),
                                        ),
                                      ],
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
                                          onSelectedItemChanged: (index) {
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            data.setNumber(index);
                                          },
                                          physics: const FixedExtentScrollPhysics(),
                                            itemExtent: 58,
                                            children: List.generate(10, (index){
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
                                                child: Center(child: Text('${index + 1}', style: selectStyle,)),
                                              );
                                            } ),
                                        )
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.1,),
                            Padding(
                              padding: const EdgeInsets.only(left: 48.0),
                              child: Row(
                                children: [
                                  SideButtonWidget(
                                      both: true,
                                      width: 200,
                                      onTap: (){
                                        data.addToBase();
                                        Navigator.of(context).pop();
                                        data.titleController.clear();
                                        data.descriptionController.clear();
                                        activePage = 1;
                                        mainPageController.initialPage = 1;
                                        Navigator.push(
                                            context,
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
            },
          )),
    );
  }
}





import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:today/widgets/icon_svg_widget.dart';
import '../constants.dart';
import '../providers/to_do_provider.dart';
import '../widgets/fade_container_widget.dart';
import '../widgets/fade_textfield_widget.dart';
import '../widgets/only_button.dart';
import '../widgets/side_button_widget.dart';
import 'main_page.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

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
                        image: AssetImage('assets/images/bg01.png'),
                        fit: BoxFit.cover)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 0.1,
                    sigmaY: 0.1,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.07.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SideButtonWidget(
                              onTap: (){
                                if (data.titleController.text != ''
                                    || data.descriptionController.text != ''){
                                  data.exitCheck(context);
                                }else{
                                  activePage = 0;
                                  mainPageController.initialPage = 0;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const MainPage()));
                                }
                              },
                              child: const IconSvgWidget(icon: 'back_arrow',)),
                            const Spacer(),
                          ],
                        ),
                        SizedBox(height: size.height * 0.03.h,),
                        FadeTextFieldWidget(
                          textEditingController: data.titleController,
                          hintText: 'Task',),
                        SizedBox(height: size.height * 0.03.h,),
                        FadeTextFieldWidget(
                          height: 0.2,
                          multiline: true,
                          textEditingController: data.descriptionController,
                          hintText: 'Description',),
                        SizedBox(height: size.height * 0.03.h,),
                        FadeContainerWidget(
                          child: Row(
                            children: [
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(data.noDate,
                                    style: kWhiteStyle,
                                  ),
                                  Visibility(
                                    visible: data.noDate == 'Date not set',
                                    child: Text(data.noNotification,
                                      style: kWhiteStyleSmall),
                                  )
                                ],
                              ),
                              const Spacer(),
                              OnlyButton(
                                onTap: () => data.datePicker(context),
                                icon: 'assets/icons/calendar.svg',
                              ),
                              SizedBox(width: 30.w),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.02.h),
                        Visibility(
                          visible: data.noDate != 'Date not set',
                          child: FadeContainerWidget(
                            child: Row(
                              children: [
                                const Spacer(),
                                Text('${data.initialTime.hour < 10
                                    ? '0${data.initialTime.hour}'
                                    : '${data.initialTime.hour}'}'
                                    ':${data.initialTime.minute < 10
                                    ? '0${data.initialTime.minute}'
                                    : '${data.initialTime.minute}'}',
                                  style: kWhiteStyle,
                                ),
                                const Spacer(),
                                Container(
                                    width: 60,
                                    height: 60,
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
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () => data.timePicker(context),
                                        child: Container(
                                          width: 48,
                                          height: 48,
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: const Color(0xff91918f),
                                              border:
                                              Border.all(color: kOrange, width: 0.5),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(25)),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.black,
                                                    // spreadRadius: 2,
                                                    blurRadius: 3,
                                                    offset: Offset(0, 2)),
                                                BoxShadow(
                                                    color: Color(0xff5e5e5c),
                                                    // spreadRadius: 2,
                                                    blurRadius: 1,
                                                    offset: Offset(0, -1)),
                                              ]),
                                          child: const IconSvgWidget(icon: 'time', padding: 0,),
                                        ),
                                      ),
                                    )),
                                SizedBox(width: 30.w),
                              ],
                            ),),
                        ),
                        SizedBox(height: size.height * 0.04.h,),
                        Padding(
                          padding: EdgeInsets.only(left: 18.w),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  SideButtonWidget(
                                    both: true,
                                    width: 220,
                                    onTap: (){
                                      data.addSelectLists(context);
                                    },
                                    child: const IconSvgWidget(icon: 'list'),),
                                  Positioned.fill(
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 40.w),
                                          child: Text(data.addListTitle, style: kOrangeStyle,),
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.04.h),
                        Padding(
                          padding: EdgeInsets.only(left: 48.w),
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
                                    data.noDate = 'Date not set';
                                    data.addListTitle = 'Common';
                                    activePage = 0;
                                    mainPageController.initialPage = 0;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const MainPage()));
                                  },
                                  child: const IconSvgWidget(icon: 'upload',),),
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







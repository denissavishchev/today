import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/to_do_provider.dart';
import '../widgets/side_button_widget.dart';
import 'add_task_page.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Consumer<ToDoProvider>(
          builder: (context, data, _){
            return Container(
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
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.07),
                    Row(
                      children: [
                        Stack(
                          children: [
                            SideButtonWidget(
                              width: 220,
                              onTap: (){
                                data.selectLists(context);
                              },
                              child: Icon(Icons.list,
                                color: kOrange.withOpacity(0.7),
                                size: 40,),),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 40.0),
                                    child: Text(data.listTitle, style: orangeStyle,),
                                  )),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SideButtonWidget(
                          right: false,
                          onTap: (){
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const AddTaskPage()));
                          },
                          child: Icon(Icons.add,
                            color: kOrange.withOpacity(0.7),
                            size: 40,),)
                      ],
                    ),
                    SizedBox(height: size.height * 0.02,),
                    Expanded(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        width: size.width * 0.9,
                        // height: size.height * 0.7,
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
                            child: Container(),
                            // child:
                            // StreamBuilder(
                            //   stream: null,
                            //   builder: (context, snapshot) {
                            //     if (!snapshot.hasData) {
                            //       return const Center(child: CircularProgressIndicator());
                            //     }
                            //     return ListView.builder(
                            //       padding: EdgeInsets.only(bottom: size.height * 0.12),
                            //       itemCount: 10,
                            //       controller: data.scrollController,
                            //       reverse: false,
                            //       shrinkWrap: true,
                            //       itemBuilder: (context, index) {
                            //         return BasicContainerWidget(
                            //           height: 0.1,
                            //           child: Padding(
                            //             padding: const EdgeInsets.symmetric(vertical: 8.0),
                            //             child: Row(
                            //               children: [
                            //                 Padding(
                            //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            //                   child: SizedBox(
                            //                     width: 100,
                            //                     child: Column(
                            //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //                       children: [
                            //                         Text('title',
                            //                           overflow: TextOverflow.ellipsis,
                            //                           style: const TextStyle(color: Colors.white,fontSize: 20),),
                            //                         Text('time',
                            //                           style: TextStyle(color:
                            //                           true
                            //                               ? kOrange
                            //                               : Colors.white,
                            //                               fontSize: 18),),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 VerticalDivider(thickness: 2, color: kOrange.withOpacity(0.3),),
                            //                 Align(
                            //                   alignment: Alignment.topCenter,
                            //                   child: SizedBox(
                            //                     width: 180,
                            //                     height: 60,
                            //                     child: SingleChildScrollView(
                            //                       child: Text('comment',
                            //                         style: const TextStyle(color: Colors.white, fontSize: 16),),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         );
                            //       },
                            //     );
                            //   },
                            // )
                        ),
                      ),
                    ),
                    // FadeTextFieldWidget(
                    //     textEditingController: data.quickNoteController,
                    //     hintText: 'Quick note'),
                    // const SizedBox(height: 100,),
                  ],
                ),
              ),
            );
          },
        )
    );
  }
}

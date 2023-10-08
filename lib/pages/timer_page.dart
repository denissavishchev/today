import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin{

  late AnimationController _controller;

  bool isPlaying = false;

  double progress = 1.0;

  // void notify(){
  //   if(countText == '0:00:00') {
  //     FlutterRingtonePlayer.playNotification();
  //   }
  // }

  String get countText{
    Duration count = _controller.duration! * _controller.value;
    return _controller.isDismissed
        ? '${_controller.duration!.inHours}:${(_controller.duration!.inMinutes % 60).toString()
        .padLeft(2, '0')}:${(_controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString()
        .padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 60));

    _controller.addListener(() {
      // notify();
      if(_controller.isAnimating){
        setState(() {
          progress = _controller.value;
        });
      }else{
        setState(() {
          progress = 1.0;
          setState(() {
            isPlaying = false;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size. height * 0.7,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 280,
                          height: 280,
                          decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(140)),
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
                            child: Container(
                              width: 260,
                              height: 260,
                              decoration: BoxDecoration(
                                  color: const Color(0xff91918f),
                                  border:
                                  Border.all(color: kOrange, width: 0.5),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(130)),
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
                              // child: Center(child: Icon(
                              //   Icons.circle,
                              //   color: kOrange,
                              //   size: 10,
                              // )),
                            ),
                          )),
                      SizedBox(
                        width: 220,
                        height: 220,
                        child: CircularProgressIndicator(
                          value: 1 - progress,
                          backgroundColor: kGrey,
                          strokeWidth: 20,
                          color: kOrange,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          if(_controller.isDismissed){
                            showModalBottomSheet(
                                context: context,
                                builder: (context){
                                  return SizedBox(
                                    height: 300,
                                    child: CupertinoTimerPicker(
                                      initialTimerDuration: _controller.duration!,
                                      onTimerDurationChanged: (time){
                                        setState(() {
                                          _controller.duration = time;
                                        });
                                      },
                                    ),
                                  );
                                });
                          }
                        },
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Text(countText,);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            if(_controller.isAnimating){
                              _controller.stop();
                              setState(() {
                                isPlaying = false;
                              });
                            }else{
                              _controller.reverse(from: _controller.value == 0
                                  ? 1.0
                                  : _controller.value);
                              setState(() {
                                isPlaying = true;
                              });
                            }
                          },
                          icon: isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),),
                      IconButton(
                          onPressed: () {
                            _controller.reset();
                            setState(() {
                              isPlaying = false;
                            });
                          },
                          icon: Icon(Icons.stop),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
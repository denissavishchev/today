import 'dart:ui';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/side_button_widget.dart';
import 'main_page.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin{

  late AnimationController _controller;

  bool isPlaying = false;

  double progress = 1.0;

  late AnimationController _animationController;

  void notify(){
    if(countText == '0:00:00') {
      FlutterRingtonePlayer.playNotification();
    }
  }

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
      notify();
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
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
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
                                    ),
                                  )),
                              SizedBox(
                                width: 235,
                                height: 235,
                                child: CircularProgressIndicator(
                                  value: 1 - progress,
                                  backgroundColor: kOrange.withOpacity(0.2),
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
                                    return Text(countText, style: orangeStyle.copyWith(fontSize: 42),);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                          SideButtonWidget(
                            width: 160,
                              both: true,
                              child: Center(
                                child: AnimatedIcon(
                                  icon: AnimatedIcons.pause_play,
                                  color: kOrange.withOpacity(0.7),
                                  size: 40,
                                  progress: _animationController,
                                ),
                              ),
                              onTap: (){
                                if(_controller.isAnimating && _animationController.isDismissed){
                                  _controller.stop();
                                  _animationController.forward();
                                  setState(() {
                                    isPlaying = false;
                                  });
                                }else{
                                  _animationController.reverse();
                                  _controller.reverse(from: _controller.value == 0
                                      ? 1.0
                                      : _controller.value);
                                  setState(() {
                                    isPlaying = true;
                                  });
                                }
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 40,),
                              SideButtonWidget(
                                both: true,
                                  width: 120,
                                  child: Icon(Icons.stop,
                                    color: kOrange.withOpacity(0.7),
                                    size: 40,),
                                  onTap: (){
                                    _controller.reset();
                                    setState(() {
                                      isPlaying = false;
                                    });
                                  }
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
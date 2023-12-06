import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kGreen = Color(0xffc4d60c);
const kGrey = Color(0xffd9c4ab);
const kOrange = Color(0xffff6600);
const kWhite = Color(0xfffefffd);

final kWhiteStyle = TextStyle(fontSize: 22.sp, color: kWhite, fontWeight: FontWeight.bold);
final kOrangeStyle = TextStyle(fontSize: 22.sp, color: kOrange.withOpacity(0.8), fontWeight: FontWeight.bold);
final kOrangeStyleSmall = TextStyle(fontSize: 13.sp, color: kOrange.withOpacity(0.8), fontWeight: FontWeight.bold);
final kWhiteStyleSmall = TextStyle(fontSize: 13.sp, color: kWhite, fontWeight: FontWeight.bold);
final kWhiteStyleBig = TextStyle(fontSize: 26.sp, color: kWhite, fontWeight: FontWeight.bold);

final pickerTheme = ThemeData(
  timePickerTheme: TimePickerThemeData(
    backgroundColor: Colors.grey.withOpacity(0.8),
    dialHandColor: kOrange.withOpacity(0.7),
    dialTextColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected) ? Colors.white : Colors.white),
    hourMinuteColor: MaterialStateColor.resolveWith((states) =>
    states.contains(MaterialState.selected) ? kOrange.withOpacity(0.7) : Colors.grey),
    hourMinuteTextColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected) ? Colors.white : kOrange.withOpacity(0.8)),
    hourMinuteShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    entryModeIconColor: kOrange,
    helpTextStyle: kWhiteStyleSmall,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
      backgroundColor: MaterialStateColor.resolveWith((states) => kOrange.withOpacity(0.8)),
    ),
  ),
);

PageController mainPageController = PageController(initialPage: 0);
int activePage = 0;
import 'package:flutter/material.dart';

const kBlue = Color(0xff4f9892);
const kPurple = Color(0xffd697bb);
const kGreen = Color(0xffc4d60c);
const kGrey = Color(0xffd9c4ab);
const kOrange = Color(0xffff6600);
const kWhite = Color(0xffd9d9d7);

const selectStyle = TextStyle( fontSize: 22, color: kWhite, fontWeight: FontWeight.bold);
final orangeStyle = TextStyle( fontSize: 22, color: kOrange.withOpacity(0.8), fontWeight: FontWeight.bold);
// const textStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: fontColor);
// final helpTextStyle = TextStyle(fontSize: 14, color: fontColor.withOpacity(0.7));

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
    helpTextStyle:
    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
      backgroundColor: MaterialStateColor.resolveWith((states) => kOrange.withOpacity(0.8)),
    ),
  ),
);
import 'package:flutter/material.dart';

class WaterProvider with ChangeNotifier {

  int water = 0;
  double percent = 0;

  void addWater(){
    water+=100;
    percent = (water / 3000) * 100;
    notifyListeners();
  }


}
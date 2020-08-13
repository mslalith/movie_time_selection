import 'package:flutter/material.dart' show ChangeNotifier;

class DayTimeProvider extends ChangeNotifier {
  DateTime _day = DateTime.now();
  DateTime get day => _day;

  DateTime _time = DateTime(0, 0, 0);
  DateTime get time => _time;

  double _price = 0.0;
  double get price => _price;

  void updateDay(DateTime day) {
    _day = day;
    notifyListeners();
  }

  void updateTime(DateTime time) {
    _time = time;
    notifyListeners();
  }

  void updatePrice(double price) {
    _price = price;
    notifyListeners();
  }
}
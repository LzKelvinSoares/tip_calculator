import 'package:flutter/material.dart';

class TipCalculatorModel extends ChangeNotifier {
  int _personCount = 1;
  double _billTotal = 0.0;
  double _tipPercentage = 0.0;

  double get billTotal => _billTotal;
  double get tipPercentage => _tipPercentage;
  int get personCount => _personCount;

  double get totalTip => _billTotal * _tipPercentage;

  double get totalPerPerson => (totalTip + _billTotal) / _personCount;

  void updateBillTotal(double total) {
    _billTotal = total;
    notifyListeners();
  }

  void updateTipPercentage(double percentage) {
    _tipPercentage = percentage;
    notifyListeners();
  }

  void updatePersonCount(int count) {
    _personCount = count;
    notifyListeners();
  }

  void increment() {
    updatePersonCount(_personCount + 1);
    notifyListeners();
  }

  void decrement() {
    if (_personCount > 1) {
      updatePersonCount(_personCount - 1);
      notifyListeners();
    }
  }
}
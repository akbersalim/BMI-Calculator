import 'dart:math';

import 'package:flutter/cupertino.dart';

class CalculatorBrain {
  CalculatorBrain({@required this.height, @required this.weight});

  final int height;
  final int weight;
  double _bmi;

  String calculateBMI() {
    print(height);
    print(weight);
    _bmi = weight.toDouble() / pow(height / 100, 2).toDouble();
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25)
      return 'OverWeight';
    else if (_bmi <= 18.5) return 'UnderWeight';
    return 'Normal';
  }

  String getInterpretation() {
    if (_bmi >= 25)
      return 'You need to work out';
    else if (_bmi <= 18.5) return 'Eat a Sandwich';
    return 'Good Job';
  }
}

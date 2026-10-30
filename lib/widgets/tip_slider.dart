
import 'package:flutter/material.dart';

class TipSlider extends StatelessWidget {
  const new({
    super.key,
    required this.tipPercentage,
    required this.onChanged
  });

  final double tipPercentage;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0.0,
      max: 0.5,
      label: '${(tipPercentage*100).round()}%',
      divisions: 5,
      value: tipPercentage, 
      onChanged: onChanged
    );
  }
}
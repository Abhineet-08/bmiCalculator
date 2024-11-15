library weight_slider;

import 'package:bmicalculator/controller/age/age_slider_background.dart';
import 'package:bmicalculator/controller/age/age_slider_internal.dart';
import 'package:flutter/material.dart';

class AgeSlider extends StatelessWidget {
  final int age;
  final int minAge;
  final int maxAge;
  final String unit;
  final double height;
  final ValueChanged<int> onChange;

  const AgeSlider(
      {super.key,
      this.age = 40,
      this.minAge = 10,
      this.maxAge = 110,
      this.unit = 'yr',
      this.height = 100,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return AgeBackground(
      age: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.isTight
              ? Container()
              : WeightSliderInternal(
                  minValue: minAge,
                  maxValue: maxAge,
                  value: age,
                  unit: unit,
                  onChange: onChange,
                  width: constraints.maxWidth,
                );
        },
      ),
    );
  }
}

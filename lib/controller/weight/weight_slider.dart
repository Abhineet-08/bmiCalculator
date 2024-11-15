library weight_slider;

import 'package:bmicalculator/controller/weight/weight_slider_background.dart';
import 'package:bmicalculator/controller/weight/weight_slider_internal.dart';
import 'package:flutter/material.dart';

class WeightSlider extends StatelessWidget {
  final int weight;
  final int minWeight;
  final int maxWeight;
  final String unit;
  final double height;
  final ValueChanged<int> onChange;

  const WeightSlider(
      {super.key,
      this.weight = 80,
      this.minWeight = 30,
      this.maxWeight = 130,
      this.unit = 'kg',
      this.height = 100,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return WeightBackground(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.isTight
              ? Container()
              : WeightSliderInternal(
                  minValue: minWeight,
                  maxValue: maxWeight,
                  value: weight,
                  unit: unit,
                  onChange: onChange,
                  width: constraints.maxWidth,
                );
        },
      ),
    );
  }
}

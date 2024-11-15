import 'package:bmicalculator/controller/height/height_slider_background.dart';
import 'package:bmicalculator/controller/height/height_slider_internal.dart';
import 'package:flutter/material.dart';

class HeightSlider extends StatelessWidget {
  final int height;
  final int minHeight;
  final int maxHeight;
  final String unit;
  final double width;
  final ValueChanged<int> onChange;

  const HeightSlider({
    super.key,
    this.height = 150,
    this.minHeight = 40,
    this.maxHeight = 250,
    this.unit = 'cm',
    this.width = 100,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return HeightBackground(
      height: width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.isTight
              ? Container()
              : HeightSliderInternal(
                  minValue: minHeight,
                  maxValue: maxHeight,
                  value: height,
                  unit: unit,
                  onChange: onChange,
                  width: constraints.maxWidth,
                );
        },
      ),
    );
  }
}

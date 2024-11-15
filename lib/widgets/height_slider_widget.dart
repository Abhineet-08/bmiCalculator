import 'package:bmicalculator/controller/height/height_slider.dart';
import 'package:flutter/material.dart';

class HeightSliderWidget extends StatefulWidget {
  const HeightSliderWidget({super.key, required this.onHeightSelected});
  final ValueChanged<int> onHeightSelected;

  @override
  HeightSliderWidgetAlter createState() => HeightSliderWidgetAlter();
}

class HeightSliderWidgetAlter extends State<HeightSliderWidget> {
  int height = 150; // Default height value

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getCardWidth(context) * 2,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Height (in cm)',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: HeightSlider(
                  height: height,
                  minHeight: 40,
                  maxHeight: 250,
                  onChange: (val) {
                    setState(() {
                      height = val;
                      widget.onHeightSelected(height);
                    });
                  },
                  unit: 'cm', // Optional
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getCardWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return width / 1.5;
    } else if (width < 1200) {
      return width / 3;
    } else {
      return width / 4;
    }
  }
}

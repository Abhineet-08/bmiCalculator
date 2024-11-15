import 'package:flutter/material.dart';

class HeightWidget extends StatefulWidget {
  final ValueChanged<double> onHeightSelected;
  const HeightWidget({super.key, required this.onHeightSelected});

  @override
  HeightWidgetState createState() => HeightWidgetState();
}

class HeightWidgetState extends State<HeightWidget> {
  var _height = 150.0; // Default height in cm
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: getCardWidth(context) * 2.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey[200],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Height Text
                Text(
                  'Height: ${_height.toStringAsFixed(1)} cm',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),

                // Slider to input height in cm inside the container
                Slider(
                  value: _height,
                  min: 50.0,
                  max: 250.0,
                  divisions: 200,
                  label: _height.toStringAsFixed(1),
                  onChanged: (double value) {
                    setState(() {
                      _height = value;
                      widget.onHeightSelected(_height);
                    });
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
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

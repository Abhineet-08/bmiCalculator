import 'package:bmicalculator/controller/age/age_slider.dart';
import 'package:bmicalculator/controller/weight/weight_slider.dart';
import 'package:flutter/material.dart';

class WeightAge extends StatefulWidget {
  const WeightAge({
    super.key,
    required this.onAgeSelected,
    required this.onWeightSelected,
  });
  final ValueChanged<double> onAgeSelected;
  final ValueChanged<double> onWeightSelected;

  @override
  WeightAndAge createState() => WeightAndAge();
}

class WeightAndAge extends State<WeightAge> {
  var weight = 70;
  var age = 25;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Weight Container
        Container(
          width: getCardWidth(context),
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Weight (in KG)',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: WeightSlider(
                      weight: weight,
                      minWeight: 40,
                      maxWeight: 120,
                      onChange: (val) {
                        if (weight != val) {
                          // Only update if value has changed
                          setState(() {
                            weight = val;
                            widget.onWeightSelected(weight as double);
                          });
                        }
                      },
                      unit: 'kg',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        // Age Container
        Container(
          width: getCardWidth(context),
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Age (in Years)',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: AgeSlider(
                      age: age,
                      minAge: 10,
                      maxAge: 110,
                      onChange: (val) {
                        if (age != val) {
                          // Only update if value has changed
                          setState(() {
                            age = val;
                            widget.onAgeSelected(age as double);
                          });
                        }
                      },
                      unit: 'yr',
                    ),
                  ),
                ),
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

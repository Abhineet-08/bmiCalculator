import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicInfo extends StatelessWidget {
  const BasicInfo({super.key});
  @override
  Widget build(BuildContext context) {
    double bmi = Get.arguments ?? 0;

    String category = _getBMICategory(bmi);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hi, user. Your BMI is:',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            bmi.toStringAsFixed(1), // Display BMI
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 32, color: Colors.blue),
          ),
          Text(
            category,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal weight';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }
}

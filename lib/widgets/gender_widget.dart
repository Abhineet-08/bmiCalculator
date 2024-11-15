import 'package:flutter/material.dart';

class GenderWidget extends StatefulWidget {
  final ValueChanged<String> onGenderSelected;

  const GenderWidget({super.key, required this.onGenderSelected});

  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  void selectGender(bool isMale) {
    setState(() {
      isMaleSelected = isMale;
      isFemaleSelected = !isMale;
      // Notify parent about the gender selection
      widget.onGenderSelected(isMale ? 'Male' : 'Female');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            selectGender(true);
          },
          child: Container(
            height: 200,
            width: getCardWidth(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: isMaleSelected ? Colors.blue : Colors.grey,
                width: 3,
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/male.png',
                  height: 150,
                  width: getCardWidth(context),
                ),
                const SizedBox(height: 15),
                Text(
                  'Male',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 25),
        InkWell(
          onTap: () {
            selectGender(false);
          },
          child: Container(
            height: 200,
            width: getCardWidth(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: isFemaleSelected ? Colors.pink : Colors.grey,
                width: 3,
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/female.png',
                  height: 150,
                  width: getCardWidth(context),
                ),
                const SizedBox(height: 15),
                Text(
                  'Female',
                  style: Theme.of(context).textTheme.labelLarge,
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

import 'package:flutter/material.dart';

class AgeBackground extends StatelessWidget {
  final Widget? child;
  final double? age;

  const AgeBackground({super.key, this.child, this.age});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: age,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(244, 244, 244, 1.0),
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: child,
        ),
        // SvgPicture.asset(
        //   'images/arrow.svg',
        //   package: 'weight_slider',
        //   color: Theme.of(context).primaryColor,
        // ),
      ],
    );
  }
}

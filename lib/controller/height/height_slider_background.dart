import 'package:flutter/material.dart';

class HeightBackground extends StatelessWidget {
  final Widget? child;
  final double? height;

  const HeightBackground({super.key, this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: height,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(244, 244, 244, 1.0),
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: child,
        ),
      ],
    );
  }
}

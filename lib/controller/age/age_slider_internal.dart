import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WeightSliderInternal extends StatelessWidget {
  final int minValue;
  final int maxValue;
  final int value;
  final String unit;
  final ValueChanged<int> onChange;
  final double width;
  final ScrollController scrollController;

  WeightSliderInternal({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.unit,
    required this.onChange,
    required this.width,
  }) : scrollController = ScrollController(
          initialScrollOffset: (value - minValue) * width / 3,
        );

  double get itemExtent => width / 3;

  int _indexToValue(int index) => minValue + (index - 1);

  @override
  Widget build(BuildContext context) {
    int itemCount = (maxValue - minValue) + 3;
    return NotificationListener<ScrollNotification>(
      onNotification: _onNotification,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemExtent: itemExtent,
        itemCount: itemCount,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          int itemValue = _indexToValue(index);
          bool isExtra = index == 0 || index == itemCount - 1;

          if (isExtra) {
            return Container();
          } else {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => _animateTo(itemValue, durationMillis: 50),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  itemValue != value
                      ? itemValue.toString()
                      : itemValue.toString() + unit,
                  style: _getTextStyle(context, itemValue),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  TextStyle _getDefaultTextStyle() {
    return const TextStyle(
      color: Color.fromRGBO(196, 197, 203, 1.0),
      fontSize: 14.0,
    );
  }

  TextStyle _getHighlightTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 28.0,
    );
  }

  TextStyle _getTextStyle(BuildContext context, int itemValue) {
    return itemValue == value
        ? _getHighlightTextStyle(context)
        : _getDefaultTextStyle();
  }

  bool _userStoppedScrolling(Notification notification) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle;
  }

  void _animateTo(int valueToSelect, {int durationMillis = 200}) {
    double targetExtent = (valueToSelect - minValue) * itemExtent;
    scrollController.animateTo(
      targetExtent,
      duration: Duration(milliseconds: durationMillis),
      curve: Curves.decelerate,
    );
  }

  int _offsetToMiddleIndex(double offset) => (offset + width / 2) ~/ itemExtent;

  int _offsetToMiddleValue(double offset) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    int middleValue = _indexToValue(indexOfMiddleElement);
    middleValue = math.max(minValue, math.min(maxValue, middleValue));

    return middleValue;
  }

  bool _onNotification(ScrollNotification notification) {
    int middleValue = _offsetToMiddleValue(notification.metrics.pixels);
    if (_userStoppedScrolling(notification)) {
      _animateTo(middleValue);
    }

    if (middleValue != value) {
      onChange(middleValue);
    }

    return true;
  }
}

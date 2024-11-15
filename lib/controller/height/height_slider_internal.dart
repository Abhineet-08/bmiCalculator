import 'dart:math' as math;

import 'package:flutter/material.dart';

class HeightSliderInternal extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int value;
  final String unit;
  final ValueChanged<int> onChange;
  final double width;

  const HeightSliderInternal({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.unit,
    required this.onChange,
    required this.width,
  });

  @override
  HeightSliderInternalState createState() => HeightSliderInternalState();
}

class HeightSliderInternalState extends State<HeightSliderInternal> {
  late ScrollController scrollController;
  late double itemExtent;

  @override
  void initState() {
    super.initState();
    itemExtent = widget.width / 7; // Display 7 values at once
    scrollController = ScrollController();
  }

  int _indexToValue(int index) =>
      widget.minValue +
      (index -
          3); // Adjusting the index to show 7 values, centered on the current value

  @override
  Widget build(BuildContext context) {
    // Initialize the scroll position to center the selected value
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double initialOffset = (widget.value - widget.minValue) * itemExtent;
      if (scrollController.hasClients &&
          scrollController.offset != initialOffset) {
        scrollController.jumpTo(initialOffset); // Jump to the correct position
      }
    });

    int itemCount =
        (widget.maxValue - widget.minValue) + 7; // Displaying 7 values
    return NotificationListener<ScrollNotification>(
      onNotification: _onNotification,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemExtent: itemExtent,
        itemCount: itemCount,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          int itemValue = _indexToValue(index);
          bool isExtra = index == 0 || index == itemCount - 1;

          if (isExtra) {
            return Container(); // Empty space at the edges
          } else {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => _animateTo(itemValue),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  itemValue != widget.value
                      ? itemValue.toString()
                      : itemValue.toString() + widget.unit,
                  style: _getTextStyle(context, itemValue),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  TextStyle _getTextStyle(BuildContext context, int itemValue) {
    return itemValue == widget.value
        ? TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 28.0,
          )
        : const TextStyle(
            color: Color.fromRGBO(196, 197, 203, 1.0),
            fontSize: 14.0,
          );
  }

  bool _userStoppedScrolling(Notification notification) {
    return notification is ScrollEndNotification;
  }

  _animateTo(int valueToSelect) {
    double targetExtent = (valueToSelect - widget.minValue) * itemExtent;
    scrollController.animateTo(
      targetExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  int _offsetToMiddleIndex(double offset) =>
      (offset + (itemExtent / 2)) ~/ itemExtent;

  int _offsetToMiddleValue(double offset) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    int middleValue = _indexToValue(indexOfMiddleElement);
    middleValue =
        math.max(widget.minValue, math.min(widget.maxValue, middleValue));

    return middleValue;
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int middleValue = _offsetToMiddleValue(notification.metrics.pixels);
      if (_userStoppedScrolling(notification)) {
        _animateTo(middleValue);
      }

      if (middleValue != widget.value) {
        widget.onChange(middleValue);
      }
    }

    return true;
  }
}

import 'package:flutter/widgets.dart';

class CustomTextScaler extends TextScaler {
  final double scaleFactor;

  const CustomTextScaler(this.scaleFactor);

  @override
  double get textScaleFactor => scaleFactor;

  @override
  double scale(double rawScale) {
    return rawScale * scaleFactor;
  }
}

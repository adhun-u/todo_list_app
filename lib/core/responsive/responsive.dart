import 'package:flutter/material.dart';

extension Responsive on BuildContext {
  MediaQueryData get mediaQueryData => MediaQuery.of(this);
  double get dWidth => mediaQueryData.size.width;
  double get dHeight => mediaQueryData.size.height;

  double fontSize(double desiredFontSize) {
    if (dWidth <= 350) {
      return desiredFontSize - 4;
    } else if (dWidth <= 600) {
      return desiredFontSize;
    } else if (dWidth > 600 && dWidth <= 1024) {
      return desiredFontSize + 2;
    } else {
      return desiredFontSize + 4;
    }
  }

  double iconSize(double desiredIconSize) {
    if (dWidth <= 350) {
      return desiredIconSize - 6;
    } else if (dWidth <= 600) {
      return desiredIconSize;
    } else if (dWidth > 600 && dWidth <= 1024) {
      return desiredIconSize + 3;
    } else {
      return desiredIconSize + 6;
    }
  }
}

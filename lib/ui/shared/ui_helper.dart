import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UIHelper {
  static const double _VerticalSpaceVerySmall = 5.0;
  static const double _VerticalSpaceSmall = 10.0;
  static const double _VerticalSpaceMedium = 20.0;
  static const double _VerticalSpaceLarge = 60.0;

  static const double _HorizontalSpaceVerySmall = 5.0;
  static const double _HorizontalSpaceSmall = 10.0;
  static const double _HorizontalSpaceMedium = 20.0;
  static const double _HorizontalSpaceLarge = 60.0;

  static const Widget verticalSpaceVerySmall =
      SizedBox(height: _VerticalSpaceVerySmall);
  static const Widget verticalSpaceSmall =
      SizedBox(height: _VerticalSpaceSmall);
  static const Widget verticalSpaceMedium =
      SizedBox(height: _VerticalSpaceMedium);
  static const Widget verticalSpaceLarge =
      SizedBox(height: _VerticalSpaceLarge);

  static const Widget horizontalSpaceVerySmall =
      SizedBox(width: _HorizontalSpaceVerySmall);
  static const Widget horizontalSpaceSmall =
      SizedBox(width: _HorizontalSpaceSmall);
  static const Widget horizontalSpaceMedium =
      SizedBox(width: _HorizontalSpaceMedium);
  static const Widget horizontalSpaceLarge =
      SizedBox(width: _HorizontalSpaceLarge);

  static final dateTimeFormat = DateFormat('HH:mm dd-MM-yyyy');
  static final timeFormat = DateFormat('HH:mm');

  static String formatDateTime(DateTime dateTime) {
    if (dateTime.isAfter(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0)) &&
        dateTime.isBefore(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59))) {
      return timeFormat.format(dateTime);
    } else {
      return dateTimeFormat.format(dateTime);
    }
  }
}

import 'package:flutter/material.dart';

class Styles {
  static ThemeData appTheme =
      ThemeData(primarySwatch: Colors.red, backgroundColor: Colors.grey[100]);

  static const horizontalPaddingDefault = 10.0;
  static const verticalPaddingDefault = 10.0;

  static const _textSizeLarge = 24.0;
  static const _textSizeDefault = 15.0;
  static const _textSizeMedium = 16.0;
  static const _textSizeSmall = 12.0;

  static final Color _textColorStrong = _hexToColor('000000');
  static final Color _textColorDefault = _hexToColor('003d33');
  static final Color _textColorFaint = _hexToColor('858585');
  static final Color _textColorVeryFaint = _hexToColor('909090');

  static final String _fontNameDefault = 'Montserrat';

  static final headerLarge = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeLarge,
    color: _textColorStrong,
  );

  static EdgeInsets screenContentPadding = EdgeInsets.only(
    left: Styles.horizontalPaddingDefault,
    right: Styles.horizontalPaddingDefault,
    top: Styles.verticalPaddingDefault,
  );

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }
}

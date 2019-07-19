import 'package:flutter/material.dart';

class Styles {
  static ThemeData appTheme = ThemeData(
    primaryColor: Colors.red,
    accentColor: Colors.grey[100],
  );

  static const horizontalPaddingDefault = 10.0;
  static const verticalPaddingDefault = 10.0;

  static const _textSizeLarge = 24.0;
  static const _textSizeDefault = 15.0;
  static const _textSizeMedium = 18.0;
  static const _textSizeSmall = 12.0;

  static final Color _textColorStrong = _hexToColor('000000');
  static final Color _textColorDefault = _hexToColor('003d33');
  static final Color _textColorFaint = _hexToColor('858585');
  static final Color _textColorVeryFaint = _hexToColor('909090');

  static final Color _textColorLink = _hexToColor('f7f5fa');

  static final Color _textColorDefaultContrast = _hexToColor('fffffe');
  static final Color _textColorLinkConstrast = _hexToColor('eee8fc');

  static final Color _textColorFormDefault = Colors.red;

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

  static final textDefault = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeDefault,
    color: _textColorDefault,
    height: 1.2,
  );

  static final textDefaultContrast = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeMedium,
    fontWeight: FontWeight.bold,
    color: _textColorDefaultContrast,
    height: 1.2,
  );

  static final textSmall = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeSmall,
    color: _textColorFaint,
    height: 1.2,
  );

  static final textSmallContrast = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeDefault,
    color: _textColorDefaultContrast,
    height: 1.2,
  );

  static final textLink = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeDefault,
    color: _textColorLink,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static final textFormField = TextStyle(
    color: _textColorFormDefault,
  );

  static final textFormFieldInput = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeMedium,
    fontWeight: FontWeight.bold,
    color: _textColorDefault,
    height: 1.2,
  );

  static final textFormFieldInputContrast = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeMedium,
    fontWeight: FontWeight.bold,
    color: _textColorDefaultContrast,
    height: 1.2,
  );

  static final textFormFieldContrast = TextStyle(
    color: _textColorDefaultContrast,
  );

  static final textFieldHeader = TextStyle(
    color: _textColorFormDefault,
    fontSize: _textSizeSmall,
    fontWeight: FontWeight.bold,
  );

  static final textFieldHeaderContrast = TextStyle(
    color: _textColorDefaultContrast,
    fontSize: _textSizeSmall,
    fontWeight: FontWeight.bold,
  );

  static final dropDownText = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeMedium,
    fontWeight: FontWeight.bold,
    color: _textColorDefault,
    height: 1.2,
  );

  static final textButton = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeMedium,
    color: appTheme.accentColor,
    fontWeight: FontWeight.w700,
  );

  static final textButtonContrast = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeMedium,
    color: Colors.red,
    fontWeight: FontWeight.w700,
  );

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }
}

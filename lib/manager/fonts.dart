import 'package:flutter/material.dart';

class FontManager {
  static TextStyle txtStyle(
          {Color? color,
          FontWeight? fontWeight,
          double? fontSize,
          double? height,
          TextOverflow? overflow,
          TextDecoration? decoration}) =>
      TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          height: height);
}

import 'package:flutter/material.dart';

const String _FONT_FAMILY = 'Inter';

class AppFontStyle {

  static TextStyle Bold =
  TextStyle(fontFamily: _FONT_FAMILY, fontWeight: FontWeight.w700);

  static TextStyle SemiBold =
  TextStyle(fontFamily: _FONT_FAMILY, fontWeight: FontWeight.w600);

  static TextStyle Medium =
  TextStyle(fontFamily: _FONT_FAMILY, fontWeight: FontWeight.w500);

  static TextStyle Regular =
  TextStyle(fontFamily: _FONT_FAMILY, fontWeight: FontWeight.w400);
}
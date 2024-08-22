import 'package:flutter/material.dart';
import '../colors/AppColors.dart';
import 'package:flutter/cupertino.dart';

class OutlineDecoration {
  static ButtonStyle outLineStyle = OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(36.0),
      ),
      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
      side: BorderSide(width: 1, color: AppColors.outlineBtnColor));

  static ButtonStyle outLineSelectedStyle = OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(36.0),
      ),
      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
      side: BorderSide(width: 1, color: AppColors.outlineBtnSelectedColor),
      elevation:8);
}

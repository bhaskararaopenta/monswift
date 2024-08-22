import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

InputDecoration editCircularTextProperty(
    {IconData? icon, String hitText = '',}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(28.0),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(28.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(28.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(28.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(28.0),
    ),
    fillColor: const Color.fromARGB(255, 255, 255, 1),
    filled: true,
    hintText: hitText,
    hintStyle: const TextStyle(color: Color.fromARGB( 255, 96, 108, 135)),
    counterText: '',
  );
}

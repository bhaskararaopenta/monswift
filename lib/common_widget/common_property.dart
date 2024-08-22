import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

InputDecoration editTextProperty(
    {IconData? icon, String hitText = '', String? svg, String? image}) {
  return InputDecoration(
    prefixIcon: svg == null
        ? icon == null
            ? image == null
                ? null
                : Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      image,
                      height: 10,
                    ),
                  )
            : Icon(icon)
        : Padding(
            padding: const EdgeInsets.fromLTRB(1, 15, 1, 15),
            child: SvgPicture.asset(
              svg,width: 20
            ),
          ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    fillColor: const Color.fromRGBO(255, 255, 255, 1),
    filled: true,
    hintText: hitText,
    hintStyle: const TextStyle(color: Color.fromARGB( 255, 96, 108, 135)),
    counterText: '',
    errorStyle: TextStyle(height: 0.1, fontSize: 10),
    errorMaxLines: 2,
  );
}


InputDecoration editTextMobileCodeProperty(
    {IconData? icon, String hitText = '', String? svg, String? image}) {
  return InputDecoration(
    prefixIcon: svg == null
        ? icon == null
            ? image == null
                ? null
                : Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      image,
                      height: 10,
                    ),
                  )
            : Icon(icon)
        : Padding(
            padding: const EdgeInsets.fromLTRB(1, 11, 1, 11),
            child: SvgPicture.asset(
              svg,width: 24,height: 24,
            ),
          ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    fillColor: const Color.fromRGBO(255, 255, 255, 1),
    filled: true,
    hintText: hitText,
    hintStyle: const TextStyle(color: Color.fromARGB( 255, 96, 108, 135)),
    counterText: '',
    errorStyle: TextStyle(height: 0.1, fontSize: 10),
    errorMaxLines: 2,
    contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
  );
}

InputDecoration editTextFadeProperty(
    {IconData? icon, String hitText = '', String? svg, String? image}) {
  return InputDecoration(
    prefixIcon: svg == null
        ? icon == null
        ? image == null
        ? null
        : Padding(
      padding: const EdgeInsets.all(4.0),
      child: Image.asset(
        image,
        height: 10,
      ),
    )
        : Icon(icon)
        : Padding(
      padding: const EdgeInsets.fromLTRB(1, 11, 1, 11),
      child: SvgPicture.asset(
        svg,width: 24,height: 24,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 243, 245, 248), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 243, 245, 248), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 243, 245, 248), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 243, 245, 248), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 243, 245, 248), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    fillColor: const Color.fromRGBO(255, 255, 255, 1),
    filled: true,
    hintText: hitText,
    hintStyle: const TextStyle(color: Color.fromARGB( 255, 96, 108, 135)),
    counterText: '',
    errorStyle: TextStyle(height: 0.1, fontSize: 10),
    errorMaxLines: 2,
    contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
  );
}

InputDecoration editTextMessage(
    {IconData? icon, String hitText = '', String? svg, String? image}) {
  return InputDecoration(
    prefixIcon: svg == null
        ? icon == null
            ? image == null
                ? null
                : Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      image,
                      height: 10,
                    ),
                  )
            : Icon(icon)
        : Padding(
            padding: const EdgeInsets.fromLTRB(1, 15, 1, 15),
            child: SvgPicture.asset(
              svg,width: 24,height: 24,
            ),
          ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB( 255, 219, 222, 228), width: 1.0), //<-- SEE HERE
      borderRadius: BorderRadius.circular(10.0),
    ),
    fillColor: const Color.fromRGBO(255, 255, 255, 1),
    filled: true,
    hintText: hitText,
    hintStyle: const TextStyle(color: Color.fromARGB( 255, 96, 108, 135)),
    counterText: '',
    errorStyle: TextStyle(height: 0.1, fontSize: 10),
    errorMaxLines: 2,
    contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
  );
}

bool isAtLeast18YearsOld(DateTime birthDate) {
  final today = DateTime.now();
  final age = today.year - birthDate.year;
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    return age > 18;
  }
  return age >= 18;
}
String getInitials(String user_name) {
  try {
    print(user_name);
    return user_name.isNotEmpty
        ? user_name
        .trim()
        .split(' ')
        .map((l) => l[0])
        .take(2)
        .join()
        .toUpperCase()
        : '';
  } catch (e) {}
  return '';
}

extension StringExtensions on String {
  String capitalize() {
    try {
      return "${this[0].toUpperCase()}${this.substring(1)}";
    } catch (e) {}
    ;
    return '';
  }
}

String? changeDate(String? date) {
  DateTime now = DateTime.parse(date ?? '');
  String formattedDate =
  DateFormat('dd/MM/yyyy, hh:mm a').format(now.toLocal());
  return formattedDate;
}
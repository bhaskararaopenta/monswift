import 'dart:async';
import 'dart:js';
import 'package:flutter/material.dart';

import '../router/router.dart';

class SessionTimeoutManager {
  static final SessionTimeoutManager _instance = SessionTimeoutManager._internal();
  Timer? _timer;
  Duration _timeoutDuration = Duration(seconds: 15);
  VoidCallback? _onTimeout;

  factory SessionTimeoutManager() {
    return _instance;
  }

  SessionTimeoutManager._internal();

  void configure({required Duration timeoutDuration, required VoidCallback onTimeout}) {
    _timeoutDuration = timeoutDuration;
    _onTimeout = onTimeout;
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer(_timeoutDuration, _onTimeout!);
  }

  void resetTimer() {
    startTimer();
  }

  void cancelTimer() {
    _timer?.cancel();
  }
}

import 'dart:async';

import 'package:flutter/foundation.dart';

class OpenAITimer {
  OpenAITimer._();

  static final OpenAITimer _instance = OpenAITimer._();

  // Limit of requests per minute
  final int _limitRPM = 5;

  // Number of requests made in the current minute
  int _currentRPM = 0;

  // Timestamp of the start of the current minute
  DateTime _currentMinuteStart = DateTime.now();

  // Timer to reset request count at the start of each minute
  late Timer _resetTimer;

  // Factory constructor to return the singleton instance
  factory OpenAITimer() {
    return _instance;
  }

  static void init() {
    _instance._startResetTimer();
  }

  // Method to track requests
  bool trackRequest() {
    _currentRPM++;

    // Check if the request limit has been reached
    if (_currentRPM > _limitRPM) {
      // Handle rate limit exceeded, you can throw an exception or handle it in some way
      debugPrint(
          'Rate limit exceeded. Please wait before making more requests.');
      return false;
    }

    // Proceed with the request
    debugPrint(
        'Request successful. Requests made in this minute: $_currentRPM');
    return true;
  }

  // Method to start the timer to reset request count at the start of each minute
  void _startResetTimer() {
    _resetTimer = Timer.periodic(const Duration(seconds: 60), (timer) {
      _currentMinuteStart = DateTime.now();
      _currentRPM = 0;
    });
  }

  // Method to calculate the number of seconds left before next request can be made
  int secondsUntilNextRequest() {
    if (_currentRPM > _limitRPM) {
      var now = DateTime.now();
      var secondsLeft = now.difference(_currentMinuteStart).inSeconds;
      return secondsLeft;
    } else {
      return 0;
    }
  }
}

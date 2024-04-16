import 'dart:async';

import 'package:flutter/foundation.dart';

class OpenAiTimer {
  OpenAiTimer._();

  static final OpenAiTimer _instance = OpenAiTimer._();

  // Limit of requests per minute
  final int _limitRPM = 3;

  // Number of requests made in the current minute
  int _currentRPM = 0;

  // Timestamp of the start of the current minute
  DateTime _currentMinuteStart = DateTime.now();

  // Timer to reset request count at the start of each minute
  late Timer _resetTimer;

  // Factory constructor to return the singleton instance
  factory OpenAiTimer() {
    // Start the timer to reset request count at the start of each minute
    _instance._startResetTimer();
    return _instance;
  }

  // Method to track requests
  bool trackRequest() {
    // Check if it's a new minute, if so, reset the request count
    if (DateTime.now().difference(_currentMinuteStart).inSeconds > 60) {
      _currentMinuteStart = DateTime.now();
      _currentRPM = 1;
    } else {
      _currentRPM++;
    }

    // Check if the request limit has been reached
    if (_currentRPM > _limitRPM) {
      // Handle rate limit exceeded, you can throw an exception or handle it in some way
      if (kDebugMode) {
        print('Rate limit exceeded. Please wait before making more requests.');
      }
      return false;
    }

    // Proceed with the request
    if (kDebugMode) {
      print('Request successful. Requests made in this minute: $_currentRPM');
    }
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
      var secondsLeft = now
          .difference(_currentMinuteStart)
          .inSeconds;
      return secondsLeft;
    } else {
      return 0;
    }
  }
}
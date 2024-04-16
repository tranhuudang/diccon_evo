import 'dart:async';
import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:wave_divider/wave_divider.dart';

class WaitTimerWidget extends StatefulWidget {
  final int initialNumber;

  WaitTimerWidget({required this.initialNumber});

  @override
  _WaitTimerWidgetState createState() => _WaitTimerWidgetState();
}

class _WaitTimerWidgetState extends State<WaitTimerWidget> {
  late int _currentNumber;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentNumber = widget.initialNumber;
    startCountdown();
  }

  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentNumber > 0) {
          _currentNumber--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const WaveDivider(),
          Text(
            'Wow, you are lighting fast, slow down so the machine can catch up. $_currentNumber seconds to continues.',
            style: const TextStyle(fontSize: 14),
          ),
          const WaveDivider(),
          16.height,
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class WaveAuto extends StatefulWidget {
  final double inputValue;
  const WaveAuto({Key? key, required this.inputValue}) : super(key: key);

  @override
  State<WaveAuto> createState() => _WaveAutoState();
}

class _WaveAutoState extends State<WaveAuto> {
  List<double> randomValues = [
    0,
    0,
    0,
    0,
    0,
  ]; // List to hold random values for each Container
  Timer? timer;

  List<Color> containerColors = [
    Colors.blue.shade600,
    Colors.blue.shade500,
    Colors.blue.shade400,
    Colors.blue.shade300,
    Colors.blue.shade200,
  ]; // Define a list of colors

  double randomDoubleWithTwoDecimal() {
    Random random = Random();
    double randomNumber = (random.nextDouble() * widget.inputValue) +
        1; // Generates a number between 1 and 100
    return double.parse(
      randomNumber.toStringAsFixed(2),
    ); // Returns with two decimal places
  }

  void generateRandomValues() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (Timer t) {
      List<double> updatedRandomValues = [];
      for (int i = 0; i < 5; i++) {
        double value = randomDoubleWithTwoDecimal();
        if (value < 30) {
          updatedRandomValues.add(0);
        } else {
          updatedRandomValues.add(value);
        }
      }
      setState(() {
        randomValues = updatedRandomValues;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    generateRandomValues();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        5,
            (index) => Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: containerColors[index],
              borderRadius: BorderRadius.circular(50),
            ),
            height: 50 +
                randomValues[index], // Set height based on randomValue at index
            width: 14,
          ),
        ),
      ),
    );
  }
}

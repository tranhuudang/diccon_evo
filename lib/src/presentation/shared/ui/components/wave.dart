import 'package:flutter/material.dart';
import 'dart:math';

class Wave extends StatefulWidget {
  final double inputValue;
  final bool isAuto;
  const Wave({Key? key, this.inputValue = 0, this.isAuto = false}) : super(key: key);

  @override
  State<Wave> createState() => _WaveState();
}

class _WaveState extends State<Wave> {
  double randomDoubleWithTwoDecimal() {
    Random random = Random();
    double randomNumber = (random.nextDouble() * widget.inputValue) +
        1; // Generates a number between 1 and 100
    return randomNumber;
  }

  Future<List<double>> generateRandomValues() async {
    List<double> updatedRandomValues = [];
    for (int i = 0; i < 5; i++) {
      double value = randomDoubleWithTwoDecimal();
      if (value < 30) {
        updatedRandomValues.add(0);
      } else {
        updatedRandomValues.add(value);
      }
    }
    return updatedRandomValues;
  }

  List<Color> containerColors = [
    Colors.blue.shade600,
    Colors.blue.shade500,
    Colors.blue.shade400,
    Colors.blue.shade300,
    Colors.blue.shade200,
  ]; // Define a list of colors
  List<double> initValues = [0, 0, 0, 0, 0];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: initValues,
      future: generateRandomValues(),
      builder: (context, AsyncSnapshot<List<double>> snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            snapshot.data?.length ?? 5,
                (index) => Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: containerColors[index],
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 40 + snapshot.data![index], // Set height based on randomValue at index
                width: 14,
              ),
            ),
          ),
        );
      },
    );
  }
}

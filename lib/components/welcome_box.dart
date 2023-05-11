import 'package:flutter/material.dart';

class WelcomeBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          color: Colors.amberAccent,
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        child: Column(
          children: const [
            SizedBox(height: 16.0),
            Text(
              'Welcome to the Diccon Evo',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Start exploring the world of words!',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

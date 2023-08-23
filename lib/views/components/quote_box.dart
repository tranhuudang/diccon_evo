
import 'package:flutter/material.dart';

import '../../properties.dart';

class WelcomeBox extends StatelessWidget {
  const WelcomeBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                  color: Colors.amberAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
              child: Text("hello"),
            ),
          ),
        ),
      ],
    );
  }
}

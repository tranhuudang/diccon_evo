import 'package:flutter/material.dart';

import '../../../essential/ui/essential.dart';

class ToEssentialWordView extends StatelessWidget {
  const ToEssentialWordView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 200,
        child: Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(32),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EssentialView()));
              },
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                height: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.blue),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1848",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "words to learn",
                    ),
                    Spacer(),
                    Text(
                      "1848 Essential English Words",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../../global.dart';

class WelcomeBox extends StatelessWidget {
  const WelcomeBox({super.key});

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int randomIndex = random.nextInt(Global.welcomeBackgrounds.length);
    String randomImagePath = Global.welcomeBackgrounds[randomIndex];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 170,
              //width: PlatformCheck.isMobile()? 360: 300,
              //padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  color: Colors.amberAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: AssetImage(randomImagePath),
                      errorBuilder: (context, ob, s) {
                        return const Image(
                          height: 170,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          image: AssetImage(
                              "assets/welcome/42e1de5e-994c-4ee2-813d-448be978b9ba.jpg"),
                        );
                      },
                    ),
                  ),
                   Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 170,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome to Diccon Evo',
                            style: GoogleFonts.alegreyaSansSc(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                const Shadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Start exploring the world of words!',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                      color: Colors.black,
                                      blurRadius: 1,
                                      offset: Offset(1, 1))
                                ]),
                          ),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

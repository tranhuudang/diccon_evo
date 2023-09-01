import 'package:diccon_evo/screens/essential/ui/learning.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/circle_button.dart';
import 'guidance_box.dart';
import '../../components/head_sentence.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EssentialView extends StatelessWidget {
  const EssentialView({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.oxygen(
        textStyle: const TextStyle(letterSpacing: .5, fontSize: 36));
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CircleButton(
                    iconData: Icons.arrow_back,
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ),

              /// Head sentence
              HeadSentence(listText: ["Nothing", "Worth Doing", "Ever", "Came Easy"],),

              /// Sub sentence
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 26),
                child: const Text(
                    "Mastering 3000 core English words fosters clear communication. "
                    "Enhanced vocabulary aids reading, writing, speaking, and understanding. "
                    "It facilitates meaningful interactions, empowers expression, "
                    "and broadens access to information and opportunities."),
              ),

              /// Function bar
              CircleButtonBar(
                children: [
                  CircleButton(
                    iconData:  FontAwesomeIcons.play,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LearningView()));
                    },
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  CircleButton(
                    iconData: Icons.repeat,
                    onTap: () {
                      print("button clicked");
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  CircleButton(
                    iconData: FontAwesomeIcons.heart,
                    onTap: () {
                      print("button clicked");
                    },
                  ),
                ],
              ),
              SizedBox(height: 32,),
              /// Guidance box
              const GuidanceBox(children: [
                Row(
                  children: [
                    Icon(Icons.play_arrow),
                    Text("Start to learn:"),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.play_arrow),
                    Text("Review:"),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.play_arrow),
                    Text("Strengthen:"),
                  ],
                ),
              ],)
            ],
          ),
        ),
      )),
    );
  }
}

class CircleButtonBar extends StatelessWidget {
  final List<Widget> children;
  const CircleButtonBar({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

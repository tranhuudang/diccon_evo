import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../models/3000.dart';
import '../../components/circle_button.dart';
import 'essential.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'learning_page_item.dart';

class LearningView extends StatefulWidget {
  const LearningView({super.key});

  @override
  State<LearningView> createState() => _LearningViewState();
}

class _LearningViewState extends State<LearningView> {
  @override
  void initState() {
    loadData("school-supplies");
    // TODO: implement initState
    super.initState();
  }



  loadData(String topic) async {
    final jsonString = await rootBundle.loadString('assets/3000/school-supplies.json');
    final jsonData = json.decode(jsonString);
    List<EssentialWord> essentialWords = [];

    for (var essentialData in jsonData[topic]!) {
      essentialWords.add(EssentialWord.fromJson(essentialData));
    }

    setState(() {
      _words = essentialWords;
    });
  }

  late List<EssentialWord> _words =[];
  var _pageViewController = PageController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleButton(
                      iconData: Icons.close,
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ),
              ),
              Container(
                height: 300,
                child: PageView.builder(
                  controller: _pageViewController,
                  itemCount: _words.length,
                  itemBuilder: (context, index) {
                    return LearningPageItem(
                      word: _words[index].english,
                      phonetic: _words[index].phonetic,
                      vietnamese: _words[index].vietnamese,
                    );
                  },
                ),
              ),
              CircleButtonBar(
                children: [
                  CircleButton(
                    iconData: FontAwesomeIcons.chevronLeft,
                    onTap: () {
                      _pageViewController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  CircleButton(
                    iconData: FontAwesomeIcons.chevronRight,
                    onTap: () {
                      _pageViewController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

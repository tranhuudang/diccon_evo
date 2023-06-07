import 'package:diccon_evo/components/header.dart';
import 'package:flutter/material.dart';

import '../components/setting_section.dart';
import '../global.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        icon: Icons.settings,
        title: "Settings",
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SettingSection(title: 'Dictionary Section', children: [
                Row(children: [
                  const Text("Number of synonyms"),
                  const SizedBox(
                    width: 8,
                  ),
                  DropdownButton<int>(

                    focusColor: Colors.white,
                    value: Global.numberOfSynonyms,
                    hint: const Text('Select a number'),
                    onChanged: (int? newValue) {
                      setState(() {
                        Global.numberOfSynonyms = newValue!;
                      });
                    },

                    items: [
                      DropdownMenuItem<int>(
                        value: 10,
                        child: Text(10.toString()),
                      ),
                      DropdownMenuItem<int>(
                        value: 20,
                        child: Text(20.toString()),
                      ),
                      DropdownMenuItem<int>(
                        value: 30,
                        child: Text(30.toString()),
                      ),
                    ],
                  ),
                ])
              ]),
              SettingSection(
                title: 'Reading Section',
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.text_increase),
                      Slider(
                          min: 0.1,
                          value: Global.readingFontSizeSliderValue,
                          onChanged: (newValue) {
                            setState(() {
                              Global.readingFontSizeSliderValue = newValue;
                              Global.readingFontSize = newValue * 70;
                              Global.saveSettings(
                                  Global.readingFontSize,
                                  Global.readingFontSizeSliderValue,
                                  Global.numberOfSynonyms);
                            });
                          }),
                    ],
                  ),
                  Text(
                    "Sample text that will be displayed on Reading.",
                    style: TextStyle(fontSize: Global.readingFontSize),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

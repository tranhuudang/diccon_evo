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
      appBar: Header(
        icon: Icons.settings,
        title: "Settings",
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SettingSection(
              title: 'Reading Section',
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.text_increase),
                    Slider(
                        min: 0.1,
                        value: Global.readingFontSizeSliderValue,
                        onChanged: (newValue) {
                          setState(() {
                            Global.readingFontSizeSliderValue = newValue;
                            Global.readingFontSize = newValue * 70;
                          });
                        })
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
    );
  }
}

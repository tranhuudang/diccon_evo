import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/screens/dictionary/cubit/word_history_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/local_traditions.dart';
import '../../commons/circle_button.dart';
import '../cubit/setting_cubit.dart';
import '../../../config/properties.dart';
import '../../../models/setting.dart';
import 'components/setting_section.dart';
import 'components/store_badge.dart';
import 'components/theme_mode_switcher.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<SettingCubit, Setting>(builder: (context, state) {
          SettingCubit settingCubit = context.read<SettingCubit>();
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Header
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: CircleButton(
                            iconData: Icons.arrow_back,
                            onTap: () {
                              Navigator.pop(context);
                            }),
                      ),
                      Text("Settings".i18n,
                          style: const TextStyle(fontSize: 28))
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SettingSection(title: "Common Section".i18n, children: [
                    /// Language switcher
                    Row(
                      children: [
                        Text("Language".i18n),
                        Tradition.widthSpacer,
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          width: 120,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(16),
                                focusColor: Colors.white,
                                value: state.language,
                                hint: Text('Select a language'.i18n),
                                onChanged: (String? newValue) {
                                  settingCubit.setLanguage(newValue!);
                                  settingCubit.saveSettings();
                                },
                                items: ["English", "Tiếng Việt"]
                                    .map(
                                      (value) => DropdownMenuItem<String>(
                                        alignment: Alignment.center,
                                        value: value,
                                        child: Text(value.toString()),
                                      ),
                                    )
                                    .toList()),
                          ),
                        ),
                      ],
                    ),
                    Tradition.heightSpacer,
                    /// Theme switcher
                     Row(
                       children: [
                         Text("Theme".i18n),
                         ThemeSwitcher(settingCubit: settingCubit,),
                       ],
                     ),
                    const Divider(),
                    Text("* The changes will become effective the next time you open the app.".i18n, style: const TextStyle(fontStyle: FontStyle.italic),)
                  ]),
                  SettingSection(
                    title: 'Dictionary Section'.i18n,
                    children: [
                      Row(children: [
                        Text("Number of synonyms".i18n),
                        Tradition.widthSpacer,
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          width: 60,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(16),
                                focusColor: Colors.white,
                                value: state.numberOfSynonyms,
                                hint: Text('Select a number'.i18n),
                                onChanged: (int? newValue) {
                                  settingCubit.setNumberOfSynonyms(newValue!);
                                  settingCubit.saveSettings();
                                },
                                items: [5, 10, 20, 30]
                                    .map(
                                      (value) => DropdownMenuItem<int>(
                                        alignment: Alignment.center,
                                        value: value,
                                        child: Text(value.toString()),
                                      ),
                                    )
                                    .toList()),
                          ),
                        ),
                      ]),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text("Number of antonyms".i18n),
                          Tradition.widthSpacer,
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).highlightColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            width: 60,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                  alignment: Alignment.center,
                                  borderRadius: BorderRadius.circular(16),
                                  isExpanded: true,
                                  focusColor: Colors.white,
                                  value: state.numberOfAntonyms,
                                  hint: Text('Select a number'.i18n),
                                  onChanged: (int? newValue) {
                                    settingCubit.setNumberOfAntonyms(newValue!);
                                    settingCubit.saveSettings();
                                  },
                                  items: [5, 10, 20, 30]
                                      .map((value) => DropdownMenuItem<int>(
                                            alignment: Alignment.center,
                                            value: value,
                                            child: Text(value.toString()),
                                          ))
                                      .toList()),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SettingSection(
                    title: 'Reading Section'.i18n,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.text_increase),
                          Slider(
                              min: 0.1,
                              value: state.readingFontSize / 70,
                              onChangeEnd: (newValue) {
                                settingCubit.saveSettings();
                              },
                              onChanged: (newValue) {
                                settingCubit.setReadingFontSize(newValue * 70);
                              }),
                        ],
                      ),
                      Text(
                        "Sample text that will be displayed on Reading.".i18n,
                        style: TextStyle(fontSize: state.readingFontSize),
                      )
                    ],
                  ),
                  SettingSection(
                    title: "About".i18n,
                    children: [
                      const Row(
                        children: [
                          Text("Diccon", style: TextStyle()),
                          Spacer(),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              const Text("© 2023 Zeroboy."),
                              const SizedBox(width: 5),
                              Text("All rights reserved.".i18n),
                            ],
                          ),
                          const Spacer(),
                          Text(Properties.version),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Text(
                        "Available at".i18n,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        height: 200,
                        width: 370,
                        child: GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          children: [
                            microsoftStoreBadge(),
                            amazonStoreBadge(),
                            playStoreBadge(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}


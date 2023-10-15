import 'package:diccon_evo/config/responsive.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/screens/commons/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../config/route_constants.dart';
import '../../../data/models/setting.dart';
import '../../commons/header.dart';
import '../cubit/setting_cubit.dart';
import 'components/setting_section.dart';
import 'components/theme_mode_switcher.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final settingCubit = SettingCubit();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<SettingCubit, Setting>(
            bloc: settingCubit,
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 60),
                    child: Responsive(
                      smallSizeDevice: body(context, state),
                      mediumSizeDevice: body(context, state),
                      largeSizeDevice: body(context, state),
                    ),
                  ),

                  /// Header
                  Header(title: "Settings".i18n),
                ],
              );
            }),
      ),
    );
  }

  Column body(BuildContext context, Setting state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SettingSection(title: "Common Section".i18n, children: [
          /// Language switcher
          Row(
            children: [
              Text("Language".i18n),
              const SizedBox().mediumWidth(),
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
          const SizedBox().mediumHeight(),

          /// Theme switcher
          Row(
            children: [
              Text("Theme".i18n),
              ThemeSwitcher(
                settingCubit: settingCubit,
              ),
            ],
          ),
          const SizedBox().mediumHeight(),
          
          const SizedBox().mediumHeight(),

          const Divider(),
          Text(
            "* The changes will become effective the next time you open the app."
                .i18n,
            style: const TextStyle(color: Colors.orange),
          )
        ]),
        SettingSection(
          title: 'Dictionary Section'.i18n,
          children: [
            Row(children: [
              Text("Number of synonyms".i18n),
              const SizedBox().mediumWidth(),
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
                const SizedBox().mediumWidth(),
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
            ),
            const Divider(),
            Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Customize dictionary responses".i18n)),
                const SizedBox().mediumHeight(),
                PillButton(
                    onTap: () {
                      context.pushNamed(RouterConstants.customDictionary);
                    },
                    title: "Customize"),
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
                    activeColor: Theme.of(context).primaryColor,
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
      ],
    );
  }
}

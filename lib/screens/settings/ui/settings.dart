import 'dart:async';

import 'package:diccon_evo/config/properties.dart';
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
import '../bloc/setting_bloc.dart';
import '../bloc/user_bloc.dart';
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
        backgroundColor: Theme.of(context).colorScheme.surface,
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
          const ThemeColorSelector(),
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
                    activeColor: Theme.of(context).colorScheme.primary,
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

class ThemeColorSelector extends StatefulWidget {
  const ThemeColorSelector({
    super.key,
  });

  @override
  State<ThemeColorSelector> createState() => _ThemeColorSelectorState();
}

class _ThemeColorSelectorState extends State<ThemeColorSelector> {
  final _selectController = StreamController<Color>();
  @override
  Widget build(BuildContext context) {
    final settingBloc = context.read<SettingBloc>();
    return StreamBuilder(
      stream: _selectController.stream,
      initialData: Color(Properties.defaultSetting.themeColor),
      builder: (context, selectedColor) {
        return Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Colors.red,
                Colors.pinkAccent,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.teal,
                Colors.blueAccent,
                Colors.purple,
                Colors.brown,
                Colors.grey
              ]
                  .map((currentColor) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: (){
                      _selectController.add(currentColor);
                      settingBloc.add(ChangeThemeColorEvent(color: currentColor));
                    },
                    child: Container(
                        height: 50, width: 50,
                        decoration: BoxDecoration(
                          color: currentColor,
                          border: selectedColor.data == currentColor ? Border.all(
                            color: Colors.white,
                            width: 3,
                          ) : null,
                          borderRadius: BorderRadius.circular(50),
                        )
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox().mediumHeight(),
            PillButton(onTap: (){
              settingBloc.add(EnableAdaptiveThemeColorEvent());
            }, title: "Use System Theme")
          ],
        );
      }
    );
  }
}

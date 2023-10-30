import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';

import '../../../../../common/data/models/setting.dart';
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final settingCubit = SettingCubit();
  @override
  Widget build(BuildContext context) {
    final settingBloc = context.read<SettingBloc>();
    return SafeArea(
      child: Scaffold(
        //backgroundColor: context.theme.colorScheme.surface,
        body: BlocBuilder<SettingCubit, Setting>(
            bloc: settingCubit,
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 60),
                    child: Responsive(
                      smallSizeDevice: body(context, state, settingBloc),
                      mediumSizeDevice: body(context, state, settingBloc),
                      largeSizeDevice: body(context, state, settingBloc),
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

  Column body(BuildContext context, Setting state, SettingBloc settingBloc) {
    final languageStreamController = StreamController<String>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Section(title: "Common Section".i18n, children: [
          /// Language switcher
          Row(
            children: [
              Text("Language".i18n),
              const HorizontalSpacing.medium(),
              Container(
                decoration: BoxDecoration(
                  color: context.theme.highlightColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: 170,
                child: StreamBuilder<String>(
                    stream: languageStreamController.stream,
                    initialData: Properties.defaultSetting.language,
                    builder: (context, languageState) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(16),
                            value: languageState.data,
                            hint: Text('Select a language'.i18n),
                            onChanged: (String? selectedLanguage) {
                              languageStreamController.add(selectedLanguage!);
                              settingBloc.add(ChangeLanguageEvent(
                                  language: selectedLanguage));
                            },
                            items: ["System default","English", "Tiếng Việt"]
                                .map(
                                  (value) => DropdownMenuItem<String>(
                                    alignment: Alignment.center,
                                    value: value,
                                    child: Text(value.i18n.toString()),
                                  ),
                                )
                                .toList()),
                      );
                    }),
              ),
            ],
          ),
          const VerticalSpacing.medium(),
          const Divider(),
          const VerticalSpacing.medium(),

          /// Theme switcher
          Row(
            children: [
              Text("Theme".i18n),
              const ThemeSwitcher(),
            ],
          ),
          const VerticalSpacing.medium(),
          const Divider(),
          const VerticalSpacing.medium(),
          const ThemeColorPalette(),
        ]),
        Section(
          title: 'Dictionary Section'.i18n,
          children: [
            Row(children: [
              Text("Number of synonyms".i18n),
              const HorizontalSpacing.medium(),
              Container(
                decoration: BoxDecoration(
                  color: context.theme.highlightColor,
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
                const HorizontalSpacing.medium(),
                Container(
                  decoration: BoxDecoration(
                    color: context.theme.highlightColor,
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
                const VerticalSpacing.medium(),
                FilledButton.tonal(
                    onPressed: () {
                      context.pushNamed(RouterConstants.dictionaryPreferences);
                    },
                    child: Text("Customize".i18n)),
              ],
            )
          ],
        ),
        Section(
          title: 'Reading Section'.i18n,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.text_increase),
                Slider(
                    activeColor: context.theme.colorScheme.primary,
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

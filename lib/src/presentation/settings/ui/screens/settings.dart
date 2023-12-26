import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/domain/domain.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wave_divider/wave_divider.dart';
import 'package:wavy_slider/wavy_slider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final languageStreamController = StreamController<String>();
  final settingCubit = SettingCubit();
  @override
  Widget build(BuildContext context) {
    final settingBloc = context.read<SettingBloc>();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<SettingCubit, Settings>(
            bloc: settingCubit,
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                      padding: const EdgeInsets.only(
                          top: 72, left: 16, right: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Section(title: "Common Section".i18n, children: [
                            /// Language switcher
                            Row(
                              children: [
                                Text("Language".i18n),
                                8.width,
                                Container(
                                  decoration: BoxDecoration(
                                    color: context.theme.highlightColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  width: 170,
                                  child: StreamBuilder<String>(
                                      stream: languageStreamController.stream,
                                      initialData:
                                          Properties.instance.settings.language,
                                      builder: (context, languageState) {
                                        return DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                              isExpanded: true,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              value: languageState.data,
                                              hint: Text(
                                                  'Select a language'.i18n),
                                              onChanged:
                                                  (String? selectedLanguage) {
                                                languageStreamController
                                                    .add(selectedLanguage!);
                                                settingBloc.add(
                                                    ChangeLanguageEvent(
                                                        language:
                                                            selectedLanguage));
                                              },
                                              items: [
                                                "System default",
                                                "English",
                                                "Tiếng Việt"
                                              ]
                                                  .map(
                                                    (value) => DropdownMenuItem<
                                                        String>(
                                                      alignment:
                                                          Alignment.center,
                                                      value: value,
                                                      child: Text(value.i18n
                                                          .toString()),
                                                    ),
                                                  )
                                                  .toList()),
                                        );
                                      }),
                                ),
                              ],
                            ),
                            8.height,

                            /// Theme switcher
                            Row(
                              children: [
                                Text("Theme".i18n),
                                const ThemeSwitcher(),
                              ],
                            ),
                            8.height,
                            const WaveDivider(
                              thickness: .3,
                            ),
                            8.height,
                            const ThemeColorPalette(),
                          ]),
                          Section(
                            title: 'Dictionary Section'.i18n,
                            children: [
                              Row(children: [
                                Text("Number of synonyms".i18n),
                                8.width,
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
                                          settingCubit
                                              .setNumberOfSynonyms(newValue!);
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
                              4.height,
                              Row(
                                children: [
                                  Text("Number of antonyms".i18n),
                                  8.width,
                                  Container(
                                    decoration: BoxDecoration(
                                      color: context.theme.highlightColor,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    width: 60,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<int>(
                                          alignment: Alignment.center,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          isExpanded: true,
                                          focusColor: Colors.white,
                                          value: state.numberOfAntonyms,
                                          hint: Text('Select a number'.i18n),
                                          onChanged: (int? newValue) {
                                            settingCubit
                                                .setNumberOfAntonyms(newValue!);
                                            settingCubit.saveSettings();
                                          },
                                          items: [5, 10, 20, 30]
                                              .map((value) =>
                                                  DropdownMenuItem<int>(
                                                    alignment: Alignment.center,
                                                    value: value,
                                                    child:
                                                        Text(value.toString()),
                                                  ))
                                              .toList()),
                                    ),
                                  ),
                                ],
                              ),
                              const WaveDivider(
                                thickness: .3,
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          "Customize dictionary responses"
                                              .i18n)),
                                  8.height,
                                  FilledButton.tonal(
                                      onPressed: () {
                                        context.pushNamed(RouterConstants
                                            .dictionaryPreferences);
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: WavySlider(
                                      value: .5,
                                      width: 180,
                                      waveHeight: 10,
                                      waveWidth: 17,
                                      strokeWidth: 5,
                                      onChanged: (value) {
                                        settingCubit
                                            .setReadingFontSize(value * 70);
                                      },
                                      color: context.theme.colorScheme.primary,
                                      backgroundColor: context
                                          .theme.dividerColor
                                          .withOpacity(.5),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Sample text that will be displayed on Reading."
                                    .i18n,
                                style:
                                    TextStyle(fontSize: state.readingFontSize),
                              )
                            ],
                          ),
                        ],
                      )),

                  /// Header
                  ScreenTypeLayout.builder(mobile: (context) {
                    return Header(title: "Settings".i18n);
                  }, tablet: (context) {
                    return Header(
                        enableBackButton: false, title: "Settings".i18n);
                  }),
                ],
              );
            }),
      ),
    );
  }
}

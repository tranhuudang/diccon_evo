import 'package:diccon_evo/views/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/setting_cubit.dart';
import '../models/setting.dart';
import '../views/components/setting_section.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        icon: Icons.settings,
        title: "Settings",
      ),
      body: BlocBuilder<SettingCubit, Setting>(builder: (context, state) {
        return SingleChildScrollView(
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
                      value: state.numberOfSynonyms,
                      hint: const Text('Select a number'),
                      onChanged: (int? newValue) {
                        context
                            .read<SettingCubit>()
                            .setNumberOfSynonyms(newValue!);
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
                  ]),
                  Row(children: [
                    const Text("Number of antonyms"),
                    const SizedBox(
                      width: 8,
                    ),
                    DropdownButton<int>(
                      focusColor: Colors.white,
                      value: state.numberOfAntonyms,
                      hint: const Text('Select a number'),
                      onChanged: (int? newValue) {
                        context
                            .read<SettingCubit>()
                            .setNumberOfAntonyms(newValue!);
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
                            value: state.readingFontSize! / 70,
                            onChanged: (newValue) {
                              context
                                  .read<SettingCubit>()
                                  .setReadingFontSize(newValue * 70);
                            }),
                      ],
                    ),
                    Text(
                      "Sample text that will be displayed on Reading.",
                      style: TextStyle(fontSize: state.readingFontSize),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

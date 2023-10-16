import 'dart:async';

import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/properties.dart';
import '../../../commons/pill_button.dart';
import '../../bloc/setting_bloc.dart';


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
                ].map((currentColor) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {
                        _selectController.add(currentColor);
                        settingBloc
                            .add(ChangeThemeColorEvent(color: currentColor));
                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: currentColor,
                            border: selectedColor.data?.value == currentColor.value
                                ? Border.all(
                              color: Colors.white,
                              width: 3,
                            )
                                : null,
                            borderRadius: BorderRadius.circular(50),
                          )),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox().mediumHeight(),
              PillButton(
                  onTap: () {
                    settingBloc.add(EnableAdaptiveThemeColorEvent());
                  },
                  title: "Use System Theme")
            ],
          );
        });
  }
}

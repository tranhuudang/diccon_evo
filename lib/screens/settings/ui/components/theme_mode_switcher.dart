import 'dart:async';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/extensions/theme_mode.dart';
import 'package:flutter/material.dart';
import '../../../../config/properties.dart';
import '../../cubit/setting_cubit.dart';

class ThemeSwitcher extends StatefulWidget {
  final SettingCubit settingCubit;
  const ThemeSwitcher({super.key, required this.settingCubit});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  final _streamController = StreamController<ThemeMode>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeMode>(
        initialData: Properties.defaultSetting.themeMode.toThemeMode(),
        stream: _streamController.stream,
        builder: (context, snapshot) {
          return Row(
            children: [
              const SizedBox().mediumWidth(),

              /// Light Mode
              InkWell(
                onTap: () {
                  _streamController.sink.add(ThemeMode.light);
                  widget.settingCubit.setThemeMode(ThemeMode.light.toString());
                  widget.settingCubit.saveSettings();
                },
                child: Container(
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                      color: snapshot.data == ThemeMode.light
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16))),
                  child: Row(
                    children: [
                      Icon(
                        Icons.light_mode,
                        color: snapshot.data == ThemeMode.light
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                      if (snapshot.data == ThemeMode.light)
                        const SizedBox().mediumWidth(),
                      if (snapshot.data == ThemeMode.light)
                        Text(
                          "Light mode".i18n,
                          style: TextStyle(
                            fontSize: 16,
                            color: snapshot.data == ThemeMode.light
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const VerticalDivider(
                width: 1,
              ),

              /// Dark Mode
              InkWell(
                onTap: () {
                  _streamController.sink.add(ThemeMode.dark);
                  widget.settingCubit.setThemeMode(ThemeMode.dark.toString());
                  widget.settingCubit.saveSettings();
                },
                child: Container(
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: snapshot.data == ThemeMode.dark
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.dark_mode,
                        color: snapshot.data == ThemeMode.dark
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                      if (snapshot.data == ThemeMode.dark)
                        const SizedBox().mediumWidth(),
                      if (snapshot.data == ThemeMode.dark)
                        Text(
                          "Dark mode".i18n,
                          style: TextStyle(
                            fontSize: 16,
                            color: snapshot.data == ThemeMode.dark
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const VerticalDivider(
                width: 1,
              ),

              /// System Mode
              InkWell(
                onTap: () {
                  _streamController.sink.add(ThemeMode.system);
                  widget.settingCubit.setThemeMode(ThemeMode.system.toString());
                  widget.settingCubit.saveSettings();
                },
                child: Container(
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                      color: snapshot.data == ThemeMode.system
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      )),
                  child: Center(
                    child: Text(
                      "Adaptive".i18n,
                      style: TextStyle(
                        fontSize: 16,
                        color: snapshot.data == ThemeMode.system
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

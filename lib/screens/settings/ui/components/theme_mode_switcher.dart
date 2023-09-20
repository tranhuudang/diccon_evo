import 'dart:async';

import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/theme_mode.dart';
import 'package:flutter/material.dart';

import '../../../../config/local_traditions.dart';
import '../../../../config/properties.dart';
import '../../cubit/setting_cubit.dart';

class ThemeSwitcher extends StatefulWidget {
  final SettingCubit settingCubit;
  const ThemeSwitcher({super.key, required this.settingCubit});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  StreamController<ThemeMode> streamController = StreamController<ThemeMode>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeMode>(
        initialData: Properties.defaultSetting.themeMode.toThemeMode(),
        stream: streamController.stream,
        builder: (context, snapshot) {
          return Row(
            children: [
              Tradition.widthSpacer,

              /// Light Mode
              InkWell(
                onTap: () {
                  streamController.sink.add(ThemeMode.light);
                  widget.settingCubit.setThemeMode(ThemeMode.light.toString());
                  widget.settingCubit.saveSettings();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                      color: snapshot.data == ThemeMode.light
                          ? Colors.blue
                          : Theme.of(context).highlightColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16))),
                  child: Row(
                    children: [
                      const Icon(Icons.light_mode),
                      snapshot.data == ThemeMode.light
                          ? Tradition.widthSpacer
                          : const SizedBox.shrink(),
                      snapshot.data == ThemeMode.light
                          ? Text(
                              "Light mode".i18n,
                              style: const TextStyle(fontSize: 16),
                            )
                          : const SizedBox.shrink()
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
                  streamController.sink.add(ThemeMode.dark);
                  widget.settingCubit.setThemeMode(ThemeMode.dark.toString());
                  widget.settingCubit.saveSettings();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: snapshot.data == ThemeMode.dark
                        ? Colors.blue
                        : Theme.of(context).highlightColor,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.dark_mode),
                      snapshot.data == ThemeMode.dark
                          ? Tradition.widthSpacer
                          : const SizedBox.shrink(),
                      snapshot.data == ThemeMode.dark
                          ? Text(
                              "Dark mode".i18n,
                              style: const TextStyle(fontSize: 16),
                            )
                          : const SizedBox.shrink()
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
                  streamController.sink.add(ThemeMode.system);
                  widget.settingCubit.setThemeMode(ThemeMode.system.toString());
                  widget.settingCubit.saveSettings();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                      color: snapshot.data == ThemeMode.system
                          ? Colors.blue
                          : Theme.of(context).highlightColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      )),
                  child: Row(
                    children: [
                      const Icon(Icons.auto_awesome),
                      snapshot.data == ThemeMode.system
                          ? Tradition.widthSpacer
                          : const SizedBox.shrink(),
                      snapshot.data == ThemeMode.system
                          ? Text(
                              "System default".i18n,
                              style: const TextStyle(fontSize: 16),
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}

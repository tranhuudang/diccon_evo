import 'dart:async';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/extensions/theme_mode.dart';
import 'package:diccon_evo/screens/settings/bloc/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/properties.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  final _streamController = StreamController<ThemeMode>();

  @override
  Widget build(BuildContext context) {
    final settingBloc = context.read<SettingBloc>();
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
                  settingBloc
                      .add(ChangeThemeModeEvent(themeMode: ThemeMode.light));
                },
                child: Container(
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                      color: snapshot.data == ThemeMode.light
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).highlightColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16))),
                  child: Row(
                    children: [
                      Icon(
                        Icons.light_mode,
                        color: snapshot.data == ThemeMode.light
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
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
                  settingBloc
                      .add(ChangeThemeModeEvent(themeMode: ThemeMode.dark));
                },
                child: Container(
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: snapshot.data == ThemeMode.dark
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).highlightColor,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.dark_mode,
                        color: snapshot.data == ThemeMode.dark
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
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
                  settingBloc
                      .add(ChangeThemeModeEvent(themeMode: ThemeMode.system));
                },
                child: Container(
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                      color: snapshot.data == ThemeMode.system
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).highlightColor,
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

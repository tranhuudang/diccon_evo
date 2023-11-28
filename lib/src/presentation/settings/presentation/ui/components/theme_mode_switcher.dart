import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';

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
        initialData: Properties.instance.settings.themeMode.toThemeMode(),
        stream: _streamController.stream,
        builder: (context, snapshot) {
          return Row(
            children: [
              const HorizontalSpacing.medium(),

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
                          ? context.theme.colorScheme.primary
                          : context.theme.highlightColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16))),
                  child: Row(
                    children: [
                      Icon(
                        Icons.light_mode,
                        color: snapshot.data == ThemeMode.light
                            ? context.theme.colorScheme.onPrimary
                            : context.theme
                                .colorScheme
                                .onSecondaryContainer,
                      ),
                      if (snapshot.data == ThemeMode.light)
                        const HorizontalSpacing.medium(),
                      if (snapshot.data == ThemeMode.light)
                        Text(
                          "Light mode".i18n,
                          style: TextStyle(
                            color: snapshot.data == ThemeMode.light
                                ? context.theme.colorScheme.onPrimary
                                : context.theme
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
                        ? context.theme.colorScheme.primary
                        : context.theme.highlightColor,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.dark_mode,
                        color: snapshot.data == ThemeMode.dark
                            ? context.theme.colorScheme.onPrimary
                            : context.theme
                                .colorScheme
                                .onSecondaryContainer,
                      ),
                      if (snapshot.data == ThemeMode.dark)
                        const HorizontalSpacing.medium(),
                      if (snapshot.data == ThemeMode.dark)
                        Text(
                          "Dark mode".i18n,
                          style: TextStyle(
                            color: snapshot.data == ThemeMode.dark
                                ? context.theme.colorScheme.onPrimary
                                : context.theme
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
                          ? context.theme.colorScheme.primary
                          : context.theme.highlightColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      )),
                  child: Center(
                    child: Text(
                      "Adaptive".i18n,
                      style: TextStyle(
                        color: snapshot.data == ThemeMode.system
                            ? context.theme.colorScheme.onPrimary
                            : context.theme
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

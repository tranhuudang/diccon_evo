import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common/common.dart';
import '../../../../features.dart';

class ReadingBottomAppBar extends StatelessWidget {
  final ReadingBloc readingBloc;
  final bool isVisible;
  const ReadingBottomAppBar({
    super.key,
    required this.isVisible,
    required this.readingBloc,
  });

  @override
  Widget build(BuildContext context) {
    final settingBloc = context.read<SettingBloc>();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isVisible ? 60 : 0,
      child: BottomAppBar(
        height: 60,
        child: Row(
          children: [
            const Spacer(),
            IconButton(
                onPressed: () {
                  var brightness =
                      Properties.instance.settings.themeMode.toThemeMode();
                  if (brightness == ThemeMode.light) {
                    settingBloc
                        .add(ChangeThemeModeEvent(themeMode: ThemeMode.dark));
                  } else {
                    settingBloc
                        .add(ChangeThemeModeEvent(themeMode: ThemeMode.light));
                  }
                },
                icon: Properties.instance.settings.themeMode.toThemeMode() ==
                        ThemeMode.light
                    ? const Icon(Icons.light_mode_outlined)
                    : const Icon(Icons.dark_mode_outlined)),
            PopupMenuButton(
              icon: Icon(
                Icons.format_size,
                color: context.theme.colorScheme.primary,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: context.theme.dividerColor),
                borderRadius: BorderRadius.circular(16.0),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(Icons.plus_one),
                      const SizedBox(
                        width: 8,
                      ),
                      Text("Increase".i18n),
                    ],
                  ),
                  onTap: () {
                    readingBloc.add(IncreaseFontSize());
                  },
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(Icons.exposure_minus_1),
                      const SizedBox(
                        width: 8,
                      ),
                      Text("Decrease".i18n),
                    ],
                  ),
                  onTap: () {
                    readingBloc.add(DecreaseFontSize());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

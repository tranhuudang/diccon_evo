import 'dart:async';

import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/domain.dart';
import '../../../../presentation.dart';
import '../../../bloc/reading_bloc.dart';

class ReadingBottomAppBar extends StatefulWidget {
  final ReadingBloc readingBloc;
  final bool isVisible;
  final Story story;
  const ReadingBottomAppBar({
    super.key,
    required this.isVisible,
    required this.readingBloc,
    required this.story,
  });

  @override
  State<ReadingBottomAppBar> createState() => _ReadingBottomAppBarState();
}

class _ReadingBottomAppBarState extends State<ReadingBottomAppBar> {
  final isPlaying = StreamController<bool>();
  @override
  Widget build(BuildContext context) {
    final settingBloc = context.read<SettingBloc>();
    final readingBloc = context.read<ReadingBloc>();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: widget.isVisible ? 60 : 0,
      child: BottomAppBar(
        height: 60,
        child: Row(
          children: [
            if (widget.story.content.length < 4000)
              BlocBuilder<ReadingBloc, ReadingState>(builder: (context, state) {
                if (state.params.isDownloaded == true) {
                  return PlayFileButton(filePath: state.params.audioFilePath);
                }
                if (state.params.isDownloading == true) {
                  return SizedBox(
                    height: 50,
                    width: 50,
                    child: IconButton(
                      icon: const LinearProgressIndicator(),
                      onPressed: () {},
                    ),
                  );
                }

                return Row(
                  children: [
                    IconButton(
                      onPressed: () =>
                          readingBloc.add(DownloadAudio(story: widget.story)),
                      icon: const Icon(Icons.cloud_download_outlined),
                    ),
                    const HorizontalSpacing.medium(),
                    Text('Download audio'.i18n),
                  ],
                );
              }),
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

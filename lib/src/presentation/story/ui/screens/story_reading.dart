import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/domain/domain.dart';
import '../../../../data/data.dart';
import '../../bloc/reading_bloc.dart';
import '../../bloc/story_bookmark_list_bloc.dart';

class StoryReadingView extends StatefulWidget {
  final Story story;

  const StoryReadingView({
    super.key,
    required this.story,
  });

  @override
  State<StoryReadingView> createState() => _StoryReadingViewState();
}

class _StoryReadingViewState extends State<StoryReadingView> {
  final _storyBookmarkBloc = StoryBookmarkBloc();
  late ReadingBloc _readingBloc;
  bool isTranslating = false;
  final _storyRepository = StoryRepositoryImpl();
  List<Story> _listStories = [];
  late final _streamIsBookmarkController = StreamController<bool>();
  bool _isListStoriesShouldChanged = false;
  late final _controller = ScrollController();

  Future<void> getListStoryBookmark() async {
    _listStories = await _storyRepository.readStoryBookmark();
    if (_listStories.contains(widget.story)) {
      _streamIsBookmarkController.sink.add(true);
    }
  }

  @override
  void initState() {
    super.initState();
    _readingBloc = context.read<ReadingBloc>();
    getListStoryBookmark();
    _readingBloc.add(InitReadingBloc(story: widget.story));
  }

  @override
  void dispose() {
    _controller.dispose();
    _streamIsBookmarkController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingBloc = context.read<SettingBloc>();
    final readingBloc = context.read<ReadingBloc>();
    return SafeArea(
      child: BlocBuilder<ReadingBloc, ReadingState>(
        builder: (context, state) {
          switch (state) {
            default:
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context.pop(_isListStoriesShouldChanged);
                    },
                  ),
                  actions: [
                    // Switch dark mode button
                    IconButton(
                        onPressed: () {
                          var brightness = Properties
                              .instance.settings.themeMode
                              .toThemeMode();
                          if (brightness == ThemeMode.light) {
                            settingBloc.add(ChangeThemeModeEvent(
                                themeMode: ThemeMode.dark));
                          } else {
                            settingBloc.add(ChangeThemeModeEvent(
                                themeMode: ThemeMode.light));
                          }
                        },
                        icon: Properties.instance.settings.themeMode
                                    .toThemeMode() ==
                                ThemeMode.light
                            ? const Icon(Icons.light_mode_outlined)
                            : const Icon(Icons.dark_mode_outlined)),
                    // Text sizer button
                    PopupMenuButton(
                      icon: Icon(
                        Icons.format_size,
                        color: context.theme.colorScheme.secondary,
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
                    // Favourite button
                    StreamBuilder<bool>(
                      initialData: false,
                      stream: _streamIsBookmarkController.stream,
                      builder: (context, isBookmark) {
                        return isBookmark.data ?? false
                            ? IconButton(
                                color: context.theme.colorScheme.primary,
                                icon: const Icon(Icons.bookmark),
                                onPressed: () {
                                  _isListStoriesShouldChanged = true;
                                  _streamIsBookmarkController.sink.add(false);
                                  _storyBookmarkBloc.add(
                                      StoryBookmarkRemove(story: widget.story));
                                  context.showSnackBar(
                                      content: "Bookmark is removed".i18n);
                                },
                              )
                            : IconButton(
                                icon: const Icon(Icons.bookmark_border),
                                onPressed: () {
                                  _isListStoriesShouldChanged = true;

                                  _streamIsBookmarkController.sink.add(true);
                                  _storyBookmarkBloc.add(
                                      StoryBookmarkAdd(stories: widget.story));
                                  context.showSnackBar(
                                      content: "Bookmark is added".i18n);
                                },
                              );
                      },
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 32, top: 16),
                  controller: _controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Header
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.story.title,
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              widget.story.source!,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),

                      /// Image
                      Center(
                        child: CachedNetworkImage(
                          //height: 380,
                          placeholder: (context, url) =>
                              const LinearProgressIndicator(
                            backgroundColor: Colors.black45,
                            color: Colors.black54,
                          ),
                          imageUrl: widget.story.imageUrl ?? "",
                          fit: BoxFit.cover,
                          errorWidget:
                              (context, String exception, dynamic stackTrace) {
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      /// Content
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.story.content.split('\n').map(
                          (paragraph) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (paragraph.isNotEmpty)
                                  StoryClickableWords(
                                    text: paragraph,
                                    style: context.theme.textTheme.bodyMedium
                                        ?.copyWith(
                                      fontSize: state.params.fontSize,
                                      color: context
                                          .theme.colorScheme.onBackground,
                                    ),
                                    onWordTap: (String word, String sentence) {
                                      final refinedWord =
                                          word.removeSpecialCharacters();
                                      final refinedSentence = sentence.trim();
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return BottomSheetTranslation(
                                            searchWord: refinedWord,
                                            sentenceContainWord:
                                                refinedSentence,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                const SizedBox(
                                  height: 5,
                                )
                              ],
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: widget.story.content.length <
                        NumberConstants.maximumLengthForTextToSpeech
                    ? ReadingBottomAppBar(
                        isVisible: true,
                        readingBloc: _readingBloc,
                        story: widget.story,
                      )
                    : null,
              );
          }
        },
      ),
    );
  }
}

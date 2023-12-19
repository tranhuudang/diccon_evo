import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/domain/domain.dart';
import '../../../../../data/data.dart';
import '../../../../shared/presentation/ui/components/story_clickable_word.dart';
import '../../../bloc/reading_bloc.dart';
import '../../../bloc/story_bookmark_list_bloc.dart';

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

  void _listen() {
    final ScrollDirection direction = _controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      _readingBloc.add(ShowBottomAppBar());
      print('up up');
    } else if (direction == ScrollDirection.reverse) {
      _readingBloc.add(HideBottomAppBar());
      print('down down');
    }
  }

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
    _controller.addListener(_listen);
    getListStoryBookmark();
    _readingBloc.add(InitReadingBloc());
  }

  @override
  void dispose() {
    _controller.removeListener(_listen);
    _controller.dispose();
    _streamIsBookmarkController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        BlocBuilder<ReadingBloc, ReadingState>(builder: (context, state) {
      switch (state) {
        default:
          return Scaffold(
            backgroundColor: context.theme.colorScheme.surface,
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  controller: _controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Header
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 56),
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
                        children:
                            widget.story.content.split('\n').map((paragraph) {
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
                                          builder: (context) {
                                            return BottomSheetTranslation(
                                              searchWord: refinedWord,
                                              sentenceContainWord:
                                                  refinedSentence,
                                            );
                                          });
                                    }),
                              const SizedBox(
                                height: 5,
                              )
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                /// Menu with close and bookmark button
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: state.params.isBottomAppBarVisible ? 1 : 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: StreamBuilder<bool>(
                        initialData: false,
                        stream: _streamIsBookmarkController.stream,
                        builder: (context, isBookmark) {
                          return Row(
                            children: [
                              const Spacer(),

                              /// Bookmark button
                              isBookmark.data ?? false
                                  ? CircleButton(
                                      backgroundColor: context
                                          .theme.colorScheme.secondaryContainer,
                                      icon: const Icon(Icons.bookmark_border),
                                      onTap: () {
                                        _isListStoriesShouldChanged = true;
                                        _streamIsBookmarkController.sink
                                            .add(false);
                                        _storyBookmarkBloc.add(
                                            StoryBookmarkRemove(
                                                story: widget.story));
                                        context.showSnackBar(
                                            content:
                                                "Bookmark is removed".i18n);
                                      },
                                    )
                                  : CircleButton(
                                      backgroundColor: context
                                          .theme.colorScheme.surfaceVariant
                                          .withOpacity(.5),
                                      icon: const Icon(Icons.bookmark_border),
                                      onTap: () {
                                        _isListStoriesShouldChanged = true;

                                        _streamIsBookmarkController.sink
                                            .add(true);
                                        _storyBookmarkBloc.add(StoryBookmarkAdd(
                                            stories: widget.story));
                                        context.showSnackBar(
                                            content: "Bookmark is added".i18n);
                                      }),
                              const HorizontalSpacing.medium(),

                              /// CLose button
                              CircleButton(
                                  backgroundColor: context
                                      .theme.colorScheme.surfaceVariant
                                      .withOpacity(.5),
                                  icon: const Icon(Icons.close),
                                  onTap: () {
                                    context.pop(_isListStoriesShouldChanged);
                                  }),
                            ],
                          );
                        }),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: ReadingBottomAppBar(
              isVisible: true,
              readingBloc: _readingBloc,
              story: widget.story,
            ),
          );
      }
    }));
  }
}

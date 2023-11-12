import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';

import '../../../../shared/presentation/ui/components/story_clickable_word.dart';

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
  bool isTranslating = false;
  final _storyRepository = StoryRepositoryImpl();
  List<Story> _listStories = [];
  final _streamIsBookmarkController = StreamController<bool>();
  bool _isListStoriesShouldChanged = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(_listen);
    getListStoryBookmark();
  }

  bool _isVisible = false;
  final  _controller = ScrollController();
  void _listen() {
    final ScrollDirection direction = _controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      _show();
    } else if (direction == ScrollDirection.reverse) {
      _hide();
    }
  }
  void _show() {
    if (!_isVisible) {
      setState(() => _isVisible = true);
    }
  }

  void _hide() {
    if (_isVisible) {
      setState(() => _isVisible = false);
    }
  }
  Future<void> getListStoryBookmark() async {
    _listStories = await _storyRepository.readStoryBookmark();
    if (_listStories.contains(widget.story)) {
      _streamIsBookmarkController.sink.add(true);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_listen);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.surface,
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _controller,
              child: Responsive(
                smallSizeDevice: readingSpaceBody(context: context),
                mediumSizeDevice: readingSpaceBody(context: context),
                largeSizeDevice: readingSpaceBody(context: context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: StreamBuilder<bool>(
                  initialData: false,
                  stream: _streamIsBookmarkController.stream,
                  builder: (context, snapshot) {
                    return Row(
                      children: [
                        const Spacer(),

                        /// Bookmark button
                        snapshot.data!
                            ? CircleButton(
                                backgroundColor: context
                                    .theme.colorScheme.secondaryContainer,
                                iconData: Icons.bookmark_border,
                                onTap: () {
                                  _isListStoriesShouldChanged = true;
                                  _streamIsBookmarkController.sink.add(false);
                                  _storyBookmarkBloc.add(
                                      StoryBookmarkRemove(story: widget.story));
                                  context.showSnackBar(
                                      content: "Bookmark is removed".i18n);
                                })
                            : CircleButton(
                                backgroundColor: context
                                    .theme.colorScheme.surfaceVariant
                                    .withOpacity(.5),
                                iconData: Icons.bookmark_border,
                                onTap: () {
                                  _isListStoriesShouldChanged = true;

                                  _streamIsBookmarkController.sink.add(true);
                                  _storyBookmarkBloc.add(
                                      StoryBookmarkAdd(stories: widget.story));
                                  context.showSnackBar(
                                      content: "Bookmark is added".i18n);
                                }),
                        const HorizontalSpacing.medium(),

                        /// CLose button
                        CircleButton(
                            backgroundColor: context
                                .theme.colorScheme.surfaceVariant
                                .withOpacity(.5),
                            iconData: Icons.close,
                            onTap: () {
                              context.pop(_isListStoriesShouldChanged);
                            }),
                      ],
                    );
                  }),
            ),
          ],
        ),
        bottomNavigationBar: ReadingBottomAppBar(
          isVisible: _isVisible,
        ),
      ),
    );
  }

  SingleChildScrollView readingSpaceBody({required BuildContext context}) {
    return SingleChildScrollView(
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
        ),

        /// Image
        Center(
          child: Hero(
            tag: "fromArticleListToPage${widget.story.title}Tag",
            child: CachedNetworkImage(
              //height: 380,
              placeholder: (context, url) => const LinearProgressIndicator(
                backgroundColor: Colors.black45,
                color: Colors.black54,
              ),
              imageUrl: widget.story.imageUrl ?? "",
              fit: BoxFit.cover,
              errorWidget: (context, String exception, dynamic stackTrace) {
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),

        /// Content
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.story.content.split('\n').map((paragraph) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (paragraph.isNotEmpty)
                  StoryClickableWords(
                      text: paragraph,
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        fontSize: Properties.defaultSetting.readingFontSize,
                        color: context.theme.colorScheme.onBackground,
                      ),
                      onWordTap: (String word, String sentence) {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return BottomSheetTranslation(
                                searchWord: word.removeSpecialCharacters(),
                                sentenceContainWord: sentence,
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
    );
  }
}


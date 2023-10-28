import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diccon_evo/features/features.dart';
import 'package:diccon_evo/common/common.dart';

import '../../../../../common/data/models/story.dart';
class StoryReadingView extends StatefulWidget {
  final Story story;

  const StoryReadingView({
    Key? key,
    required this.story,
  }) : super(key: key);

  @override
  State<StoryReadingView> createState() => _StoryReadingViewState();
}

class _StoryReadingViewState extends State<StoryReadingView> {
  final _storyBookmarkBloc = StoryBookmarkBloc();
  bool isTranslating = false;
  final _storyRepository = StoryRepository();
  List<Story> _listStories = [];
  final _streamIsBookmarkController = StreamController<bool>();
  bool _isListStoriesShouldChanged = false;
  @override
  void initState() {
    super.initState();
    getListStoryBookmark();
  }

  Future<void> getListStoryBookmark() async {
    _listStories = await _storyRepository.readStoryBookmark();
    if (_listStories.contains(widget.story)) {
      _streamIsBookmarkController.sink.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.surface,
        body: Stack(
          children: [
            SingleChildScrollView(
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
                                backgroundColor: context.theme
                                    .colorScheme
                                    .secondaryContainer,
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
                                backgroundColor: context.theme
                                    .colorScheme
                                    .surfaceVariant
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
                        const SizedBox().mediumWidth(),

                        /// CLose button
                        CircleButton(
                            backgroundColor: context.theme
                                .colorScheme
                                .surfaceVariant
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
                  paragraph.isNotEmpty
                      ? ClickableWords(
                          text: paragraph,
                          style: context.theme
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                fontSize:
                                    Properties.defaultSetting.readingFontSize,
                                color:
                                    context.theme.colorScheme.onBackground,
                              ),
                          onWordTap: (String value) {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return BottomSheetTranslation(
                                    searchWord: value.removeSpecialCharacters(),
                                  );
                                });
                          })
                      : Container(),
                  const SizedBox(
                    height: 5,
                  )
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:diccon_evo/config/responsive.dart';
import 'package:diccon_evo/data/repositories/story_repository.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/extensions/string.dart';
import 'package:diccon_evo/screens/story/blocs/story_bookmark_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/properties.dart';
import '../../commons/notify.dart';
import '../../../data/models/story.dart';
import 'components/bottom_sheet_translate.dart';
import '../../commons/circle_button.dart';
import '../../commons/clickable_words.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        backgroundColor: Theme.of(context).colorScheme.surface,
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
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                iconData: Icons.bookmark_border,
                                onTap: () {
                                  _isListStoriesShouldChanged = true;
                                  _streamIsBookmarkController.sink.add(false);
                                  _storyBookmarkBloc.add(
                                      StoryBookmarkRemove(story: widget.story));
                                  Notify.showSnackBar(
                                      context: context,
                                      content: "Bookmark is removed".i18n);
                                })
                            : CircleButton(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant
                                    .withOpacity(.5),
                                iconData: Icons.bookmark_border,
                                onTap: () {
                                  _isListStoriesShouldChanged = true;

                                  _streamIsBookmarkController.sink.add(true);
                                  _storyBookmarkBloc.add(
                                      StoryBookmarkAdd(stories: widget.story));
                                  Notify.showSnackBar(
                                      context: context,
                                      content: "Bookmark is added".i18n);
                                }),
                        const SizedBox().mediumWidth(),

                        /// CLose button
                        CircleButton(
                            backgroundColor: Theme.of(context)
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                fontSize:
                                    Properties.defaultSetting.readingFontSize,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
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

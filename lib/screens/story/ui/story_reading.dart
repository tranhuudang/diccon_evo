import 'dart:async';

import 'package:diccon_evo/data/repositories/story_repository.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/extensions/string.dart';
import 'package:diccon_evo/screens/story/blocs/story_bookmark_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:translator/translator.dart';
import '../../../config/properties.dart';
import '../../../data/data_providers/notify.dart';
import '../../../data/data_providers/searching.dart';
import '../../../data/models/story.dart';
import '../../../data/models/word.dart';
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
  final _translator = GoogleTranslator();
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

  Future<Translation> translate(String word) async {
    return await _translator.translate(word, from: 'auto', to: 'vi');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
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
                            paragraph.isNotEmpty
                                ? ClickableWords(
                                    text: paragraph,
                                    fontSize: Properties
                                        .defaultSetting.readingFontSize,
                                    textColor: Theme.of(context)
                                        .primaryTextTheme
                                        .labelMedium
                                        ?.color,
                                    onWordTap: (String value) {
                                      _showModalBottomSheet(context,
                                          value.removeSpecialCharacters());
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
                                backgroundColor: Theme.of(context).primaryColor,
                                iconData: Icons.bookmark_border,
                                onTap: () {
                                  _isListStoriesShouldChanged = true;
                                  _streamIsBookmarkController.sink.add(false);
                                  _storyBookmarkBloc.add(
                                      StoryBookmarkRemove(story: widget.story));
                                  Notify.showSnackBar(
                                      context, "Bookmark is removed".i18n);
                                })
                            : CircleButton(
                                iconData: Icons.bookmark_border,
                                onTap: () {
                                  _isListStoriesShouldChanged = true;

                                  _streamIsBookmarkController.sink.add(true);
                                  _storyBookmarkBloc.add(
                                      StoryBookmarkAdd(stories: widget.story));
                                  Notify.showSnackBar(
                                      context, "Bookmark is added".i18n);
                                }),
                        const SizedBox().mediumWidth(),

                        /// CLose button
                        CircleButton(
                            iconData: Icons.close,
                            onTap: () {
                              context.pop( _isListStoriesShouldChanged);
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

  Future<void> _showModalBottomSheet(
      BuildContext context, String searchWord) async {
    Word? wordResult;

    // Capture the context before entering the async function
    final currentContext = context;

    /// This line is the skeleton of finding the word in the dictionary
    wordResult = await Searching.getDefinition(searchWord);
    if (wordResult != null) {
      showModalBottomSheet(
        context: currentContext, // Use the captured context here
        builder: (BuildContext context) {
          return SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: BottomSheetTranslation(
                message: wordResult!,
              ),
            ),
          );
        },
      );
    } else {
      setState(() {
        isTranslating = true;
      });
      Translation result = await translate(searchWord);
      setState(() {
        isTranslating = false;
      });

      wordResult =
          Word(word: searchWord, pronunciation: "", meaning: result.text);
      showModalBottomSheet(
        context: currentContext, // Use the captured context here
        builder: (BuildContext context) {
          return SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: BottomSheetTranslation(
                message: wordResult!,
              ),
            ),
          );
        },
      );
    }
  }
}

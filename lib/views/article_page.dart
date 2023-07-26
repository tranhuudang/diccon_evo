import 'package:diccon_evo/helpers/word_handler.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import '../helpers/searching.dart';
import '../models/article.dart';
import '../models/word.dart';
import '../views/components/clickable_words.dart';
import '../global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import '../helpers/platform_check.dart';
import 'components/bottom_sheet_translate.dart';
import 'components/header.dart';
import 'components/window_title_bar.dart';

class ArticlePageView extends StatefulWidget {
  final Article article;

  const ArticlePageView({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  _ArticlePageViewState createState() => _ArticlePageViewState();
}

class _ArticlePageViewState extends State<ArticlePageView> {
  late List<bool> isWordSelected;
  var translatedWord = "";
  final translator = GoogleTranslator();
  bool isTranslating = false;

  @override
  void initState() {
    super.initState();
  }

  Future<Translation> translate(String word) async {
    return await translator.translate(word, from: 'auto', to: 'vi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const WindowTileBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Header(
              title: widget.article.title,
              iconButton: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),),
            Expanded(
              child: Stack(
                children: [
                  /// Image for the article
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          Column(children: [
                            CachedNetworkImage(
                                placeholder: (context, url) =>
                                const LinearProgressIndicator(
                                  backgroundColor: Colors.black45,
                                  color: Colors.black54,
                                ),
                                imageUrl: widget.article.imageUrl ?? "",
                                fit: BoxFit.cover,
                                errorWidget:
                                    (context, String exception, dynamic stackTrace) {
                                  return Container(
                                    width: 100.0,
                                    height: 100.0,
                                    color: Colors
                                        .grey, // Display a placeholder color or image
                                    child: const Center(
                                      child: Text('No Image'),
                                    ),
                                  );
                                }),
                            const SizedBox(
                              height: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                              widget.article.content.split('\n').map((paragraph) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    paragraph.isNotEmpty
                                        ? ClickableWords(
                                        text: paragraph,
                                        fontSize: Global.defaultReadingFontSize,
                                        textColor: Colors.black,
                                        onWordTap: (value) {
                                          setState(() {
                                            isTranslating = true;
                                            _showModalBottomSheet(context, value);
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
                          ],),

                        ],
                      ),
                    ),
                  ),
                  /// Bottom box for translation
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: BottomOnlineTranslationBox(
                          isTranslating: isTranslating,
                          translatedWord: translatedWord)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context, String searchWord) {
    Word? wordResult;
    searchWord = WordHandler.removeSpecialCharacters(searchWord);

    /// This line is the skeleton of finding word in dictionary
    wordResult = Searching.getDefinition(searchWord);

    if (wordResult == null) {
      translate(searchWord).then((value) {
        setState(() {
          translatedWord = value.text;
          isTranslating = false;
        });
      });
    } else {
      isTranslating = false;
      translatedWord = "";
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child: BottomSheetTranslation(
                  message: wordResult!,
                ),
              ),
            );
          });
    }
  }
}

class BottomOnlineTranslationBox extends StatelessWidget {
  const BottomOnlineTranslationBox({
    super.key,
    required this.isTranslating,
    required this.translatedWord,
  });

  final bool isTranslating;
  final String translatedWord;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.translate),
            const SizedBox(
              width: 8,
            ),
            isTranslating
                ? const SizedBox(
                    height: 8, width: 40, child: LinearProgressIndicator())
                : Text(translatedWord),
          ],
        ),
      ),
    );
  }
}

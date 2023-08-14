import 'package:diccon_evo/helpers/word_handler.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import '../helpers/searching.dart';
import '../models/article.dart';
import '../models/word.dart';
import '../views/components/clickable_words.dart';
import '../global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'components/bottom_sheet_translate.dart';
import 'components/header.dart';

class ArticlePageView extends StatefulWidget {
  final Article article;

  const ArticlePageView({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  State<ArticlePageView> createState() => _ArticlePageViewState();
}

class _ArticlePageViewState extends State<ArticlePageView> {
  late List<bool> isWordSelected;
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
    return SafeArea(
      child: Scaffold(
        appBar: Header(
          title: widget.article.title,
          iconButton: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  /// Image for the article
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 50,
                        left: Global.isLargeWindows ? 100 : 16,
                        right: Global.isLargeWindows ? 100 : 16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CachedNetworkImage(
                              height: 380,
                              placeholder: (context, url) =>
                                  const LinearProgressIndicator(
                                    backgroundColor: Colors.black45,
                                    color: Colors.black54,
                                  ),
                              imageUrl: widget.article.imageUrl ?? "",
                              fit: BoxFit.cover,
                              errorWidget: (context, String exception,
                                  dynamic stackTrace) {
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
                            children: widget.article.content
                                .split('\n')
                                .map((paragraph) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  paragraph.isNotEmpty
                                      ? ClickableWords(
                                          text: paragraph,
                                          fontSize:
                                              Global.defaultReadingFontSize,
                                          textColor: Theme.of(context).primaryTextTheme.labelMedium?.color,
                                          onWordTap: (value) {
                                            _showModalBottomSheet(
                                                context, value);
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
                  /// Bottom box for translation
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: BottomOnlineTranslationBox(
                      isTranslating: isTranslating,
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

  Future<void> _showModalBottomSheet(BuildContext context, String searchWord) async {
    Word? wordResult;
    searchWord = WordHandler.removeSpecialCharacters(searchWord);

    /// This line is the skeleton of finding word in dictionary
    wordResult = Searching.getDefinition(searchWord);

    if (wordResult == null){
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

    } else {
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
  });

  final bool isTranslating;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration:  BoxDecoration(
        color: Theme.of(context).navigationBarTheme.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 8,
            ),
            const Icon(Icons.translate, size: 18,),
            const SizedBox(
              width: 8,
            ),
            isTranslating
                ? const SizedBox(
                    height: 8, width: 40, child: LinearProgressIndicator())
                : Container()
          ],
        ),
      ),
    );
  }
}

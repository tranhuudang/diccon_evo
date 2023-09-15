import 'package:diccon_evo/config/local_traditions.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/string.dart';
import 'package:diccon_evo/helpers/article_handler.dart';
import 'package:diccon_evo/screens/article/cubits/article_bookmark_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/translator.dart';
import '../../../config/properties.dart';
import '../../../helpers/notify.dart';
import '../../../helpers/searching.dart';
import '../../../models/article.dart';
import '../../../models/word.dart';
import '../../commons/bottom_sheet_translate.dart';
import '../../commons/circle_button.dart';
import '../../commons/clickable_word/ui/clickable_words.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    final articleBookmarkCubit = context.read<ArticleBookmarkListCubit>();
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
                            widget.article.title,
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            widget.article.source!,
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
                        imageUrl: widget.article.imageUrl ?? "",
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
                          widget.article.content.split('\n').map((paragraph) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            paragraph.isNotEmpty
                                ? ClickableWords(
                                    text: paragraph,
                                    fontSize: Properties.defaultReadingFontSize,
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
              child: Row(
                children: [
                  const Spacer(),


                  /// Favourite button
                  CircleButton(
                      iconData: Icons.bookmark_border,
                      onTap: () {
                        articleBookmarkCubit.addBookmark(widget.article);
                        Notify.showSnackBar(context, "Bookmark added".i18n);
                         }),
                  Tradition.widthSpacer,
                  /// CLose button
                  CircleButton(
                      iconData: Icons.close,
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showModalBottomSheet(
      BuildContext context, String searchWord) async {
    Word? wordResult;

    /// This line is the skeleton of finding word in dictionary
    wordResult = Searching.getDefinition(searchWord);

    if (wordResult != null) {
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
            const Icon(
              Icons.translate,
              size: 18,
            ),
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

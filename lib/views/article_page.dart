import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import '../views/components/clickable_words.dart';
import '../views/components/header.dart';
import '../global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import '../helpers/platform_check.dart';

class ArticlePageView extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String content;

  const ArticlePageView(
      {Key? key,
      required this.content,
      required this.title,
      required this.imageUrl})
      : super(key: key);

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
      appBar: PlatformCheck.isMobile()
          ? AppBar(
              backgroundColor: Colors.white,
              title: Text(
                widget.title,
                style: const TextStyle(color: Colors.black),
              ),
              elevation: 0.5,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
            )
          : PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white, // Windows 11 title bar color
                  border: Border(
                    bottom: BorderSide(color: Colors.black12, width: 0.7),
                  ),
                ),
                child: MoveWindow(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: const Icon(Icons.arrow_back)),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        widget.title,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          children: [
                            MinimizeWindowButton(
                              colors: Global.buttonColors,
                            ),
                            MaximizeWindowButton(
                              colors: Global.buttonColors,
                            ),
                            CloseWindowButton(
                              colors: Global.closeButtonColors,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            /// Image for the article
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CachedNetworkImage(
                        placeholder: (context, url) =>
                            const LinearProgressIndicator(
                              backgroundColor: Colors.black45,
                              color: Colors.black54,
                            ),
                        imageUrl: widget.imageUrl,
                        fit: BoxFit.none,
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
                      children: widget.content.split('\n').map((paragraph) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            paragraph.isNotEmpty
                                ? ClickableWords(
                                    text: paragraph,
                                    fontSize: Global.readingFontSize,
                                    textColor: Colors.black,
                                    onWordTap: (value) {
                                      setState(() {
                                        isTranslating = true;
                                      });
                                      translate(value).then((value) {
                                        setState(() {
                                          translatedWord = value.text;
                                          isTranslating = false;
                                        });
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
              ),
            ),

            /// Bottom box for translation
            Container(
              padding: const EdgeInsets.all(8),
              height: 50,
              decoration: const BoxDecoration(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.translate),
                  const SizedBox(
                    width: 8,
                  ),
                  isTranslating
                      ? const SizedBox(
                          height: 8,
                          width: 40,
                          child: LinearProgressIndicator())
                      : Text(translatedWord),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

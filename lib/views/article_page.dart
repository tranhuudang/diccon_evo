import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import '../components/clickable_words.dart';
import '../components/header.dart';
import '../global.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
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
                    placeholder: (context, url) => const LinearProgressIndicator(
                          backgroundColor: Colors.black45,
                          color: Colors.black54,
                        ),
                    imageUrl: widget.imageUrl,

                    fit: BoxFit.none,
                    errorWidget: (context, String exception, dynamic stackTrace) {
                      return Container(
                        width: 100.0,
                        height: 100.0,
                        color: Colors.grey, // Display a placeholder color or image
                        child: Center(
                          child: Text('No Image'),
                        ),
                      );
                    }),
                SizedBox(height: 16,),
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
                        SizedBox(
                          height: 5,
                        )
                      ],
                    );
                  }).toList(),
                ),
                ],),
              ),
            ),
            /// Bottom box for translation
            Container(
              padding: EdgeInsets.all(8),
              height: 50,
              decoration: BoxDecoration(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.translate),
                  SizedBox(
                    width: 8,
                  ),
                  isTranslating
                      ? Container(
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

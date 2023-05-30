import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import '../components/clickable_words.dart';
import '../components/header.dart';
import '../global.dart';

class ArticlePageView extends StatefulWidget {
  final String title;
  final String content;

  const ArticlePageView({Key? key, required this.content, required this.title})
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
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.content.split('\n').map((paragraph) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        paragraph.isNotEmpty
                            ? ClickableWords(
                                text: paragraph,
                                style: const TextStyle(
                                  color: Colors.black,
                                  //fontWeight: FontWeight.bold,
                                ),
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
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
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
                          height: 8, width: 40, child: LinearProgressIndicator())
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

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/core/utils/md5_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:wave_divider/wave_divider.dart';

class BottomSheetTranslation extends StatefulWidget {
  final String searchWord;
  final Function(String)? onWordTap;
  final String sentenceContainWord;
  const BottomSheetTranslation(
      {super.key,
      this.onWordTap,
      required this.searchWord,
      required this.sentenceContainWord});

  @override
  State<BottomSheetTranslation> createState() => _BottomSheetTranslationState();
}

class _BottomSheetTranslationState extends State<BottomSheetTranslation> {
  final _isLoadingStreamController = StreamController();
  bool _isEditing = false;
  bool _isEditor = false;
  final gemini = Gemini.instance;
  String wordDefinitionAnswer = '';
  String sentenceTranslationAnswer = '';

  final TextEditingController _editingController = TextEditingController();
  final TextEditingController _editingControllerForSentence =
      TextEditingController();

  Future<void> _checkIfUserIsEditor() async {
    final authUser = FirebaseAuth.instance.currentUser;
    final userId = Md5Generator.composeMd5IdForFirebaseDbPremium(
        userEmail: authUser?.email ?? '');
    final editorDoc = await FirebaseFirestore.instance
        .collection(FirebaseConstant.firestore.editor)
        .doc(userId)
        .get();

    setState(() {
      _isEditor = editorDoc.exists;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkIfUserIsEditor();
    _checkIfWordDefinitionOnFirestore();
    _checkIfSentenceTranslationOnFirestore();
  }

  _checkIfWordDefinitionOnFirestore() async {
    // create md5 from question to compare to see if that md5 is already exist in database
    var answer = Md5Generator.composeMd5IdForStoryFirebaseDb(
        sentence: widget.sentenceContainWord + widget.searchWord);
    final docUser = FirebaseFirestore.instance
        .collection(FirebaseConstant.firestore.story)
        .doc(answer);
    await docUser.get().then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          wordDefinitionAnswer = snapshot
                  .data()?['answer']
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '') ??
              '';
        });
      } else {
        _getGeminiAnswerForWord();
      }
    });
  }

  _checkIfSentenceTranslationOnFirestore() async {
    // create md5 from question to compare to see if that md5 is already exist in database
    var answer = Md5Generator.composeMd5IdForStoryFirebaseDb(
        sentence: widget.sentenceContainWord);
    final docUser = FirebaseFirestore.instance
        .collection(FirebaseConstant.firestore.story)
        .doc(answer);
    await docUser.get().then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          sentenceTranslationAnswer = snapshot
                  .data()?['answer']
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '') ??
              '';
        });
      } else {
        _getGeminiAnswerForSentence();
      }
    });
  }

  _getGeminiAnswerForWord() async {
    final question =
        'Translate the English word "[${widget.searchWord}]" in this sentence "[${widget.sentenceContainWord}]" context to Vietnamese and provide the response in the following format:'
        'Phiên âm: /[pronunciation in English]/'
        'Định nghĩa: [definition in Vietnamese]';

    try {
      // gemini.streamGenerateContent(question).listen((value) {
      //   setState(() {
      //     wordDefinitionAnswer += value.output!;
      //   });
      // }).onDone(() {
      //   wordDefinitionAnswer =
      //       wordDefinitionAnswer.replaceAll('[', '').replaceAll(']', '');
      //   _createFirebaseDatabaseItemForWord();
      // });
      gemini.text(question).then((onValue) {
        setState(() {
          wordDefinitionAnswer = onValue?.output ?? '';
          wordDefinitionAnswer =
              wordDefinitionAnswer.replaceAll('[', '').replaceAll(']', '');
        });

        _createFirebaseDatabaseItemForWord(
            word: widget.searchWord,
            sentenceContainWord: widget.sentenceContainWord,
            translatedWord: wordDefinitionAnswer);
      });
    } catch (e) {
      print(e);
      return '';
    }
  }

  _getGeminiAnswerForSentence() async {
    final question =
        'Translate the English sentence "[${widget.sentenceContainWord}]" to Vietnamese and provide the response in the following format:'
        '[translated sentence in Vietnamese]';

    /// Type 1
    try {
      /// Type 1
      // gemini.streamGenerateContent(question).listen((value) {
      //   setState(() {
      //     sentenceTranslationAnswer += value.output!;
      //   });
      // }).onDone(() {
      //   sentenceTranslationAnswer =
      //       sentenceTranslationAnswer.replaceAll('[', '').replaceAll(']', '');
      //   _createFirebaseDatabaseItemForSentence();
      // });
      /// Type 2
      gemini.text(question).then((onValue) {
        setState(() {
          sentenceTranslationAnswer = onValue?.output ?? '';
          sentenceTranslationAnswer =
              sentenceTranslationAnswer.replaceAll('[', '').replaceAll(']', '');
        });

        _createFirebaseDatabaseItemForSentence(
            sentence: widget.sentenceContainWord,
            translatedSentence: sentenceTranslationAnswer);
      });
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<void> _createFirebaseDatabaseItemForWord(
      {required String word,
      required String sentenceContainWord,
      required String translatedWord}) async {
    final answerId = Md5Generator.composeMd5IdForStoryFirebaseDb(
        sentence: sentenceContainWord + word);
    final databaseRow = FirebaseFirestore.instance
        .collection(FirebaseConstant.firestore.story)
        .doc(answerId);
    final json = {
      'question':
          "${word.upperCaseFirstLetter()} - in the sentence: ${sentenceContainWord}",
      'answer': translatedWord,
    };
    await databaseRow.set(json);
  }

  Future<void> _createFirebaseDatabaseItemForSentence(
      {required String sentence, required String translatedSentence}) async {
    final answerId =
        Md5Generator.composeMd5IdForStoryFirebaseDb(sentence: sentence);
    final databaseRow = FirebaseFirestore.instance
        .collection(FirebaseConstant.firestore.story)
        .doc(answerId);
    final json = {
      'question': sentence,
      'answer': translatedSentence,
    };
    await databaseRow.set(json);
  }

  Future<void> _updateFirebaseDatabaseItem(String newAnswer) async {
    final answerId = Md5Generator.composeMd5IdForStoryFirebaseDb(
        sentence: widget.sentenceContainWord + widget.searchWord);
    final databaseRow = FirebaseFirestore.instance
        .collection(FirebaseConstant.firestore.story)
        .doc(answerId);
    final json = {
      'question':
          "${widget.searchWord}- in the sentence: ${widget.sentenceContainWord}",
      'answer': newAnswer,
    };
    await databaseRow.update(json);
  }

  Future<void> _updateFirebaseDatabaseItemForSentence(String newAnswer) async {
    final answerId = Md5Generator.composeMd5IdForStoryFirebaseDb(
        sentence: widget.sentenceContainWord);
    final databaseRow = FirebaseFirestore.instance
        .collection(FirebaseConstant.firestore.story)
        .doc(answerId);
    final json = {
      'question': widget.sentenceContainWord,
      'answer': newAnswer,
    };
    await databaseRow.set(json);
  }

  List<Widget> _highlightWord(String text, String wordToHighlight) {
    List<Widget> spans = [];
    final wordToHighlightRefined =
        wordToHighlight.trim().toLowerCase().removeSpecialCharacters();
    final words = text.split(' ');

    for (final word in words) {
      String wordInSentence =
          word.trim().toLowerCase().removeSpecialCharacters();
      if (wordInSentence == wordToHighlightRefined) {
        spans.add(
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 2.0), // Adjust margin to control spacing
            decoration: BoxDecoration(
              color: context.theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                word,
                style: context.theme.textTheme.titleMedium
                    ?.copyWith(color: context.theme.colorScheme.onPrimary),
              ),
            ),
          ),
        );
      } else {
        spans.add(
          Text(
            '$word ',
            style: context.theme.textTheme.titleMedium?.copyWith(
                color: context.theme.colorScheme.onSurface.withOpacity(.5)),
          ),
        );
      }
    }

    return spans;
  }

  @override
  void dispose() {
    super.dispose();
    _isLoadingStreamController.close();
    _editingController.dispose();
    _editingControllerForSentence.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 28, right: 28, bottom: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isEditing) ...[
                  32.height,
                  Text(
                    'Editor Mode',
                    style: context.theme.textTheme.titleMedium,
                  ),
                  const WaveDivider(
                    thickness: .3,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ],
                _buildHeader(context),
                Wrap(
                  children: _highlightWord(
                      widget.sentenceContainWord, widget.searchWord),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: _isEditing
                ? Column(
                    children: [
                      TextField(
                        controller: _editingController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Edit Answer',
                        ),
                      ),
                      16.height,
                      TextField(
                        controller: _editingControllerForSentence,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Edit Answer For Sentence',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isEditing = false;
                              });
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isEditing = false;
                              });
                              wordDefinitionAnswer =
                                  _editingController.text.trim();
                              _updateFirebaseDatabaseItem(wordDefinitionAnswer);
                              sentenceTranslationAnswer =
                                  _editingControllerForSentence.text.trim();
                              _updateFirebaseDatabaseItemForSentence(
                                  sentenceTranslationAnswer);
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                      300.height,
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              wordDefinitionAnswer,
                              style: context.theme.textTheme.titleMedium
                                  ?.copyWith(
                                      color:
                                          context.theme.colorScheme.onSurface),
                            ),
                            Text(
                              sentenceTranslationAnswer,
                              style: context.theme.textTheme.titleMedium
                                  ?.copyWith(
                                      color:
                                          context.theme.colorScheme.onSurface),
                            ),
                          ],
                        ),
                      ),
                      if (_isEditor)
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _editingController.text = wordDefinitionAnswer;
                                _editingControllerForSentence.text =
                                    sentenceTranslationAnswer;
                                setState(() {
                                  _isEditing = true;
                                });
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Text(widget.searchWord.upperCaseFirstLetter()),
            PlaybackButton(
              message: widget.searchWord,
              icon: Icon(
                Icons.volume_up,
                color: context.theme.colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
        Text("|",
            style: TextStyle(
                color: context.theme.colorScheme.onSurface.withOpacity(.5))),
        16.width,
        Row(
          children: [
            Text('All'.i18n),
            PlaybackButton(
              message: widget.sentenceContainWord,
              icon: Icon(
                Icons.volume_up,
                color: context.theme.colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

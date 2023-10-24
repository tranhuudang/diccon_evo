import 'dart:async';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../dictionary/ui/dictionary.dart';

class DictionarySearchBoxInHome extends StatefulWidget {
  const DictionarySearchBoxInHome({super.key});

  @override
  State<DictionarySearchBoxInHome> createState() =>
      _DictionarySearchBoxInHomeState();
}

class _DictionarySearchBoxInHomeState extends State<DictionarySearchBoxInHome> {
  final _searchTextController = TextEditingController();
  final _closeTextFieldController = StreamController<bool>();

  final _speechToText = SpeechToText();
  bool _speechEnabled = false;
  void _stopListening() async {
    await _speechToText.stop();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _closeTextFieldController.close();
    _searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _closeTextFieldController.stream,
      initialData: false,
      builder: (context, showCloseButton) {
        return Stack(
          children: [
            /// Input box
            TextField(
              controller: _searchTextController,
              onChanged: (value) {
                if (value == "") {
                  _closeTextFieldController.add(false);
                } else {
                  _closeTextFieldController.add(true);
                }
              },
              onSubmitted: (String value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DictionaryView(
                            word: value, buildContext: context)));
                // Remove text in textfield
                _searchTextController.clear();
                _closeTextFieldController.add(false);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                hintText: "Search in dictionary".i18n,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                ),
              ),
            ),

            /// Close button
            if (showCloseButton.data!)
              Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        _searchTextController.clear();
                        // Dismiss keyboard
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        // Erase tiny button
                        _closeTextFieldController.add(false);
                        _closeTextFieldController.add(false);
                      },
                      icon: const Icon(Icons.close))),

            /// Micro button
            if (!showCloseButton.data!)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () async {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        final listeningResultController =
                            StreamController<String>();
                        void onSpeechResult(SpeechRecognitionResult result) {
                          listeningResultController.add(result.recognizedWords);
                        }

                        void startListening() async {
                          await _speechToText.listen(
                              pauseFor: const Duration(seconds: 10),
                              partialResults: true,
                              localeId: 'en',
                              listenMode: ListenMode.search,
                              onResult: onSpeechResult);
                        }

                        /// This has to happen only once per app
                        void initSpeech() async {
                          _speechEnabled = await _speechToText.initialize();
                          if (_speechEnabled) {
                            startListening();
                          } else {
                            if (kDebugMode) {
                              print("Not able to listen");
                            }
                          }
                        }

                        /// Call the function to listen to user
                        initSpeech();
                        return StreamBuilder<String>(
                          initialData: "",
                          stream: listeningResultController.stream,
                          builder: (context, listeningResult) {
                            return SizedBox(
                              height: 300,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          BlendMode.srcIn),
                                      child: const Image(
                                        colorBlendMode: BlendMode.dstOut,
                                        image: AssetImage(
                                            "assets/stickers/listening.png"),
                                        height: 150,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  listeningResult.data!.isEmpty
                                      ? Text("Listening to you...".i18n)
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Text(
                                            listeningResult.data!,
                                            style: listeningResult
                                                        .data!.length <
                                                    40
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall
                                                : listeningResult.data!.length <
                                                        60
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                          ),
                                        ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            _stopListening();

                                            listeningResultController.close();
                                            context.pop();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DictionaryView(
                                                            word:
                                                                listeningResult
                                                                    .data!,
                                                            buildContext:
                                                                context)));
                                          },
                                          icon: Icon(
                                            Icons.send_rounded,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ).whenComplete(() => _stopListening());
                  },
                  icon: const Icon(Icons.mic_none),
                ),
              ),
          ],
        );
      },
    );
  }
}

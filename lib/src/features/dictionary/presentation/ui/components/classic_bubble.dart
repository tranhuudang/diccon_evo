import 'dart:async';
import 'package:diccon_evo/src/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';
class ClassicBubble extends StatefulWidget {
  const ClassicBubble({
    super.key,
    required this.word,
    required this.onWordTap, required this.language,
  });

  final Word word;
  final String language;
  final Function(String) onWordTap;

  @override
  State<ClassicBubble> createState() => _ClassicBubbleState();
}

class _ClassicBubbleState extends State<ClassicBubble> {
  final _showExpandButtonController = StreamController<bool>();


  int countLine() {
    if (widget.word.definition != null) {
      return widget.word.definition!.split('\n').length;
    }
    else {
      return 0;
    }
  }
  @override
  void initState() {
    super.initState();

    if (countLine() > 15) {
      _showExpandButtonController.add(true);
    }
  }
  @override
  void dispose(){
    super.dispose();
    _showExpandButtonController.close();
  }
  @override
  Widget build(BuildContext context) {
    final chatListBloc = context.read<ChatListBloc>();
    return StreamBuilder<bool>(
      initialData: false,
      stream: _showExpandButtonController.stream,
      builder: (context, shouldShowExpandButton) {
        return SizedBox(
          height: shouldShowExpandButton.data! ? 500 : null,
          child: Stack(
            children: [
              /// This widget contains meaning of the word
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          WordTitle(
                            word: widget.word.word,
                            titleColor: context.theme.colorScheme.onSecondary,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          WordPronunciation(
                            color: context.theme.colorScheme.onSecondary,
                              pronunciation: widget.word.pronunciation),
                          PlaybackButton(message: widget.word.word, languageCode: widget.language,),
                        ],
                      ),
                      Row(
                        children: [
                          WordMeaning(
                            message: widget.word,
                            onWordTap: (String currentWord) {
                              chatListBloc
                                  .add(AddUserMessage(providedWord: currentWord));
                              chatListBloc.add(
                                  AddTranslation(providedWord: currentWord));
                            },
                            highlightColor:            context.theme.colorScheme.onSecondary,

                            subColor:   context.theme.colorScheme.onSecondary.withOpacity(.8),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// Show ExpandButton when the number of line in Meaning to large.
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (shouldShowExpandButton.data!)
                    ExpandBubbleButton(
                      onTap: () {
                        _showExpandButtonController.add(false);
                      },
                    ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}

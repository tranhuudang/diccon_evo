import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/word.dart';
import '../../../commons/expand_bubble_button.dart';
import '../../../commons/word_meaning.dart';
import '../../../commons/word_playback_button.dart';
import '../../../commons/word_pronunciation.dart';
import '../../../commons/word_title.dart';
import '../../bloc/chat_list_bloc.dart';

class LocalDictionaryBubble extends StatefulWidget {
  const LocalDictionaryBubble({
    Key? key,
    required this.word,
    this.onWordTap,
  }) : super(key: key);

  final Word word;
  final Function(String)? onWordTap;

  @override
  State<LocalDictionaryBubble> createState() => _LocalDictionaryBubbleState();
}

class _LocalDictionaryBubbleState extends State<LocalDictionaryBubble> {
  bool _isTooLarge = true;
  @override
  void initState() {
    super.initState();

    if (countLine() > 15) {
      setState(() {
        _isTooLarge = true;
      });
    } else {
      setState(() {
        _isTooLarge = false;
      });
    }
  }

  int countLine() {
    if (widget.word.meaning != null) {
      return widget.word.meaning!.split('\n').length;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final chatListBloc = context.read<ChatListBloc>();
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 600,
      ),
      height: _isTooLarge ? 500 : null,
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
                        message: widget.word,
                        titleColor: Theme.of(context).colorScheme.onSecondary,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      WordPronunciation(message: widget.word),
                      WordPlaybackButton(message: widget.word.word),
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
                              AddLocalTranslation(providedWord: currentWord));
                        },
                        highlightColor: Colors.white,
                        subColor: Colors.white70,
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
              if (_isTooLarge)
                ExpandBubbleButton(
                  onTap: () {
                    setState(
                      () {
                        _isTooLarge = !_isTooLarge;
                      },
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

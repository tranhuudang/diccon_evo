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
    required this.message,
    this.onWordTap,
  }) : super(key: key);

  final Word message;
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
    if (widget.message.meaning != null) {
      return widget.message.meaning!.split('\n').length;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final chatListBloc = context.read<ChatListBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 32),
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          height: _isTooLarge ? 500 : null,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(0.0),
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
          ),
          child: Stack(
            children: [
              /// This widget contains meaning of the word
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          WordTitle(
                            message: widget.message,
                            titleColor: Colors.white,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          WordPronunciation(message: widget.message),
                          WordPlaybackButton(message: widget.message.word),
                        ],
                      ),
                      Row(
                        children: [
                          WordMeaning(
                            message: widget.message,
                            onWordTap: (String currentWord) {
                              chatListBloc.add(
                                  AddUserMessage(providedWord: currentWord));
                              chatListBloc.add(AddLocalTranslation(
                                  providedWord: currentWord));
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
                  _isTooLarge
                      ? ExpandBubbleButton(
                          onTap: () {
                            setState(
                              () {
                                _isTooLarge = !_isTooLarge;
                              },
                            );
                          },
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

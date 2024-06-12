import 'package:audioplayers/audioplayers.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/data/data.dart';
import 'package:diccon_evo/src/data/repositories/solo_conversation_repository_impl.dart';
import 'package:diccon_evo/src/domain/repositories/solo_conversation_repository.dart';
import 'package:flutter/material.dart';
import 'package:wave_divider/wave_divider.dart';
import '../../domain/entities/solo_conversation/solo_conversation.dart';

class DialogueScreen extends StatelessWidget {
  final Conversation conversation;

  const DialogueScreen({Key? key, required this.conversation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _soloConversationRepository = SoloConversationRepositoryImpl();
    final _player = SoundHandler();
    return Scaffold(
      appBar: AppBar(
        title: Text(conversation.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(conversation.description),
                Wrap(children: conversation.hashtags.map((item) => TextButton(onPressed: (){}, child: Text(item))).toList(),)
              ],
            ),
            WaveDivider(thickness: .3,),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: conversation.dialogue.length,
              itemBuilder: (context, index) {
                var firstDialogue = conversation.dialogue[0];
                var dialogue = conversation.dialogue[index];
                return Column(
                  children: [
                    8.height,
                    Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: firstDialogue.speaker != dialogue.speaker
                                    ? context.theme.colorScheme.primary
                                    : context.theme.colorScheme.error),
                            child: Text(
                              dialogue.speaker,
                              style: context.theme.textTheme.bodyMedium?.copyWith(
                                  color: firstDialogue.speaker != dialogue.speaker
                                      ? context.theme.colorScheme.onPrimary
                                      : context.theme.colorScheme.onError),
                            )),
                        Spacer(),
                      ],
                    ),
                    4.height,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  final filePath = await _soloConversationRepository
                                      .getAudio(dialogue.english);
                                  if (filePath != '') {
                                    _player.playFromPath(
                                        filePath: filePath,
                                        onFinished: () {},
                                        onPositionChanged: (position) {});
                                  }
                                },
                                icon: Icon(Icons.volume_up)),
                            Expanded(child: Text(dialogue.english)),
                          ],
                        ),
                        Row(
                          children: [
                            Opacity(
                                opacity: 0,
                                child: IconButton(
                                    onPressed: () {}, icon: Icon(Icons.volume_up))),
                            Expanded(
                                child: Text(
                              dialogue.vietnamese,
                              style: context.theme.textTheme.bodyMedium?.copyWith(
                                  color: context.theme.textTheme.bodyMedium?.color
                                      ?.withOpacity(.5)),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

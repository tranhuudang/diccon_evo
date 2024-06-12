import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/data/data.dart';
import 'package:diccon_evo/src/data/repositories/solo_conversation_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'package:wave_divider/wave_divider.dart';
import '../../../../domain/domain.dart';

class DialogueView extends StatefulWidget {
  final List<Conversation> listConversation;
  final Conversation conversation;

  const DialogueView({super.key, required this.conversation, required this.listConversation});

  @override
  State<DialogueView> createState() => _DialogueViewState();
}

class _DialogueViewState extends State<DialogueView> {
  @override
  Widget build(BuildContext context) {
    final soloConversationRepository = SoloConversationRepositoryImpl();
    final player = SoundHandler();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.conversation.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.conversation.description),
                Wrap(children: widget.conversation.hashtags.map((hashtag) => TextButton(onPressed: (){
                  showSearchPageWithHashtag(context, hashtag);

                }, child: Text(hashtag))).toList(),)
              ],
            ),
            const WaveDivider(thickness: .3,),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.conversation.dialogue.length,
              itemBuilder: (context, index) {
                var firstDialogue = widget.conversation.dialogue[0];
                var dialogue = widget.conversation.dialogue[index];
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
                        const Spacer(),
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
                                  final filePath = await soloConversationRepository
                                      .getAudio(dialogue.english);
                                  if (filePath != '') {
                                    player.playFromPath(
                                        filePath: filePath,
                                        onFinished: () {},
                                        onPositionChanged: (position) {});
                                  }
                                },
                                icon: const Icon(Icons.volume_up)),
                            Expanded(child: Text(dialogue.english)),
                          ],
                        ),
                        Row(
                          children: [
                            Opacity(
                                opacity: 0,
                                child: IconButton(
                                    onPressed: () {

                                    }, icon: const Icon(Icons.volume_up))),
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

  void showSearchPageWithHashtag(BuildContext context, String hashtag) {
    showSearch(
      context: context,
      delegate: SearchPage<Conversation>(
        items: widget.listConversation,
        searchLabel: 'Find a conversation'.i18n,
        searchStyle: context.theme.textTheme.titleMedium,
        suggestion: Center(child: Text('Search with hashtag: $hashtag')),
        failure: Center(
          child: Text('No matching conversation found'.i18n),
        ),
        filter: (conversation) =>
        [conversation.title, conversation.hashtags.toString(), conversation.description],
        builder: (conversation) => ListTile(
          title: Text(conversation.title),
          titleTextStyle: context.theme.textTheme.titleMedium,
          subtitle: Opacity(
              opacity: .5,
              child: Text(
                conversation.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )),
          subtitleTextStyle: context.theme.textTheme.bodyMedium,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DialogueView(conversation: conversation, listConversation: widget.listConversation,)));
          },
        ),
      ),
      query: hashtag,
    );
  }
}

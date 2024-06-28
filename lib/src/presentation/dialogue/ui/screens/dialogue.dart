import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_page/search_page.dart';
import 'package:upgrader/upgrader.dart';
import 'package:wave_divider/wave_divider.dart';
import '../../../../domain/domain.dart';
import '../../data/bloc/dialogue_bloc.dart';
import '../../data/bloc/dialogue_event.dart';
import '../../data/bloc/dialogue_state.dart';

class DialogueView extends StatelessWidget {
  final List<Conversation> listConversation;
  final Conversation conversation;

  const DialogueView({
    super.key,
    required this.conversation,
    required this.listConversation,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DialogueBloc()
        ..add(GetNumberOfLikes(conversation.description))
        ..add(MarkAsRead(conversation.description)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(conversation.title),
        ),
        body: BlocBuilder<DialogueBloc, DialogueState>(
          builder: (context, state) {
            final dialogueBloc = context.read<DialogueBloc>();
            if (state is DialogueLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is DialogueError) {
              return Center(child: Text(state.error));
            } else {
              return SingleChildScrollView(
                controller: dialogueBloc.scrollController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(conversation.description),
                        Wrap(
                          children: conversation.hashtags
                              .map((hashtag) => TextButton(
                                    onPressed: () {
                                      showSearchPageWithHashtag(
                                          context, hashtag);
                                    },
                                    child: Text(hashtag.toLowerCase()),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                    const WaveDivider(thickness: .3),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: conversation.dialogue.length,
                      itemBuilder: (context, index) {
                        var firstDialogue = conversation.dialogue[0];
                        var dialogue = conversation.dialogue[index];
                        return Column(
                          children: [
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: firstDialogue.speaker !=
                                            dialogue.speaker
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.error,
                                  ),
                                  child: Text(
                                    dialogue.speaker,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: firstDialogue.speaker !=
                                                  dialogue.speaker
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onError,
                                        ),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            SizedBox(height: 4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        // Your existing audio playback logic
                                      },
                                      icon: const Icon(Icons.volume_up),
                                    ),
                                    Expanded(child: Text(dialogue.english)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Opacity(
                                      opacity: 0,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.volume_up),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        dialogue.vietnamese,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.color
                                                  ?.withOpacity(.5),
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 8),
                    const WaveDivider(thickness: .3),
                    SizedBox(height: 8),
                    if (state is NumberOfLikesState && state.numberOfLikes > 1)
                      Text(
                        '${state.numberOfLikes} people find this dialogue helpful.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color
                                  ?.withOpacity(.5),
                            ),
                      ),
                    SizedBox(height: 8),
                    if (state is! FeedbackGivenState)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Do you find this dialogue is helpful?'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        context.read<DialogueBloc>().add(
                                            IncreaseLikeCount(
                                                conversation.description));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Thank you for your feedback!')),
                                        );
                                      },
                                      icon: const Icon(
                                          Icons.thumb_up_alt_outlined),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context.read<DialogueBloc>().add(
                                            IncreaseDislikeCount(
                                                conversation.description));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Thank you for your feedback!')),
                                        );
                                      },
                                      icon: const Icon(
                                          Icons.thumb_down_alt_outlined),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void showSearchPageWithHashtag(BuildContext context, String hashtag) {
    showSearch(
      context: context,
      delegate: SearchPage<Conversation>(
        items: listConversation,
        searchLabel: 'Find a conversation',
        searchStyle: Theme.of(context).textTheme.titleMedium,
        suggestion: Center(child: Text('Search with hashtag: $hashtag')),
        failure: Center(child: Text('No matching conversation found')),
        filter: (conversation) => [
          conversation.title,
          conversation.hashtags.toString(),
          conversation.description,
        ],
        builder: (conversation) => ListTile(
          title: Text(conversation.title),
          titleTextStyle: Theme.of(context).textTheme.titleMedium,
          subtitle: Opacity(
            opacity: .5,
            child: Text(
              conversation.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitleTextStyle: Theme.of(context).textTheme.bodyMedium,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DialogueView(
                  conversation: conversation,
                  listConversation: listConversation,
                ),
              ),
            );
          },
        ),
      ),
      query: hashtag,
    );
  }
}

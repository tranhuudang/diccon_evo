import 'package:diccon_evo/src/presentation/dialogue/data/bloc/list_dialogue_bloc.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/presentation/story/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BlocProviderScope extends StatelessWidget {
  final Widget child;
  const BlocProviderScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(create: (context) => UserBloc()),
          BlocProvider<SettingBloc>(create: (context) => SettingBloc()),
          BlocProvider<ChatListBloc>(create: (context) => ChatListBloc()),
          BlocProvider<TextRecognizerBloc>(
              create: (context) => TextRecognizerBloc()),
          BlocProvider<ChatbotBloc>(
              create: (context) => ChatbotBloc()),
          BlocProvider<StoryListBloc>(create: (context) => StoryListBloc()),
          BlocProvider<StoryHistoryBloc>(create: (context) => StoryHistoryBloc()),
          BlocProvider<StoryBookmarkBloc>(create: (context) => StoryBookmarkBloc()),
          BlocProvider<StoryListAllBloc>(create: (context) => StoryListAllBloc()),
          BlocProvider<ReadingBloc>(create: (context) => ReadingBloc()),
          BlocProvider<VoiceBloc>(create: (context) => VoiceBloc()),
          BlocProvider<GroupChatBloc>(create: (context) => GroupChatBloc()),
          BlocProvider<DictionaryPreferencesBloc>(create: (context) => DictionaryPreferencesBloc()),
          BlocProvider<ListDialogueBloc>(create: (context) => ListDialogueBloc()),
        ],
        child: child,);
  }
}

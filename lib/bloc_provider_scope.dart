import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/presentation/story/bloc/bloc.dart';
import 'package:diccon_evo/src/presentation/story/bloc/story_list_all_bloc.dart';
import 'package:diccon_evo/src/presentation/story/bloc/story_list_bloc.dart';
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
          BlocProvider<ConversationBloc>(
              create: (context) => ConversationBloc()),
          BlocProvider<StoryListBloc>(create: (context) => StoryListBloc()),
          BlocProvider<StoryListAllBloc>(create: (context) => StoryListAllBloc()),
          BlocProvider<ReadingBloc>(create: (context) => ReadingBloc()),
        ],
        child: child);
  }
}

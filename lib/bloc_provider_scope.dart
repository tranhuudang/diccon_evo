import 'package:diccon_evo/src/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

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
        ],
        child: child);
  }
}

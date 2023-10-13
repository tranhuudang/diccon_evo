import 'dart:io';
import 'package:diccon_evo/extensions/theme_mode.dart';
import 'package:diccon_evo/config/route_configurations.dart';
import 'package:diccon_evo/screens/story/blocs/story_list_bloc.dart';
import 'package:diccon_evo/screens/conversation/bloc/conversation_bloc.dart';
import 'package:diccon_evo/screens/settings/bloc/user_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/properties_constants.dart';
import 'screens/dictionary/bloc/chat_list_bloc.dart';
import 'config/properties.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:diccon_evo/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Properties.getSettings();

  /// Initial Firebase
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.android,
    );
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
    );

  }


  /// Initial for Windows
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();

    /// register player first
    WindowManager.instance.setSize(Size(Properties.defaultSetting.windowsWidth,
        Properties.defaultSetting.windowsHeight));
    WindowManager.instance.setMinimumSize(PropertiesConstants.minWindowsSize);
    WindowManager.instance.setMaximumSize(PropertiesConstants.maxWindowsSize);
    WindowManager.instance.setTitle(PropertiesConstants.diccon);
  }

  runApp(const ProgramRoot());
}

class ProgramRoot extends StatelessWidget {
  const ProgramRoot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (context) => UserBloc()),
        BlocProvider<ChatListBloc>(create: (context) => ChatListBloc()),
        BlocProvider<ConversationBloc>(create: (context) => ConversationBloc()),
        BlocProvider<StoryListBloc>(create: (context) => StoryListBloc()),
      ],
      child: MaterialApp.router(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', "US"),
          Locale('vi', "VI"),
        ],
        locale: Properties.defaultSetting.language == "English"
            ? const Locale('en', "US")
            : const Locale('vi', "VI"),
        themeMode: Properties.defaultSetting.themeMode.toThemeMode(),
        theme: CustomTheme.getLight(context),
        darkTheme: CustomTheme.getDark(context),
        title: PropertiesConstants.diccon,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}

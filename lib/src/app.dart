import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

import 'features/dictionary/bloc/text_recognizer_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(create: (context) => UserBloc()),
          BlocProvider<SettingBloc>(create: (context) => SettingBloc()),
          BlocProvider<ChatListBloc>(create: (context) => ChatListBloc()),
          BlocProvider<TextRecognizerBloc>(create: (context) => TextRecognizerBloc()),
          BlocProvider<ConversationBloc>(
              create: (context) => ConversationBloc()),
          BlocProvider<StoryListBloc>(create: (context) => StoryListBloc()),
        ],
        child: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            return DynamicColorBuilder(
                builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
              ColorScheme lightColorScheme;
              ColorScheme darkColorScheme;
              if ((state.params.enableAdaptiveTheme) &&
                  (lightDynamic != null && darkDynamic != null)) {
                /// If not set we use adaptive theme
                if (kDebugMode) {
                  print("Adaptive theme available");
                }
                lightColorScheme = lightDynamic.harmonized();
                darkColorScheme = darkDynamic.harmonized();
                return buildMaterialApp(
                    themeMode: state.params.themeMode,
                    lightColorScheme: lightColorScheme,
                    darkColorScheme: darkColorScheme,
                    language: state.params.language.toLocale());
              } else {
                if (kDebugMode) {
                  print("Manual create a new color scheme for theme");
                }
                lightColorScheme = ColorScheme.fromSeed(
                  seedColor: state.params.accentColor,
                );
                darkColorScheme = ColorScheme.fromSeed(
                  seedColor: state.params.accentColor,
                  brightness: Brightness.dark,
                );
                return buildMaterialApp(
                    themeMode: state.params.themeMode,
                    lightColorScheme: lightColorScheme,
                    darkColorScheme: darkColorScheme,
                    language: state.params.language.toLocale());
              }
            });
          },
        ));
  }
}

MaterialApp buildMaterialApp(
    {required ThemeMode themeMode,
    required ColorScheme lightColorScheme,
    required ColorScheme darkColorScheme,
    required Locale language}) {
  return MaterialApp.router(
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en', "US"),
      Locale('vi', "VI"),
    ],
    locale: language,
    themeMode: themeMode,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
    ),
    darkTheme: ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
    ),
    title: PropertiesConstants.diccon,
    debugShowCheckedModeBanner: false,
    routerConfig: router,
  );
}

import 'dart:io';
import 'package:diccon_evo/config/route_configurations.dart';
import 'package:diccon_evo/extensions/theme_mode.dart';
import 'package:diccon_evo/screens/settings/bloc/setting_bloc.dart';
import 'package:diccon_evo/screens/story/blocs/story_list_bloc.dart';
import 'package:diccon_evo/screens/conversation/bloc/conversation_bloc.dart';
import 'package:diccon_evo/screens/settings/bloc/user_bloc.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/properties_constants.dart';
import 'screens/dictionary/bloc/chat_list_bloc.dart';
import 'config/properties.dart';
import 'package:firebase_core/firebase_core.dart';
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

class ProgramRoot extends StatefulWidget {
  const ProgramRoot({super.key});

  @override
  State<ProgramRoot> createState() => _ProgramRootState();
}

class _ProgramRootState extends State<ProgramRoot> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (context) => UserBloc()),
        BlocProvider<SettingBloc>(create: (context) => SettingBloc()),
        BlocProvider<ChatListBloc>(create: (context) => ChatListBloc()),
        BlocProvider<ConversationBloc>(create: (context) => ConversationBloc()),
        BlocProvider<StoryListBloc>(create: (context) => StoryListBloc()),
      ],
      child: BlocBuilder<SettingBloc, SettingState>(builder: (context, state) {
        return DynamicColorBuilder(
          builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            ColorScheme lightColorScheme;
            ColorScheme darkColorScheme;
            // Switcher of theme color
            switch (state.runtimeType) {
              case SettingInitial:
                if (Properties.defaultSetting.themeColor != 0) {
                  /// Custom theme that user set in setting
                  lightColorScheme = ColorScheme.fromSeed(
                    seedColor: Color(Properties.defaultSetting.themeColor),
                  );
                  darkColorScheme = ColorScheme.fromSeed(
                    seedColor: Color(Properties.defaultSetting.themeColor),
                    brightness: Brightness.dark,
                  );
                } else {
                  /// If adaptive theme is not available, we create a new one
                  lightColorScheme = ColorScheme.fromSeed(
                    seedColor: Colors.blue,
                  );
                  darkColorScheme = ColorScheme.fromSeed(
                    seedColor: Colors.blue,
                    brightness: Brightness.dark,
                  );
                }
                break;
              case ChangeThemeColor:
                final data = state as ChangeThemeColor;
                lightColorScheme = ColorScheme.fromSeed(
                  seedColor: data.color,
                );
                darkColorScheme = ColorScheme.fromSeed(
                  seedColor: data.color,
                  brightness: Brightness.dark,
                );
                break;
              case AdaptiveThemeColor:
                if (lightDynamic != null && darkDynamic != null) {
                  /// If not set we use adaptive theme

                  if (kDebugMode) {
                    print("Adaptive theme available");
                  }
                  lightColorScheme = lightDynamic.harmonized();
                  darkColorScheme = darkDynamic.harmonized();
                } else {
                  if (kDebugMode) {
                    print("Manual create a new color scheme for theme");
                  }
                  lightColorScheme = ColorScheme.fromSeed(
                    seedColor: Colors.blue,
                  );
                  darkColorScheme = ColorScheme.fromSeed(
                    seedColor: Colors.blue,
                    brightness: Brightness.dark,
                  );
                }
                break;
              case ThemeModeChanged:

              default:
                if (kDebugMode) {
                  print("Manual create a new color scheme for theme");
                }
                lightColorScheme = ColorScheme.fromSeed(
                  seedColor: Color(Properties.defaultSetting.themeColor),
                );
                darkColorScheme = ColorScheme.fromSeed(
                  seedColor: Color(Properties.defaultSetting.themeColor),
                  brightness: Brightness.dark,
                );
            }
            // Condition cases for dark mode
            var themeMode = Properties.defaultSetting.themeMode.toThemeMode();
            if (state is ThemeModeChanged) {
              themeMode = state.themeMode;
            }
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
              locale: Properties.defaultSetting.language == "English"
                  ? const Locale('en', "US")
                  : const Locale('vi', "VI"),
              themeMode: themeMode,
              theme: ThemeData(
                colorScheme: lightColorScheme,
              ),
              darkTheme: ThemeData(
                colorScheme: darkColorScheme,
              ),
              title: PropertiesConstants.diccon,
              debugShowCheckedModeBanner: false,
              routerConfig: router,
            );
          },
        );
      }),
    );
  }
}

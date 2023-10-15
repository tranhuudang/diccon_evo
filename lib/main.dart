import 'dart:io';
import 'package:diccon_evo/extensions/theme_mode.dart';
import 'package:diccon_evo/config/route_configurations.dart';
import 'package:diccon_evo/screens/story/blocs/story_list_bloc.dart';
import 'package:diccon_evo/screens/conversation/bloc/conversation_bloc.dart';
import 'package:diccon_evo/screens/settings/bloc/user_bloc.dart';
import 'package:dynamic_color/dynamic_color.dart';
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



class ProgramRoot extends StatefulWidget {
  const ProgramRoot({super.key});

  @override
  State<ProgramRoot> createState() => _ProgramRootState();
}

class _ProgramRootState extends State<ProgramRoot> {

  final _brandBlue = Color(0xFF1E88E5);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          ColorScheme lightColorScheme;
          ColorScheme darkColorScheme;

          if (lightDynamic != null && darkDynamic != null) {
            // On Android S+ devices, use the provided dynamic color scheme.
            // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
            lightColorScheme = lightDynamic.harmonized();
            // (Optional) Customize the scheme as desired. For example, one might
            // want to use a brand color to override the dynamic [ColorScheme.secondary].
            //lightColorScheme = lightColorScheme.copyWith(secondary: Colors.red);
            // (Optional) If applicable, harmonize custom colors.
            //lightCustomColors = lightCustomColors.harmonized(lightColorScheme);

            // Repeat for the dark color scheme.
            darkColorScheme = darkDynamic.harmonized();
            //darkColorScheme = darkColorScheme.copyWith(secondary: Colors.red);
            // = darkColorScheme.copyWith(primary: Colors.red);
            //darkCustomColors = darkCustomColors.harmonized(darkColorScheme);

            //_isDemoUsingDynamicColors = true; // ignore, only for demo purposes
          } else {
            // Otherwise, use fallback schemes.
            lightColorScheme = ColorScheme.fromSeed(
              seedColor: _brandBlue,
            );
            darkColorScheme = ColorScheme.fromSeed(
              seedColor: _brandBlue,
              brightness: Brightness.dark,
            );
          }

          return MultiBlocProvider(
            providers: [
              BlocProvider<UserBloc>(create: (context) => UserBloc()),
              BlocProvider<ChatListBloc>(create: (context) => ChatListBloc()),
              BlocProvider<ConversationBloc>(
                  create: (context) => ConversationBloc()),
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
              // theme: CustomTheme.getLight(context),
              // darkTheme: CustomTheme.getDark(context),
              theme: ThemeData(
                colorScheme: lightColorScheme,
                //extensions: [lightCustomColors],
              ),
              darkTheme: ThemeData(
                colorScheme: darkColorScheme,
                //extensions: [darkCustomColors],
              ),
              title: PropertiesConstants.diccon,
              debugShowCheckedModeBanner: false,
              routerConfig: router,
            ),
          );
        });
  }
}
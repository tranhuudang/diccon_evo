import 'dart:io';
import 'package:diccon_evo/cubits/clickable_word_cubit.dart';
import 'package:diccon_evo/cubits/video_history_list_cubit.dart';
import 'package:diccon_evo/cubits/word_history_list_cubit.dart';
import 'package:diccon_evo/cubits/video_list_cubit.dart';
import 'package:diccon_evo/home.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/article_history_list_cubit.dart';
import 'cubits/article_list_cubit.dart';
import 'cubits/setting_cubit.dart';
import 'firebase_options.dart';
import 'properties.dart';
import 'package:video_player_win/video_player_win_plugin.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'themeData.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Properties.getSettings();

  // if (Platform.isAndroid) {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();

    /// register player first
    WindowsVideoPlayer.registerWith();
    WindowManager.instance
        .setSize(Size(Properties.defaultWindowWidth, Properties.defaultWindowHeight));
    WindowManager.instance
        .setMinimumSize(const Size(Properties.MIN_WIDTH, Properties.MIN_HEIGHT));
    WindowManager.instance.setTitle(Properties.DICCON_DICTIONARY);
  }

  /// Initialize Video Player for Desktop devices

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
          BlocProvider<ArticleListCubit>(
            create: (context) => ArticleListCubit(),
          ),
          BlocProvider<HistoryListCubit>(
            create: (context) => HistoryListCubit(),
          ),
          BlocProvider<SettingCubit>(
            create: (context) => SettingCubit(),
          ),
          BlocProvider<ArticleHistoryListCubit>(
            create: (context) => ArticleHistoryListCubit(),
          ),
          BlocProvider<ClickableWordCubit>(
            create: (context) => ClickableWordCubit(),
          ),
          BlocProvider<VideoHistoryListCubit>(
            create: (context) => VideoHistoryListCubit(),
          ),
          BlocProvider<VideoListCubit>(
            create: (context) => VideoListCubit(),
          ),
        ],
        child: MaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', "US"),
              Locale('vi', "VI"),
            ],

            themeMode: ThemeMode.system,
            theme: CustomTheme.getLight(context),
            darkTheme: CustomTheme.getDark(context),
            title: Properties.DICCON_DICTIONARY,
            debugShowCheckedModeBanner: false,
            home: I18n(
                //initialLocale: const Locale("vi", "VI"),
                child: const HomeView())));
  }
}

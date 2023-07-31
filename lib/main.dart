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
import 'global.dart';
import 'package:video_player_win/video_player_win_plugin.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Global.getSettings();

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    /// register player first
    WindowsVideoPlayer.registerWith();
    WindowManager.instance.setSize(Size(Global.defaultWindowWidth, Global.defaultWindowHeight));
    WindowManager.instance
        .setMinimumSize(const Size(Global.MIN_WIDTH, Global.MIN_HEIGHT));
    WindowManager.instance.setTitle(Global.DICCON_DICTIONARY);
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
            themeMode: ThemeMode.light,
            theme: ThemeData.light().copyWith(
              // Customize light theme properties
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.blue, // Light mode background color
                selectedItemColor:
                    Colors.black, // Light mode selected item color
                unselectedItemColor:
                    Colors.grey, // Light mode unselected item color
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              // Customize dark theme properties
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.grey[900], // Dark mode background color
                selectedItemColor:
                    Colors.white, // Dark mode selected item color
                unselectedItemColor:
                    Colors.grey, // Dark mode unselected item color
              ),
            ),
            title: Global.DICCON_DICTIONARY,
            debugShowCheckedModeBanner: false,
            home: const HomeView()));
  }
}

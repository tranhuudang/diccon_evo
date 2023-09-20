import 'dart:io';
import 'package:diccon_evo/extensions/theme_mode.dart';
import 'package:diccon_evo/screens/article/cubits/article_bookmark_list_cubit.dart';
import 'package:diccon_evo/screens/article/cubits/article_history_list_cubit.dart';
import 'package:diccon_evo/screens/article/cubits/article_list_cubit.dart';
import 'package:diccon_evo/screens/commons/clickable_word/cubit/clickable_word_cubit.dart';
import 'package:diccon_evo/screens/commons/quote_box/bloc/quote_bloc.dart';
import 'package:diccon_evo/screens/dictionary/cubit/word_history_list_cubit.dart';
import 'package:diccon_evo/home_control.dart';
import 'package:diccon_evo/screens/settings/bloc/user_bloc.dart';
import 'package:diccon_evo/screens/settings/cubit/setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/dictionary/bloc/chat_list_bloc.dart';
import 'config/properties.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:diccon_evo/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Properties.getSettings();

  /// Initial Firebase
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
    );
  }
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();

    /// register player first
    WindowManager.instance.setSize(
        Size(Properties.defaultSetting.windowsWidth, Properties.defaultSetting.windowsHeight));
    WindowManager.instance
        .setMinimumSize(const Size(Properties.minWidth, Properties.minHeight));
    WindowManager.instance.setTitle(Properties.diccon);
    WindowManager.instance
        .setMaximumSize(const Size(Properties.minWidth + 100, 10000));
    WindowManager.instance.setTitle(Properties.diccon);
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
        BlocProvider<ArticleListCubit>(
          create: (context) => ArticleListCubit(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        BlocProvider<ArticleHistoryListCubit>(
          create: (context) => ArticleHistoryListCubit(),
        ),
        BlocProvider<ArticleBookmarkListCubit>(
          create: (context) => ArticleBookmarkListCubit(),
        ),
        BlocProvider<ChatListBloc>(create: (context) => ChatListBloc()),
        BlocProvider<HistoryListCubit>(create: (context) => HistoryListCubit()),
        BlocProvider<SettingCubit>(
          create: (context) => SettingCubit(),
        ),
        BlocProvider<ClickableWordCubit>(
          create: (context) => ClickableWordCubit(),
        ),
        BlocProvider<QuoteBloc>(create: (context) => QuoteBloc()),
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
        locale: Properties.defaultSetting.language == "English"
            ? const Locale('en', "US")
            : const Locale('vi', "VI"),
        themeMode: Properties.defaultSetting.themeMode.toThemeMode(),
        theme: CustomTheme.getLight(context),
        darkTheme: CustomTheme.getDark(context),
        title: Properties.diccon,
        debugShowCheckedModeBanner: false,
        home: I18n(
          child: const HomeControlView(),
        ),
      ),
    );
  }
}

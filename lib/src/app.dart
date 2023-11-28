import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return DynamicColorBuilder(
            builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          ColorScheme lightColorScheme;
          ColorScheme darkColorScheme;
          if ((state.params.enableAdaptiveTheme) &&
              (lightDynamic != null && darkDynamic != null)) {
            // If not set we use adaptive theme
            if (kDebugMode) {
              print("Adaptive theme available");
            }
            lightColorScheme = lightDynamic.harmonized();
            darkColorScheme = darkDynamic.harmonized();
            return buildMaterialApp(state, lightColorScheme, darkColorScheme);
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
            return buildMaterialApp(state, lightColorScheme, darkColorScheme);
          }
        });
      },
    );
  }

  MaterialApp buildMaterialApp(SettingState state, ColorScheme lightColorScheme,
      ColorScheme darkColorScheme) {
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
      locale: state.params.language.toLocale(),
      themeMode: state.params.themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      title: DefaultSettings.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
    );
  }
}

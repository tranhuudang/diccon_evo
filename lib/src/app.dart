import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/core/router/route_configurations_desktop.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

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
            lightColorScheme = lightDynamic.harmonized();
            darkColorScheme = darkDynamic.harmonized();
            return buildMaterialApp(state, lightColorScheme, darkColorScheme);
          } else {
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

  FlutterSizer buildMaterialApp(SettingState state,
      ColorScheme lightColorScheme, ColorScheme darkColorScheme) {
    return FlutterSizer(
      builder: (context, orientation, screenType) {
        return ScreenTypeLayout.builder(mobile: (context) {
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
            theme: lightTheme(colorScheme: lightColorScheme),
            darkTheme: darkTheme(colorScheme: darkColorScheme),
            title: DefaultSettings.appName,
            debugShowCheckedModeBanner: false,
            routerConfig: routerConfig,
          );
        }, tablet: (context) {
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
            theme: lightTheme(colorScheme: lightColorScheme),
            darkTheme: darkTheme(colorScheme: darkColorScheme),
            title: DefaultSettings.appName,
            debugShowCheckedModeBanner: false,
            routerConfig: routerConfigDesktop,
          );
        });
      }
    );
  }
}

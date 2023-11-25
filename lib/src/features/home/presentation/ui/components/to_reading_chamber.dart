import 'package:go_router/go_router.dart';
import 'package:metaballs/metaballs.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class ToReadingChamberButton extends StatelessWidget {
  const ToReadingChamberButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final onPrimary = context.theme.colorScheme.onPrimary;
    return FeatureButton(
      borderColor: context.theme.scaffoldBackgroundColor,
      padding: EdgeInsets.zero,
      onTap: () {
        context.pushNamed(RouterConstants.readingChamber);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            if (Properties.instance.settings.themeMode.toThemeMode() ==
                ThemeMode.light)
              Metaballs(
                color: Theme.of(context).colorScheme.primary,
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.tertiary,
                ], begin: Alignment.bottomRight, end: Alignment.topLeft),
                metaballs: 40,
                animationDuration: const Duration(milliseconds: 200),
                speedMultiplier: 1,
                bounceStiffness: 3,
                minBallRadius: 40,
                maxBallRadius: 90,
                glowRadius: .8,
                glowIntensity: 0.9,
              ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              color: context.theme.colorScheme.primary.withOpacity(
                  Properties.instance.settings.themeMode.toThemeMode() ==
                          ThemeMode.light
                      ? 0.0
                      : 1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  Icon(Icons.book,
                      size: 30, color: context.theme.colorScheme.onPrimary),
                  const VerticalSpacing.small(),
                  Text(
                    "Short stories in".i18n,
                    style: context.theme.textTheme.labelSmall
                        ?.copyWith(color: onPrimary),
                  ),
                  Text(
                    "Library".i18n,
                    style: context.theme.textTheme.titleLarge?.copyWith(
                        color: onPrimary, fontWeight: FontWeight.w500),
                  ),
                  const VerticalSpacing.large(),
                ],
              ),
            ),
            if (Properties.instance.settings.themeMode.toThemeMode() !=
                ThemeMode.light)
              Opacity(
                opacity: .5,
                child: WaveWidget(
                  duration: 3000,
                  config: CustomConfig(
                    colors: [
                      Colors.white70,
                      Colors.white54,
                      Colors.white30,
                      Colors.white24,
                    ],
                    durations: [32000, 21000, 18000, 5000],
                    heightPercentages: [0.75, 0.66, 0.68, 0.71],
                  ),
                  size: const Size(double.infinity, double.infinity),
                  waveAmplitude: 0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

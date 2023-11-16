import 'package:go_router/go_router.dart';
import 'package:metaballs/metaballs.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';
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
            Metaballs(
                color: Theme.of(context).colorScheme.primary,
                effect: MetaballsEffect.follow(
                  growthFactor: 1,
                  smoothing: 1,
                  radius: 0.5,
                ),
                gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.tertiary,
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft
                ),
                metaballs: 40,
                animationDuration: const Duration(milliseconds: 200),
                speedMultiplier: 1,
                bounceStiffness: 3,
                minBallRadius: 40,
                maxBallRadius: 60,
                glowRadius: .8,
                glowIntensity: 0.9,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              color: context.theme.colorScheme.primary.withOpacity(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 14,),
                  Icon(Icons.book,
                      size: 30,
                      color: context.theme.colorScheme.onPrimary),
                  const VerticalSpacing.small(),
                  Text(
                    "Short stories in".i18n,
                    style: context.theme.textTheme.labelSmall?.copyWith(color:onPrimary ),
                  ),
                  Text(
                    "Library".i18n,
                    style:  context.theme.textTheme.titleLarge?.copyWith(color:onPrimary, fontWeight: FontWeight.w500 ),
                  ),
                  const VerticalSpacing.large(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

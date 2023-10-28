import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:diccon_evo/features/features.dart';
import 'package:diccon_evo/common/common.dart';
class FeedbackHelper {
  static void showFeedbackBottomSheet(BuildContext context) {
    if ((Properties.defaultSetting.openAppCount == 10) ||
        (Properties.defaultSetting.openAppCount == 50) ||
        (Properties.defaultSetting.openAppCount == 100)) {
      showModalBottomSheet(
        backgroundColor: context.theme.colorScheme.secondaryContainer,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              height: 320,
              child: Column(
                children: [
                  const Expanded(
                    child: Image(
                      image: AssetImage("assets/stickers/geography.png"),
                    ),
                  ),
                  Center(
                    child: Text("We'd love to hear your feedback!".i18n,
                        style: context.theme.textTheme.titleLarge?.copyWith(
                            color: context.theme
                                .colorScheme
                                .onSecondaryContainer)),
                  ),
                  const VerticalSpacing.large(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PillButton(
                          color: context.theme.colorScheme.onPrimary,
                          backgroundColor:
                              context.theme.colorScheme.primary,
                          onTap: () {
                            Properties.defaultSetting =
                                Properties.defaultSetting.copyWith(
                                    openAppCount:
                                        Properties.defaultSetting.openAppCount +
                                            1);
                            Properties.saveSettings(Properties.defaultSetting);
                            goToStoreListing();
                          },
                          title: "Give feedbacks".i18n),
                      const HorizontalSpacing.large(),
                      PillButton(
                          color: context.theme
                              .colorScheme
                              .onSecondaryContainer,
                          backgroundColor:
                              context.theme.colorScheme.secondaryContainer,
                          onTap: () {
                            Properties.defaultSetting =
                                Properties.defaultSetting.copyWith(
                                    openAppCount:
                                        Properties.defaultSetting.openAppCount +
                                            1);
                            Properties.saveSettings(Properties.defaultSetting);
                            context.pop();
                          },
                          title: "Later".i18n),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  static void goToStoreListing() async {
    if (defaultTargetPlatform.isMobile()) {
      final Uri url = Uri.parse(
          'https://play.google.com/store/apps/details?id=com.zeroboy.diccon_evo');
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } else {
      final Uri url = Uri.parse(
          'https://apps.microsoft.com/store/detail/diccon-evo/9NPF4HBMNG5D');
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }
  }
}

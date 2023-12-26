import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';

class SeekFeedback {
  static void showFeedbackBottomSheet(BuildContext context) {
    if ((Properties.instance.settings.openAppCount == 10) ||
        (Properties.instance.settings.openAppCount == 50) ||
        (Properties.instance.settings.openAppCount == 100)) {
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
                  Expanded(
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          context.theme.colorScheme.primary, BlendMode.srcIn),
                      child: Image(
                        image: AssetImage(
                            LocalDirectory.commonIllustration),
                      ),
                    ),
                  ),
                  8.height,
                  Center(
                    child: Text("We'd love to hear your feedback!".i18n,
                        style: context.theme.textTheme.titleLarge?.copyWith(
                            color: context
                                .theme.colorScheme.onSecondaryContainer)),
                  ),
                  16.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PillButton(
                          color: context.theme.colorScheme.onPrimary,
                          backgroundColor: context.theme.colorScheme.primary,
                          onTap: () {
                            Properties.instance.settings =
                                Properties.instance.settings.copyWith(
                                    openAppCount: Properties
                                            .instance.settings.openAppCount +
                                        1);
                            Properties.instance
                                .saveSettings(Properties.instance.settings);
                            goToStoreListing();
                          },
                          title: "Give feedbacks".i18n),
                      16.height,
                      PillButton(
                          color: context.theme.colorScheme.onSecondaryContainer,
                          backgroundColor:
                              context.theme.colorScheme.secondaryContainer,
                          onTap: () {
                            Properties.instance.settings =
                                Properties.instance.settings.copyWith(
                                    openAppCount: Properties
                                            .instance.settings.openAppCount +
                                        1);
                            Properties.instance
                                .saveSettings(Properties.instance.settings);
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

import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/target_platform.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../settings/ui/settings.dart';
class HomeMenuButton extends StatelessWidget {
  const HomeMenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      top: 16,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).cardColor,
        ),
        child: PopupMenuButton(
          icon: const Icon(Icons.menu),
          //splashRadius: 10.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(16.0),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Row(
                children: [
                  const Icon(Icons.settings,),
                  const SizedBox(width: 8,),
                  Text("Settings".i18n),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsView()));
              },
            ),
            const PopupMenuItem(
              enabled: false,
              height: 0,
              child: Divider(),
            ),
            PopupMenuItem(
              child: Row(
                children: [
                  const Icon(Icons.feedback_outlined),
                  const SizedBox(width: 8,),
                  Text("Feedbacks".i18n),
                ],
              ),
              onTap: () async {
                if (defaultTargetPlatform.isMobile()) {
                  final Uri url = Uri.parse(
                      'https://play.google.com/store/apps/details?id=com.zeroboy.diccon_evo');
                  if (!await launchUrl(url,
                  mode: LaunchMode.externalApplication)) {
                throw Exception('Could not launch $url');
                }
                } else {
                final Uri url = Uri.parse(
                'https://apps.microsoft.com/store/detail/diccon-evo/9NPF4HBMNG5D');
                if (!await launchUrl(url,
                mode: LaunchMode.externalApplication)) {
                throw Exception('Could not launch $url');
                }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
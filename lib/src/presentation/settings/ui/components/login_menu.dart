import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class LoginMenu extends StatelessWidget {
  const LoginMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      right: 16,
      child: PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        //splashRadius: 10.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: context.theme.dividerColor),
          borderRadius: BorderRadius.circular(16.0),
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(
                  Icons.privacy_tip_outlined,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text("Privacy Policy".i18n),
              ],
            ),
            onTap: () async {
              final Uri url = Uri.parse(
                  OnlineDirectory.privacyPolicyURL);
              if (!await launchUrl(url,
                  mode: LaunchMode.externalApplication)) {
                throw Exception('Could not launch $url');
              }
            },
          ),
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(Icons.info_outline),
                const SizedBox(
                  width: 8,
                ),
                Text("About".i18n),
              ],
            ),
            onTap: () {
              context.pushNamed('infos');
            },
          ),
        ],
      ),
    );
  }
}

import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wave_divider/wave_divider.dart';

class HomeMenuButton extends StatelessWidget {
  const HomeMenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      top: 16,
      child: SizedBox(
        height: 50,
        width: 50,
        child: Row(
          children: [
            PopupMenuButton(
              icon: Icon(Icons.menu, color: context.theme.colorScheme.primary,),
              //splashRadius: 10.0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: context.theme.dividerColor),
                borderRadius: BorderRadius.circular(16.0),
              ),
              itemBuilder: (context) => [
                //if (defaultTargetPlatform.isMobile())
                if (false)
                  PopupMenuItem(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.account_circle_outlined,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text("Account".i18n),
                      ],
                    ),
                    onTap: () {
                      context.pushNamed('user-settings');
                    },
                  ),
                if (UserInfoProperties.userInfo != UserInfo.empty())
                  PopupMenuItem(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.sync,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text("Sync".i18n),
                      ],
                    ),
                    onTap: () {
                      context
                          .read<UserBloc>()
                          .add(UserSyncEvent(userInfo: UserInfoProperties.userInfo));
                    },
                  ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.settings,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text("Settings".i18n),
                    ],
                  ),
                  onTap: () {
                    context.pushNamed('common-settings');
                  },
                ),
                const PopupMenuItem(
                  enabled: false,
                  height: 0,
                  child: WaveDivider(thickness: .3,),

                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(UniconsLine.github),
                      const SizedBox(
                        width: 8,
                      ),
                      Text("Report Errors".i18n),
                    ],
                  ),
                  onTap: () async {
                    final Uri url = Uri.parse(
                        'https://github.com/tranhuudang/diccon_evo/issues');
                    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                    throw Exception('Could not launch $url');
                    }
                  },
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(Icons.feedback_outlined),
                      const SizedBox(
                        width: 8,
                      ),
                      Text("Feedbacks".i18n),
                    ],
                  ),
                  onTap: () => SeekFeedback.goToStoreListing(),
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
          ],
        ),
      ),
    );
  }
}

import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';
class InfosView extends StatefulWidget {
  const InfosView({super.key});

  @override
  State<InfosView> createState() => _InfosViewState();
}

class _InfosViewState extends State<InfosView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.surface,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 60),
              child: Responsive(
                smallSizeDevice: body(),
                mediumSizeDevice: body(),
                largeSizeDevice: body(),
              ),
            ),

            /// Header
            Header(
              title: "About".i18n,
            ),
          ],
        ),
      ),
    );
  }

  Column body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Section(
          title: "About".i18n,
          children: [
            Column(
              children: [
                const Image(
                  image: AssetImage("assets/diccon-256.png"),
                  height: 90,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Diccon Dictionary",
                    style: context.theme.textTheme.titleLarge?.copyWith(
                        color: context.theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: OutlinedButton(
                onPressed: () {
                  context.pushNamed(RouterConstants.releaseNotes);
                },
                child: Text(
                  "v${PropertiesConstants.version}",
                  style: context.theme.textTheme.titleSmall,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  "© 2023 Zeroboy.",
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                      color: context.theme.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(width: 5),
                Text(
                  "All rights reserved.".i18n,
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                      color: context.theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ],
        ),
        Section(
          title: "Privacy Policy".i18n,
          children: [
            Text(
              "DesciptionTextForPrivacyPolicy".i18n,
              style: context.theme
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: context.theme.colorScheme.onSurface),
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              children: [
                Text(
                  "For more information about our privacy policy, please visit:"
                      .i18n,
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                      color: context.theme.colorScheme.onSurface),
                ),
                const VerticalSpacing.medium(),
                FilledButton.tonal(
                    onPressed: () async {
                      final Uri url =
                          Uri.parse(PropertiesConstants.privacyPolicyURL);
                      if (!await launchUrl(url,
                          mode: LaunchMode.externalApplication)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: Text("Privacy Policy".i18n))
              ],
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Text(
              "Available at".i18n,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: 200,
              width: 370,
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: [
                  microsoftStoreBadge(),
                  amazonStoreBadge(),
                  playStoreBadge(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

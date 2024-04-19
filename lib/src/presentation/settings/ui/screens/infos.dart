import 'package:go_router/go_router.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';

class InfoView extends StatelessWidget {
  const InfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          "About".i18n,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Section(
            title: "About".i18n,
            children: [
              Column(
                children: [
                  const Image(
                    image: AssetImage(LocalDirectory.dicconLogo256),
                    height: 90,
                  ),
                  8.height,
                  Text(
                    "Diccon Dictionary",
                    style: context.theme.textTheme.titleLarge?.copyWith(
                        color: context.theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              8.height,
              FilledButton.tonal(
                onPressed: () {
                  context.pushNamed(RouterConstants.releaseNotes);
                },
                child: Text(
                  "v${NumberConstants.appVersion}",
                  style: context.theme.textTheme.titleSmall,
                ),
              ),
              8.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () async {
                        final Uri url = Uri.parse(
                            'https://github.com/tranhuudang/diccon_evo');
                        if (!await launchUrl(url,
                            mode: LaunchMode.externalApplication)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      icon: const Icon(UniconsLine.github)),
                  IconButton(
                      onPressed: () async {
                        final Uri url =
                            Uri.parse('mailto:tranhuudang148@gmail.com');
                        if (!await launchUrl(url,
                            mode: LaunchMode.externalApplication)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      icon: const Icon(Icons.mail)),
                ],
              ),
              8.height,
              Text(
                "© 2023 Tran Huu Dang. ${"All rights reserved.".i18n}",
                style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: context.theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          Section(
            title: 'Licenses'.i18n,
            children: [
              Text(
                "DescriptionTextForLicenses".i18n,
                style: context.theme.textTheme.bodyMedium
                    ?.copyWith(color: context.theme.colorScheme.onSurface),
              ),
              8.height,
              FilledButton.tonal(
                  onPressed: () {
                    showLicensePage(context: context);
                  },
                  child: Text("Licenses".i18n)),
            ],
          ),
          Section(
            title: "Privacy Policy".i18n,
            children: [
              Text(
                "DesciptionTextForPrivacyPolicy".i18n,
                style: context.theme.textTheme.bodyMedium
                    ?.copyWith(color: context.theme.colorScheme.onSurface),
              ),
              4.height,
              Column(
                children: [
                  Text(
                    "For more information about our privacy policy, please visit:"
                        .i18n,
                    style: context.theme.textTheme.bodyMedium
                        ?.copyWith(color: context.theme.colorScheme.onSurface),
                  ),
                  8.height,
                  FilledButton.tonal(
                      onPressed: () async {
                        final Uri url =
                            Uri.parse(OnlineDirectory.privacyPolicyURL);
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
      ),
    );
  }
}
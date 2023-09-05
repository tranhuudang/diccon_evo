import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/target_platform.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DirectToRate extends StatelessWidget {
  const DirectToRate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              "We recognize that application quality is crucial for customer satisfaction. "
                  "Your feedback is greatly appreciated and drives ongoing improvements for our valued customers.".i18n,
              softWrap: true,
              maxLines: 200,
              overflow: TextOverflow.ellipsis,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: InkWell(
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
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.orange),
                  child:  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Give feedbacks".i18n),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';

import '../../../setting/ui/settings.dart';
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
              child: Text("Settings".i18n),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsView()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
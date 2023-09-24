import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/screens/settings/ui/components/store_badge.dart';
import 'package:flutter/material.dart';

class AvailableBox extends StatelessWidget {
  const AvailableBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Available at".i18n,
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox().mediumHeight(),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: [
              microsoftStoreBadge(),
              amazonStoreBadge(),
              playStoreBadge(),
            ],
          ),
        ],
      ),
    );
  }
}

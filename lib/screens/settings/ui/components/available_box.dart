import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/screens/settings/ui/components/store_badge.dart';
import 'package:flutter/material.dart';
class AvailableBox extends StatelessWidget {
  const AvailableBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

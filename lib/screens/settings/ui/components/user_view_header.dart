import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';

import '../../../commons/circle_button.dart';

class UserViewHeader extends StatelessWidget {
  const UserViewHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CircleButton(
              iconData: Icons.arrow_back,
              onTap: () {
                Navigator.pop(context);
              }),
        ),
        Text("Account".i18n,
            style: const TextStyle(fontSize: 28))
      ],
    );
  }
}

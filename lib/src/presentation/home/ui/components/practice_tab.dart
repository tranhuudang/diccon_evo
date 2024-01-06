import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wave_divider/wave_divider.dart';

import '../../../../core/core.dart';

class PracticeTab extends StatelessWidget {
  const PracticeTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Practice your vocabulary through simple tests. You'll find that sometimes the words you think you know are quickly forgotten.".i18n),
        const WaveDivider(
          padding: EdgeInsets.symmetric(
            vertical: 16,
          ),
          thickness: .3,
        ),
        FilledButton.tonal(
            onPressed: () {
              context.pushNamed(RouterConstants.essential1848);
            },
            child: Text('Flash Card 1848 Essential Words'.i18n))
      ],
    );
  }
}

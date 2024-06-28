import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wave_divider/wave_divider.dart';

import '../../../../core/core.dart';
import '../../../presentation.dart';

class PracticeTab extends StatelessWidget {
  const PracticeTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            SeekFeedback.showFeedbackBottomSheet(context);
            context.pushNamed(RouterConstants.dialogue);

          },
          child: Section(
            title: 'Dialogue Duo: English-Vietnamese Edition'.i18n,
            children: [
              Text(
                  'Provides a list of dual-language English and Vietnamese dialogues on various topics. Feel free to explore and use them for your language practice.'
                      .i18n),
            ],
          ),
        ),
        GestureDetector(
          onTap: (){
            context.pushNamed(RouterConstants.essential1848);

          },
          child: Section(
            title: "${'1848 Essential Words'.i18n} (BETA)",
            children: [
              Text(
                  "Practice your vocabulary through simple tests. You'll find that sometimes the words you think you know are quickly forgotten."
                      .i18n),
            ],
          ),
        ),

      ],
    );
  }
}

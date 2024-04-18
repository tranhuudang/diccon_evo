import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unicons/unicons.dart';
import 'package:wave_divider/wave_divider.dart';

class StoriesTab extends StatelessWidget {
  const StoriesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            'Learning English through stories is a proven method that is particularly effective in enhancing vocabulary and sentence structure.'
                .i18n),
        8.height,
        Text(
            'Here, you can discover a myriad of captivating stories tailored to various proficiency levels. Depending on your abilities, feel free to select stories that align with your learning objectives while providing entertainment.'
                .i18n),
        const WaveDivider(
          padding: EdgeInsets.symmetric(
            vertical: 16,
          ),
          thickness: .3,
        ),
        Text(
          "Don't forget to tap on the words for translations of the passage"
              .i18n,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.amber,
              ),
        ),
        16.height,
        Center(
            child: FilledButton.tonalIcon(
          onPressed: () {
            context.pushNamed(RouterConstants.readingChamber);
          },
          label: Text('Reading Chamber'.i18n),
          icon: const Icon(UniconsLine.book_open),
        )),
      ],
    );
  }
}

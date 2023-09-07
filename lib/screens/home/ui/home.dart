import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/screens/components/quote_box/ui/quote_box.dart';
import '../../../config/properties.dart';
import '../../article/ui/article_list.dart';
import '../../components/head_sentence.dart';
import 'package:flutter/material.dart';
import 'components/home_menu_button.dart';
import 'components/list_home_item.dart';
import 'package:unicons/unicons.dart';

import 'components/plan_button.dart';
import 'components/to_dictionary_button.dart';
import 'components/to_essential_word_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxHeight < Properties.overflowHeight) {
            // Handle overflow error here
            return const SingleChildScrollView(
              child: HomeMain(),
            );
          } else {
            // Render your content normally
            return const HomeMain(spacerEnable: true,);
          }
        },
      ),
    );
  }
}

class HomeMain extends StatelessWidget {
  final bool? spacerEnable;
  const HomeMain({
    super.key,
    this.spacerEnable,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Plan Button
        const PlanButton(),
        /// Menu button
        const HomeMenuButton(),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Head welcome to essential tab
                  HeadSentence(listText: [
                    "Empower".i18n,
                    "Your English".i18n,
                    "Proficiency".i18n
                  ]),

                  const SizedBox(
                    height: 20,
                  ),
                  /// Two big brother button
                  const Row(
                    children: [
                      ToDictionaryButton(),
                      SizedBox(
                        width: 8,
                      ),
                      ToEssentialWordButton(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  /// Other functions
                  ListHomeItem(
                    height: 150,
                    title: "Reading Chamber".i18n,
                    icon: const Icon(UniconsLine.books),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ArticleListView(),
                          ));
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            /// On SingleChildListView, Spacer() cause Overflow error,
            /// so when changing parent to SingleChildListView, we remove Spacer()
            spacerEnable != null
                ? spacerEnable!
                    ? const Spacer()
                    : const SizedBox.shrink()
                : const SizedBox.shrink(),
            /// From the universe
            Container(
              color: Theme.of(context).highlightColor,
              child: const QuoteBox(),
            ),
          ],
        ),
      ],
    );
  }
}


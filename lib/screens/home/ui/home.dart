import 'package:diccon_evo/screens/home/ui/components/to_conversational_phrases.dart';
import '../../../config/properties.dart';
import '../../commons/head_sentence.dart';
import '../../commons/quote_box/ui/quote_box.dart';
import 'package:flutter/material.dart';
import 'components/home_menu_button.dart';
import 'components/list_subfunction_box.dart';
import 'components/plan_button.dart';
import 'components/to_dictionary_button.dart';
import 'components/to_essential_3000.dart';
import 'components/to_reading_chamber.dart';

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
            return const HomeMain(
              spacerEnable: true,
            );
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
    List<Widget> listPrimaryFunction = const [
      ToDictionaryButton(),
      ToReadingChamberButton(),
    ];
    List<Widget> listSubFunction = const [
      ToEssentialWordButton(),
      ToConversationalPhrasesButton(),
    ];
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
                  const HeadSentence(
                      listText: ["Empower", "Your English", "Proficiency"]),
                  const SizedBox(
                    height: 50,
                  ),

                  /// Two big brother button
                  GridView.builder(
                      shrinkWrap: true,
                      itemCount: listPrimaryFunction.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 180,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return listPrimaryFunction[index];
                      }),
                  const SizedBox(height: 16),

                  /// Other functions
                  SubFunctionBox(
                      height: 180,
                      listSubFunction: listSubFunction),
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

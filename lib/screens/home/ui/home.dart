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
  const HomeView({
    super.key,
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
      ToConversationalPhrasesButton(),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            /// Plan Button
            const PlanButton(),

            /// Menu button
            const HomeMenuButton(),
            /// Body
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
                                  crossAxisCount: 2,
                              ),
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

                /// From the universe
                Container(
                  color: Theme.of(context).highlightColor,
                  child: const QuoteBox(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

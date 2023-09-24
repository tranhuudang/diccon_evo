import '../../../config/properties.dart';
import '../../../data/repositories/dictionary_repository.dart';
import '../../../data/repositories/thesaurus_repository.dart';
import '../../commons/head_sentence.dart';
import '../../commons/quote_box/ui/quote_box.dart';
import 'package:flutter/material.dart';
import '../../settings/ui/components/available_box.dart';
import 'components/home_menu_button.dart';
import 'components/list_subfunction_box.dart';
import 'components/plan_button.dart';
import 'components/to_dictionary_button.dart';
import 'components/to_essential_3000.dart';
import 'components/to_reading_chamber.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:window_manager/window_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WindowListener {
  // Instance of Repository implementations
  DictionaryRepository dataRepository = DictionaryRepository();
  ThesaurusRepository thesaurusRepository = ThesaurusRepository();
  List<Widget> listPrimaryFunction = const [
    ToDictionaryButton(),
    ToReadingChamberButton(),
  ];
  List<Widget> listSubFunction = const [
    ToEssentialWordButton(),
    //ToConversationalPhrasesButton(),
    AvailableBox(),
  ];

  @override
  void initState() {
    super.initState();
    WindowManager.instance.addListener(this);
    // Other loading steps
    loadUpData();
  }

  /// Detect when windows is changing size
  @override
  void onWindowResize() async {
    Size windowsSize = await WindowManager.instance.getSize();

    /// Save windows size to setting
    Properties.defaultSetting = Properties.defaultSetting.copyWith(
        windowsWidth: windowsSize.width, windowsHeight: windowsSize.height);
    Properties.saveSettings(Properties.defaultSetting);
  }

  loadUpData() async {
    /// Because getWordList for Dictionary take time to complete, so it'll be put behind pages[] to have a better feel of speed.
    Properties.wordList = await DictionaryRepository().getWordList();
    // Load up thesaurus dictionary
    ThesaurusRepository().loadThesaurus();
    // Load up suggestion list word
    Properties.suggestionListWord =
        await DictionaryRepository().getSuggestionWordList();
  }

  DateTime backPressedTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(backPressedTime);
        if (difference >= const Duration(seconds: 2)) {
          Fluttertoast.showToast(
              msg: 'Press back again to exit'.i18n, fontSize: 14);
          backPressedTime = DateTime.now();
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
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
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Head welcome to essential tab
                          const HeadSentence(listText: [
                            "Empower",
                            "Your English",
                            "Proficiency"
                          ]),
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
                              height: 180, listSubFunction: listSubFunction),
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
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/screens/home/ui/components/plan_button.dart';
import 'package:diccon_evo/screens/home/ui/components/to_dictionary_button.dart';
import 'package:flutter/foundation.dart';
import '../../../config/properties.dart';
import '../../../data/repositories/dictionary_repository.dart';
import '../../../data/repositories/thesaurus_repository.dart';
import '../../commons/head_sentence.dart';
import 'package:flutter/material.dart';
import 'components/dictionary_search_box.dart';
import 'components/home_menu_button.dart';
import 'components/list_subfunction_box.dart';
import 'components/to_conversation_button.dart';
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
  final List<Widget> _listPrimaryFunction = const [
    ToDictionaryButton(),
    ToConversationButton(),
  ];
  final List<Widget> _listSubFunction = const [
    ToReadingChamberButton(),
    ToEssentialWordButton(),
  ];

  DateTime _backPressedTime = DateTime.now();

  _loadUpData() async {
    /// Inscease count number to count the how many time user open app
    Properties.saveSettings(Properties.defaultSetting
        .copyWith(openAppCount: Properties.defaultSetting.openAppCount + 1));
    if (kDebugMode) {
      print(" Current Properties.defaultSetting.openAppCount value: ${Properties
          .defaultSetting.openAppCount.toString()}");
    }

    /// Because getWordList for Dictionary take time to complete, so it'll be put behind pages[] to have a better feel of speed.
    Properties.wordList = await DictionaryRepository().getWordList();
    // Load up thesaurus dictionary
    ThesaurusRepository().loadThesaurus();
    // Load up suggestion list word
    Properties.suggestionListWord =
    await DictionaryRepository().getSuggestionWordList();
  }

  /// Detect when windows is changing size
  @override
  void onWindowResize() async {
    Size windowsSize = await WindowManager.instance.getSize();
    // Save windows size to setting
    Properties.defaultSetting = Properties.defaultSetting.copyWith(
        windowsWidth: windowsSize.width, windowsHeight: windowsSize.height);
    Properties.saveSettings(Properties.defaultSetting);
  }

  @override
  void initState() {
    super.initState();
    WindowManager.instance.addListener(this);
    // Other loading steps
    _loadUpData();
    if (kDebugMode) {
      print("Data is loaded");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(_backPressedTime);
        if (difference >= const Duration(seconds: 2)) {
          Fluttertoast.showToast(
              msg: 'Press back again to exit'.i18n, fontSize: 14);
          _backPressedTime = DateTime.now();
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .surface,
          body: SingleChildScrollView(
            child: Stack(
              children: [

                /// Search dictionary box

                /// Menu button
                const HomeMenuButton(),

                /// Body
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Head welcome to essential tab
                    const HeadSentence(
                        listText: ["Empower", "Your English", "Proficiency"]),
                    const SizedBox().mediumHeight(),
                    const PlanButton(),
                    const SizedBox().largeHeight(),

                    /// TextField for user to enter their words
                    const DictionarySearchBoxInHome(),
                    const SizedBox().largeHeight(),

                    /// Two big brother button
                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _listPrimaryFunction.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 180,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return _listPrimaryFunction[index];
                        }),
                    const SizedBox(height: 8),

                    /// Other functions
                    SubFunctionBox(
                        height: 180, listSubFunction: _listSubFunction),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
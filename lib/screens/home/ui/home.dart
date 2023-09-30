import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/screens/dictionary/ui/dictionary.dart';
import 'package:flutter/foundation.dart';
import '../../../config/properties.dart';
import '../../../data/repositories/dictionary_repository.dart';
import '../../../data/repositories/thesaurus_repository.dart';
import '../../commons/head_sentence.dart';
import 'package:flutter/material.dart';
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
  // Instance of Repository implementations
  final dataRepository = DictionaryRepository();
  final thesaurusRepository = ThesaurusRepository();
  final _searchTextController = TextEditingController();
  bool _enableTinyCloseButton = false;
  List<Widget> listPrimaryFunction = const [
    ToDictionaryButton(),
    ToReadingChamberButton(),
  ];
  List<Widget> listSubFunction = const [
    ToEssentialWordButton(),
    //ToConversationalPhrasesButton(),
  ];

  @override
  void initState() {
    super.initState();
    WindowManager.instance.addListener(this);
    // Other loading steps
    loadUpData();
    if (kDebugMode) {
      print("Data is loaded");
    }
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
                /// Search dictionary box

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
                            height: 20,
                          ),

                          /// TextField for user to enter their words
                          Container(
                            padding: const EdgeInsets.only(top: 2, bottom: 26),
                            //margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Stack(
                                    children: [
                                      TextField(
                                        controller: _searchTextController,
                                        onTap: () {
                                          setState(() {
                                            _enableTinyCloseButton = true;
                                          });
                                        },
                                        onSubmitted: (String value) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DictionaryView(
                                                          word: value,
                                                          buildContext:
                                                              context)));
                                        },
                                        //focusNode: Properties.textFieldFocusNode,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.search),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16),
                                          hintText: "Search in dictionary".i18n,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                          ),
                                        ),
                                      ),
                                      _enableTinyCloseButton
                                          ? SizedBox(
                                              height: 48,
                                              //color: Colors.black54,
                                              child: Row(
                                                children: [
                                                  const Spacer(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: Center(child:
                                                        TinyCloseButton(
                                                            onTap: () {
                                                      _searchTextController
                                                          .clear();
                                                      // Dismiss keyboard
                                                      FocusScopeNode
                                                          currentFocus =
                                                          FocusScope.of(
                                                              context);

                                                      if (!currentFocus
                                                          .hasPrimaryFocus) {
                                                        currentFocus.unfocus();
                                                      }
                                                      // Erase tiny button
                                                      setState(() {
                                                        _enableTinyCloseButton =
                                                            false;
                                                      });
                                                    })),
                                                  )
                                                ],
                                              ),
                                            )
                                          : const SizedBox.shrink()
                                    ],
                                  ),
                                ),
                                const SizedBox().mediumWidth(),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DictionaryView()));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(
                                          32,
                                        )),
                                    child: const Icon(
                                      Icons.auto_awesome,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                    // Container(
                    //   color: Theme.of(context).highlightColor,
                    //   child: const QuoteBox(),
                    // ),
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

class TinyCloseButton extends StatelessWidget {
  final VoidCallback onTap;
  const TinyCloseButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(32),
          ),
          child: const Icon(Icons.close)),
    );
  }
}

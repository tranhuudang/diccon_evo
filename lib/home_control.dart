import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/repositories/dictionary_repository.dart';
import 'package:diccon_evo/repositories/thesaurus_repository.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'config/properties.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'screens/home/ui/home.dart';

class HomeControlView extends StatefulWidget {
  const HomeControlView({Key? key}) : super(key: key);

  @override
  State<HomeControlView> createState() => _HomeControlViewState();
}

class _HomeControlViewState extends State<HomeControlView> with WindowListener {
  // Instance of Repository implementations
  DictionaryRepository dataRepository = DictionaryRepository();
  ThesaurusRepository thesaurusRepository = ThesaurusRepository();

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
      child: const SafeArea(
        child: Scaffold(
          body: HomeView(),
        ),
      ),
    );
  }
}

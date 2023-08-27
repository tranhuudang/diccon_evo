import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/repositories/dictionary_repository.dart';
import 'package:diccon_evo/extensions/target_platform.dart';
import 'package:diccon_evo/repositories/thesaurus_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import '../../components/navigation_item.dart';
import '../../components/side_navigation_bar.dart';
import '../../../config/properties.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WindowListener {
  int _selectedPageIndex = 0;
  bool isExpanded = false;
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
    Properties.defaultWindowWidth = windowsSize.width;
    Properties.defaultWindowHeight = windowsSize.height;
    Properties.saveSettings(null, null);
    if (windowsSize.width > 800) {
      setState(() {
        isExpanded = true;
        Properties.isLargeWindows = true;
      });
    } else {
      setState(() {
        isExpanded = false;
        Properties.isLargeWindows = false;
      });
    }
  }

  loadUpData() async {
    /// Because getWordList for Dictionary take time to complete, so it'll be put behind pages[] to have a better feel of speed.
    Properties.wordList = await DictionaryRepository().getWordList();

    // Load up thesaurus dictionary
    ThesaurusRepository().loadThesaurus();

    // Load up suggestion list word
    Properties.suggestionListWord = await DictionaryRepository().getSuggestionWordList();
  }

  /// Helper method to update the selected page and collapse the navigation
  void _jumpToSelectedPage(int index, bool? popContext) {
    _selectedPageIndex = index;
    Properties.pageController.jumpToPage(_selectedPageIndex);
    if (popContext ?? false) Navigator.pop(context);
  }

  /// Need this globalKey to open drawer by custom button
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime backPressedTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Properties.isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
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
          key: _scaffoldKey,
          body: Stack(
            children: [
              Row(
                children: <Widget>[
                  /// Create a blank space for SideNavigationBar in desktop platform to live in

                  SizedBox(
                    width: isExpanded && Properties.isLargeWindows
                        ? 250
                        : defaultTargetPlatform.isMobile()
                            ? 0
                            : 50,
                  ),

                  /// PageView where different pages live on
                  /// Desktop platform
                  Expanded(
                    child: PageView(
                      controller: Properties.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: Properties.pages,
                    ),
                  ),
                ],
              ),

              /// Side navigation bar for desktop devices
              defaultTargetPlatform.isMobile()
                  ? Container()
                  : SideNavigationBar(
                      isExpanded: isExpanded,
                      navigationItem: [
                        NavigationItem(
                          title: "", //Menu
                          isExpanded: isExpanded,
                          icon: Icons.menu,
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                        ),
                        const Divider(),
                        NavigationItem(
                          title: "Dictionary".i18n,
                          isExpanded: isExpanded,
                          icon: Icons.search,
                          onPressed: () {
                            _jumpToSelectedPage(
                                AppViews.dictionaryView.index, false);
                          },
                        ),
                        const Spacer(),
                        const Divider(),
                        NavigationItem(
                          title: "Settings".i18n,
                          isExpanded: isExpanded,
                          icon: Icons.manage_accounts_outlined,
                          onPressed: () {
                            // Remove focus out of TextField in DictionaryView
                            Properties.textFieldFocusNode.unfocus();
                            _jumpToSelectedPage(
                                AppViews.settingsView.index, false);
                          },
                        ),
                      ],
                    ),
            ],
          ),
          bottomNavigationBar: defaultTargetPlatform.isMobile()
              ? NavigationBar(
                  selectedIndex: _selectedPageIndex,
                  onDestinationSelected: (index) {
                    if (mounted) {
                      setState(() {
                        switch (index) {
                          case 0:
                            _jumpToSelectedPage(
                                AppViews.dictionaryView.index, false);
                            break;
                          case 1:
                            _jumpToSelectedPage(
                                AppViews.settingsView.index, false);
                            break;
                        }
                        _selectedPageIndex = index;
                      });
                    }
                  },
                  destinations: [
                    NavigationDestination(
                      icon: const Icon(Icons.search),
                      label: "Dictionary".i18n,
                      selectedIcon: Icon(Icons.search,
                          color: Properties.isDarkMode
                              ? Colors.black
                              : Colors.white),
                    ),
                    NavigationDestination(
                        selectedIcon: Icon(Icons.manage_accounts_outlined,
                            color: Properties.isDarkMode
                                ? Colors.black
                                : Colors.white),
                        icon: const Icon(Icons.manage_accounts_outlined),
                        label: "Settings".i18n),
                  ],
                )
              : null,
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:diccon_evo/repositories/data_repository.dart';
import 'package:diccon_evo/services/data_service.dart';
import 'package:diccon_evo/helpers/file_handler.dart';
import 'package:diccon_evo/helpers/platform_check.dart';
import 'package:diccon_evo/repositories/thesaurus_repository.dart';
import 'package:diccon_evo/services/thesaurus_service.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'views/components/navigation_item.dart';
import 'views/components/side_navigation_bar.dart';
import 'properties.dart';
import 'models/word.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unicons/unicons.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WindowListener {
  int _selectedPageIndex = 0;
  bool isExpanded = false;
  int selectedPageIndex = 0;
  // Instance of Repository implementations
  DataRepository dataRepository = DataRepository();
  ThesaurusRepository thesaurusRepository = ThesaurusRepository();

  Future<List<Word>> readHistory() async {
    return await FileHandler.readWordHistory();
  }

  @override
  void initState() {
    super.initState();
    WindowManager.instance.addListener(this);
    // Inject Repository implementations to Services
    Properties.dataService = DataService(dataRepository);
    Properties.thesaurusService = ThesaurusService(thesaurusRepository);
    // Other loading steps
    loadUpData();
  }

  /// Detect when windows is changing size
  @override
  void onWindowResize() async {
    Size windowsSize = await WindowManager.instance.getSize();
    Properties.defaultWindowWidth = windowsSize.width;
    Properties.defaultWindowHeight = windowsSize.height;
    Properties.saveSettings(null, null, null, null);
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
    //Global.packageInfo = await PackageInfo.fromPlatform();
    /// Because getWordList for Dictionary take time to complete, so it'll be put behind pages[] to have a better feel of speed.
    Properties.wordList = await Properties.dataService.getWordList();

    // Load up thesaurus dictionary
    Properties.thesaurusService.loadThesaurus();

    /// Load windows setting for custom title bar
    // if (Platform.isWindows) {
    //   doWhenWindowReady(() {
    //     final win = appWindow;
    //     const initialSize = Size(Global.MIN_WIDTH, Global.MIN_HEIGHT);
    //     win.minSize = initialSize;
    //     appWindow.show();
    //   });
    // }
  }

  /// Helper method to update the selected page and collapse the navigation
  void _jumpToSelectedPage(int index, bool? popContext) {
    // setState(() {
    //   isExpanded = false;
    // });
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
          Fluttertoast.showToast(msg: 'Press back again to exit', fontSize: 14);
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
                        : PlatformCheck.isMobile()
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
              PlatformCheck.isMobile()
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
                          title: "Dictionary",
                          isExpanded: isExpanded,
                          icon: Icons.search,
                          onPressed: () {
                            _jumpToSelectedPage(
                                AppViews.dictionaryView.index, false);
                          },
                        ),
                        const Divider(),
                        NavigationItem(
                          title: "Videos",
                          isExpanded: isExpanded,
                          icon: Icons.video_library_outlined,
                          onPressed: () {
                            _jumpToSelectedPage(
                                AppViews.videoListView.index, false);
                          },
                        ),
                        const Divider(),
                        NavigationItem(
                          title: "Reading",
                          isExpanded: isExpanded,
                          icon: UniconsLine.books,
                          onPressed: () {
                            // Remove focus out of TextField in DictionaryView
                            Properties.textFieldFocusNode.unfocus();
                            _jumpToSelectedPage(
                                AppViews.articleListView.index, false);
                          },
                        ),
                        const Spacer(),
                        const Divider(),
                        NavigationItem(
                          title: "Settings",
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
          bottomNavigationBar: PlatformCheck.isMobile()
              ? NavigationBar(
                  selectedIndex: selectedPageIndex,
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
                                AppViews.videoListView.index, false);
                            break;
                          case 2:
                            _jumpToSelectedPage(
                                AppViews.articleListView.index, false);
                            break;

                          case 3:
                            _jumpToSelectedPage(
                                AppViews.settingsView.index, false);
                            break;
                        }
                        selectedPageIndex = index;
                      });
                    }
                  },
                  destinations: [
                    NavigationDestination(
                      icon: const Icon(Icons.search),
                      label: "Dictionary",
                      selectedIcon: Icon(Icons.search,
                          color:
                              Properties.isDarkMode ? Colors.black : Colors.white),
                    ),
                    NavigationDestination(
                        icon: const Icon(
                          Icons.play_circle_outline,
                        ),
                        selectedIcon: Icon(Icons.play_circle_outline,
                            color: Properties.isDarkMode
                                ? Colors.black
                                : Colors.white),
                        label: "Videos"),
                    NavigationDestination(
                        icon: const Icon(Icons.chrome_reader_mode_outlined),
                        selectedIcon: Icon(Icons.chrome_reader_mode_outlined,
                            color: Properties.isDarkMode
                                ? Colors.black
                                : Colors.white),
                        label: "Reading Time"),
                    NavigationDestination(
                        selectedIcon: Icon(Icons.manage_accounts_outlined,
                            color: Properties.isDarkMode
                                ? Colors.black
                                : Colors.white),
                        icon: const Icon(Icons.manage_accounts_outlined),
                        label: "Settings"),
                  ],
                )
              : null,
        ),
      ),
    );
  }
}

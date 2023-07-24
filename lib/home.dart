import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
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
import 'global.dart';
import 'models/word.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WindowListener {
  int _selectedPageIndex = 0;
  bool isExpanded = false;
  bool isLarge = false;
  int selectedPageIndex = 0;
  // Instance of Repository implementations
  DataRepository dataRepository = DataRepository();
  ThesaurusRepository thesaurusRepository = ThesaurusRepository();

  Future<List<Word>> readHistory() async {
    return await FileHandler.readHistory();
  }

  @override
  void initState() {
    super.initState();
    WindowManager.instance.addListener(this);
    // Inject Repository implementations to Services
    Global.dataService = DataService(dataRepository);
    Global.thesaurusService = ThesaurusService(thesaurusRepository);
    // Other loading steps
    loadUpData();

    Global.getSettings();
  }

  /// Detect when windows is changing size
  @override
  void onWindowResize() async {
    Size windowsSize = await WindowManager.instance.getSize();
    if (windowsSize.width > 800) {
      setState(() {
        isExpanded = true;
        isLarge = true;
      });
    } else {
      setState(() {
        isExpanded = false;
        isLarge = false;
      });
    }
  }

  loadUpData() async {
    //Global.packageInfo = await PackageInfo.fromPlatform();
    /// Because getWordList for Dictionary take time to complete, so it'll be put behind pages[] to have a better feel of speed.
    Global.wordList = await Global.dataService.getWordList();

    // Load up thesaurus dictionary
    Global.thesaurusService.loadThesaurus();

    /// Load windows setting for custom title bar
    if (Platform.isWindows) {
      doWhenWindowReady(() {
        final win = appWindow;
        const initialSize = Size(400, 514);
        win.minSize = initialSize;
        appWindow.show();
      });
    }
  }

  /// Helper method to update the selected page and collapse the navigation
  void _jumpToSelectedPage(int index, bool? popContext) {
    setState(() {
      isExpanded = false;
    });
    _selectedPageIndex = index;
    Global.pageController.jumpToPage(_selectedPageIndex);
    if (popContext ?? false) Navigator.pop(context);
  }

  /// Need this globalKey to open drawer by custom button
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime backPressedTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
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
          appBar: PlatformCheck.isMobile()
              ? null
              : PreferredSize(
                  preferredSize: const Size.fromHeight(50.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white, // Windows 11 title bar color
                      border: Border(
                        bottom: BorderSide(color: Colors.black12, width: 0.7),
                      ),
                    ),
                    child: MoveWindow(
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            'assets/dictionary/icon.ico',
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text(
                            "Diccon Evo",
                            style: TextStyle(color: Colors.black),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.topRight,
                            child: Row(
                              children: [
                                MinimizeWindowButton(
                                  colors: Global.buttonColors,
                                ),
                                MaximizeWindowButton(
                                  colors: Global.buttonColors,
                                ),
                                CloseWindowButton(
                                  colors: Global.closeButtonColors,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          key: _scaffoldKey,
          body: Stack(
            children: [
              Row(
                children: <Widget>[
                  /// Create a blank space for SideNavigationBar in desktop platform to live in

                  SizedBox(
                    width: isExpanded && isLarge
                        ? 250
                        : PlatformCheck.isMobile()
                            ? 0
                            : 50,
                  ),

                  /// PageView where different pages live on
                  /// Desktop platform
                  Expanded(
                    child: PageView(
                      controller: Global.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: Global.pages,
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
                          title: "Reading",
                          isExpanded: isExpanded,
                          icon: Icons.chrome_reader_mode_outlined,
                          onPressed: () {
                            // Remove focus out of TextField in DictionaryView
                            Global.textFieldFocusNode.unfocus();
                            _jumpToSelectedPage(
                                AppViews.articleListView.index, false);
                          },
                        ),
                        // Divider(),
                        // NavigationItem(
                        //   title: "Writing",
                        //   isExpanded: isExpanded,
                        //   icon: Icons.draw_outlined,
                        //   onPressed: () {
                        //     _jumpToSelectedPage(AppViews.writingView.index, false);
                        //   },
                        // ),
                        const Spacer(),

                        const Divider(),
                        NavigationItem(
                          title: "Settings",
                          isExpanded: isExpanded,
                          icon: Icons.manage_accounts_outlined,
                          onPressed: () {
                            // Remove focus out of TextField in DictionaryView
                            Global.textFieldFocusNode.unfocus();
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
                                AppViews.articleListView.index, false);
                            break;
                          // case 2:
                          //   _jumpToSelectedPage(AppViews.writingView.index, false);
                          //   break;
                          case 2:
                            _jumpToSelectedPage(
                                AppViews.settingsView.index, false);
                            break;
                        }
                        selectedPageIndex = index;
                      });
                    }
                  },
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                  destinations: const [
                    NavigationDestination(
                        icon: Icon(Icons.search), label: "Dictionary"),
                    NavigationDestination(
                        icon: Icon(Icons.chrome_reader_mode_outlined),
                        label: "Reading Time"),
                    // NavigationDestination(
                    //     icon: Icon(Icons.draw_outlined,), label: "Writing"),
                    NavigationDestination(
                        icon: Icon(Icons.manage_accounts_outlined), label: "Settings"),
                  ],
                )
              : null,
        ),
      ),
    );
  }
}

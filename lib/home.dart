import 'dart:io';

import 'package:diccon_evo/viewModels/data_manager.dart';
import 'package:diccon_evo/viewModels/file_handler.dart';
import 'package:diccon_evo/viewModels/platform_check.dart';
import 'package:diccon_evo/viewModels/synonyms_dictionary.dart';
import 'package:diccon_evo/viewModels/synonyms_dictionary.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'components/navigation_item.dart';
import 'components/side_navigation_bar.dart';
import 'global.dart';
import 'models/word.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WindowListener {
  int _selectedPageIndex = 0;
  bool isExpanded = false;
  bool isLarge = false;
  SynonymsDictionary synonymsDictionary = SynonymsDictionary();
  Future<List<Word>> readHistory() async {
    return await FileHandler.readHistory();
  }

  @override
  void initState() {
    super.initState();
    loadUpData();
    synonymsDictionary.loadSynonymsData();
    Global.getSettings();
    WindowManager.instance.addListener(this);
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
    /// Because getWordList for Dictionary take time to complete, so it'll be put behind pages[] to have a better feel of speed.
    Global.wordList = await getWordList();
    Global.defaultArticleList = await FileHandler.readDefaultStories();
    Global.defaultArticleList.shuffle();
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

  final buttonColors = WindowButtonColors(
      iconNormal: Colors.black,
      mouseOver: Colors.grey.shade100,
      mouseDown: Colors.grey.shade200,
      iconMouseOver: Colors.black,
      iconMouseDown: Colors.black);

  final closeButtonColors = WindowButtonColors(
      mouseOver: const Color(0xFFD32F2F),
      mouseDown: const Color(0xFFB71C1C),
      iconNormal: Colors.black,
      iconMouseOver: Colors.white);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: !Platform.isWindows ? null:  PreferredSize(
          preferredSize: Size.fromHeight(50.0),
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
                  SizedBox(
                    width: 16,
                  ),
                  Image.asset(
                    'assets/dictionary/icon.ico',
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Diccon Evo",
                    style: TextStyle(
                        color: Colors.black),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        MinimizeWindowButton(colors: buttonColors,),
                        MaximizeWindowButton(colors: buttonColors,),
                        CloseWindowButton(colors: closeButtonColors,),
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
                  width: isExpanded && isLarge ? 250 : 50,
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
            SideNavigationBar(
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
                Divider(),
                NavigationItem(
                  title: "Dictionary",
                  isExpanded: isExpanded,
                  icon: Icons.search,
                  onPressed: () {
                    _jumpToSelectedPage(AppViews.dictionaryView.index, false);
                  },
                ),
                const Divider(),
                NavigationItem(
                  title: "Reading",
                  isExpanded: isExpanded,
                  icon: Icons.chrome_reader_mode_outlined,
                  onPressed: () {
                    _jumpToSelectedPage(AppViews.articleListView.index, false);
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
                  icon: Icons.settings,
                  onPressed: () {
                    _jumpToSelectedPage(AppViews.settingsView.index, false);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

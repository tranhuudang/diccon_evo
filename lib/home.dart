import 'dart:io';

import 'package:diccon_evo/viewModels/data_manager.dart';
import 'package:diccon_evo/viewModels/file_handler.dart';
import 'package:diccon_evo/views/community.dart';
import 'package:diccon_evo/views/dictionary.dart';
import 'package:diccon_evo/views/history.dart';
import 'package:diccon_evo/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

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
  List<Widget> pages = [];
  PageController pageController = PageController();
  bool isExpanded = false;
  bool isLarge = false;
  Future<List<Word>> readHistory() async {
    return await FileHandler.readHistory();
  }

  @override
  void initState() {
    super.initState();
    loadUpData();
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
    pages = [
       DictionaryView(),
      HistoryView(),
      CommunityView(),
      SettingsView(),
    ];

    /// Because getWordList take time to complete, so it'll be put behind pages[] to have a better feel of speed.
    Global.wordList = await getWordList();


  }

  /// Helper method to update the selected page and collapse the navigation
  void _jumpToSelectedPage(int index, bool? popContext) {
    setState(() {
      isExpanded = false;
    });
    _selectedPageIndex = index;
    pageController.jumpToPage(_selectedPageIndex);
    if (popContext ?? false) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Platform.isWindows
          ? null
          : AppBar(
              title: const Text(Global.DICCON),
            ),
      drawer: Platform.isAndroid || Platform.isIOS

          /// Drawer for mobile platform navigation
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      Global.DICCON_DICTIONARY,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  ListTile(
                    title: const Text(Global.DICTIONARY),
                    onTap: () {
                      _jumpToSelectedPage(0, true);
                    },
                  ),
                  ListTile(
                    title: const Text(Global.HISTORY),
                    onTap: () {
                      _jumpToSelectedPage(1, true);
                    },
                  ),
                  ListTile(
                    title: const Text(Global.COMMUNITY),
                    onTap: () {
                      _jumpToSelectedPage(2, true);
                    },
                  ),
                ],
              ),
            )
          : null,
      body: Platform.isWindows || Platform.isMacOS || Platform.isLinux
          ? Stack(
              children: [
                Row(
                  children: <Widget>[
                    /// Create a blank space for SideNavigationBar in desktop platform to live in
                    SizedBox(
                      width: isExpanded && isLarge ? 250 : 58,
                    ),

                    /// PageView where different pages live on
                    /// Desktop platform
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: pages,
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
                    NavigationItem(
                      title: "Search",
                      isExpanded: isExpanded,
                      icon: Icons.search,
                      onPressed: () {
                        _jumpToSelectedPage(0, false);
                      },
                    ),
                    Divider(),
                    NavigationItem(
                      title: "History",
                      isExpanded: isExpanded,
                      icon: Icons.history,
                      onPressed: () {
                        _jumpToSelectedPage(1, false);
                      },
                    ),
                    Divider(),
                    NavigationItem(
                      title: "Community",
                      isExpanded: isExpanded,
                      icon: Icons.chat_bubble_outline,
                      onPressed: () {
                        _jumpToSelectedPage(2, false);
                      },
                    ),
                    const Spacer(),
                    Divider(),
                    NavigationItem(
                      title: "Settings",
                      isExpanded: isExpanded,
                      icon: Icons.settings,
                      onPressed: () {
                        _jumpToSelectedPage(3, false);
                      },
                    ),
                  ],
                ),
              ],
            )

          /// PageView where different pages live on
          /// Mobile platform
          : Row(
              children: [
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: pages,
                  ),
                ),
              ],
            ),
    );
  }
}

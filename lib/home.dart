import 'dart:io';

import 'package:diccon_evo/viewModels/data_manager.dart';
import 'package:diccon_evo/viewModels/file_handler.dart';
import 'package:diccon_evo/views/community.dart';
import 'package:diccon_evo/views/dictionary.dart';
import 'package:diccon_evo/views/history.dart';
import 'package:flutter/material.dart';

import 'components/navigation_item.dart';
import 'global.dart';
import 'models/word.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedPageIndex = 0;
  List<Widget> pages = [];
  PageController pageController = PageController();
  bool isExpanded = false;
  Future<List<Word>> readHistory() async {
    return await FileHandler.readHistory();
  }

  @override
  void initState() {
    super.initState();
    loadUpData();
  }

  loadUpData() async {
    pages = [
      const DictionaryView(),
    ];

    /// Because getWordList take time to complete, so it'll be put behind pages[] to have a better feel of speed.
    Global.wordList = await getWordList();
    setState(() {
      readHistory().then((words) {
        pages.add(
          HistoryView(
            words: words,
          ),
        );
        pages.add(const CommunityView());
      });
    });
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
                      setState(() {
                        _selectedPageIndex = 0;
                        pageController.jumpToPage(_selectedPageIndex);
                        Navigator.pop(context);
                      });
                    },
                  ),
                  ListTile(
                    title: const Text(Global.HISTORY),
                    onTap: () {
                      setState(() {
                        _selectedPageIndex = 1;
                        pageController.jumpToPage(_selectedPageIndex);
                        Navigator.pop(context);
                      });
                    },
                  ),
                  ListTile(
                    title: const Text(Global.COMMUNITY),
                    onTap: () {
                      setState(() {
                        _selectedPageIndex = 2;
                        pageController.jumpToPage(_selectedPageIndex);
                        Navigator.pop(context);
                      });
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
                    SizedBox(
                      width: 58,
                    ),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: pages,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 8),
                  width: isExpanded ? 250 : 58,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: isExpanded ? Colors.black38 : Colors.black12,
                        blurRadius: isExpanded ? 250 : 5,
                      )
                    ],
                    border: Border(
                      right: BorderSide(
                          color: isExpanded ? Colors.black26 : Colors.black12),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NavigationItem(
                        title: "Menu",
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
                          setState(() {
                            _selectedPageIndex = 0;
                            pageController.jumpToPage(_selectedPageIndex);
                            isExpanded = false;
                          });
                        },
                      ),
                      NavigationItem(
                        title: "History",
                        isExpanded: isExpanded,
                        icon: Icons.history,
                        onPressed: () {
                          setState(() {
                            _selectedPageIndex = 1;
                            pageController.jumpToPage(_selectedPageIndex);
                            isExpanded = false;
                          });
                        },
                      ),
                      NavigationItem(
                        title: "Community",
                        isExpanded: isExpanded,
                        icon: Icons.chat_bubble_outline,
                        onPressed: () {
                          setState(() {
                            _selectedPageIndex = 2;
                            pageController.jumpToPage(_selectedPageIndex);
                            isExpanded = false;
                          });
                        },
                      ),
                      const Spacer(),
                      NavigationItem(
                        title: "Settings",
                        isExpanded: isExpanded,
                        icon: Icons.settings,
                        onPressed: () {
                          setState(() {
                            _selectedPageIndex = 3;
                            pageController.jumpToPage(_selectedPageIndex);
                            isExpanded = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
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


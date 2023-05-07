import 'dart:io';

import 'package:diccon_evo/viewModels/data_manager.dart';
import 'package:diccon_evo/views/community.dart';
import 'package:diccon_evo/views/dictionary.dart';
import 'package:diccon_evo/views/history.dart';
import 'package:flutter/material.dart';

import 'global.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedPageIndex = 0;
  List<Widget> pages = [];
  PageController pageController = PageController();
  final words = [
    Word(
      word: 'Flutter',
      pronunciation: '/ˈflʌtər/',
      meaning:
          'a mobile app SDK for building high-performance, high-fidelity, apps for iOS, Android, and web',
      type: 'Noun',
    ),
    Word(
      word: 'Dart',
      pronunciation: '/dɑːt/',
      meaning:
          'a client-optimized language for fast apps on multiple platforms',
      type: 'Noun',
    ),
  ];
  @override
  void initState() {
    super.initState();
    loadUpData();
    pages = [
      DictionaryView(),
      HistoryView(
        words: words,
      ),
      CommunityView()
    ];
  }

  loadUpData() async {
    Global.wordList = await getWordList();
    print(Global.wordList[0].word);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    child: Text(Global.DICCON_DICTIONARY,
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
          ? Row(
              children: <Widget>[
                NavigationRail(
                  selectedIndex: _selectedPageIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedPageIndex = index;
                      pageController.jumpToPage(_selectedPageIndex);
                    });
                  },
                  labelType: NavigationRailLabelType.selected,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.search),
                      label: SizedBox.shrink(),
                      padding: EdgeInsets.zero,
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.history),
                      label: SizedBox.shrink(),
                      padding: EdgeInsets.zero,
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.chat_bubble_outline),
                      label: SizedBox.shrink(),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: pages,
                  ),
                ),
              ],
            )
          : Row( children: [Expanded(
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

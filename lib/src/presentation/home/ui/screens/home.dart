import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DateTime _backPressedTime = DateTime.now();

  int currentTabIndex = 0;
  int titleTabIndex = 0;
  List<String> tabTitleList = ['Stories', 'Conversation', 'Practice'];
  final tabController = PageController();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Brightness systemBrightness = MediaQuery.of(context).platformBrightness;
    Color statusBarColor = systemBrightness == Brightness.light
        ? Colors.white
        : Colors.transparent;

    // Set status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness: systemBrightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
    ));

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
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(top: 44, right: 16, left: 16, bottom: 16),
          child: Stack(
            children: [
              /// Body
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Head welcome to essential tab
                    const HeadSentence(
                        listText: ["Empower", "Your English", "Proficiency"]),
                    8.height,
                    const PlanButton(),
                    28.height,

                    /// TextField for user to enter their words
                    SearchBox(
                      enabled: false,
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search in dictionary".i18n,
                      onTextFieldTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DictionaryView(
                                    word: '', buildContext: context)));
                      },
                      onSubmitted: (enteredString) {},
                    ),
                    28.height,
                    SizedBox(
                      height: 40,
                      child: ListView(
                          padding: const EdgeInsets.only(right: 18),
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          children: tabTitleList.map((title) {
                            return GestureDetector(
                              onTap: () {
                                tabController.animateToPage(
                                    tabTitleList.indexOf(title),
                                    duration: const Duration(microseconds: 300),
                                    curve: Curves.easeIn);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 8, top: 8),
                                child: Opacity(
                                  opacity: currentTabIndex ==
                                          tabTitleList.indexOf(title)
                                      ? 1
                                      : .5,
                                  child: Text(
                                    title.i18n,
                                    style: context.theme.textTheme.titleLarge
                                        ?.copyWith(
                                      decoration: currentTabIndex ==
                                              tabTitleList.indexOf(title)
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                      color: Colors.transparent,
                                      decorationStyle:
                                          TextDecorationStyle.dotted,
                                      shadows: [
                                        Shadow(
                                            color: context.theme.textTheme
                                                    .titleLarge?.color ??
                                                Colors.black,
                                            offset: const Offset(0, -5))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                    8.height,
                    SizedBox(
                      height: 500,
                      child: PageView(
                          onPageChanged: (pageIndex) {
                            // Scroll listTitleTab to current tab title
                            scrollController.animateTo(
                                pageIndex *
                                    (scrollController.position.maxScrollExtent /
                                        tabTitleList.length),
                                duration: const Duration(microseconds: 300),
                                curve: Curves.easeIn);
                            setState(() {
                              currentTabIndex = pageIndex;
                            });
                          },
                          controller: tabController,
                          children: [
                            InkWell(
                              highlightColor: Colors.transparent,
                              child: const StoriesTab(),
                              onTap: () {
                                context
                                    .pushNamed(RouterConstants.readingChamber);
                              },
                            ),
                            InkWell(
                              highlightColor: Colors.transparent,
                              child: const ConversationTab(),
                              onTap: () {
                                context.pushNamed(RouterConstants.conversation);
                              },
                            ),
                            InkWell(
                              highlightColor: Colors.transparent,
                              child: const PracticeTab(),
                              onTap: () {
                                context
                                    .pushNamed(RouterConstants.essential1848);
                              },
                            ),
                          ]),
                    ),
                  ],
                ),
              ),

              /// Menu button
              const HomeMenuButton(),
            ],
          ),
        ),
      ),
    );
  }
}

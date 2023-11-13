import 'package:flutter/foundation.dart';
import 'package:upgrader/upgrader.dart';
import 'package:window_manager/window_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WindowListener {
  final List<Widget> _listPrimaryFunction = const [
    ToDictionaryButton(),
    ToConversationButton(),
  ];
  final List<Widget> _listSubFunction = const [
    ToReadingChamberButton(),
    ToEssentialWordButton(),
  ];

  DateTime _backPressedTime = DateTime.now();

  _loadUpData() async {
    /// Inscease count number to count the how many time user open app
    Properties.saveSettings(Properties.defaultSetting
        .copyWith(openAppCount: Properties.defaultSetting.openAppCount + 1));
    if (kDebugMode) {
      print(
          " Current Properties.defaultSetting.openAppCount value: ${Properties.defaultSetting.openAppCount.toString()}");
    }
  }

  /// Detect when windows is changing size
  @override
  void onWindowResize() async {
    Size windowsSize = await WindowManager.instance.getSize();
    // Save windows size to setting
    Properties.defaultSetting = Properties.defaultSetting.copyWith(
        windowsWidth: windowsSize.width, windowsHeight: windowsSize.height);
    Properties.saveSettings(Properties.defaultSetting);
  }

  @override
  void initState() {
    super.initState();
    WindowManager.instance.addListener(this);
    // Other loading steps
    _loadUpData();
    if (kDebugMode) {
      print("Data is loaded");
    }
  }

  @override
  Widget build(BuildContext context) {
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
      child: SafeArea(
        child: UpgradeAlert(
          upgrader: Upgrader(shouldPopScope: () =>  true),
          navigatorKey: router.routerDelegate.navigatorKey,
          child: Scaffold(
            backgroundColor: context.theme.colorScheme.surface,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  /// Menu button
                  const HomeMenuButton(),

                  /// Body
                  Responsive(
                    smallSizeDevice: smallSizeBody(),
                    mediumSizeDevice: smallSizeBody(),
                    largeSizeDevice: largeSizeBody(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column smallSizeBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Head welcome to essential tab
        const HeadSentence(
            listText: ["Empower", "Your English", "Proficiency"]),
        const VerticalSpacing.medium(),
        const PlanButton(),
        const VerticalSpacing.large(),

        /// TextField for user to enter their words
        SearchBox(
          prefixIcon: const Icon(Icons.search),
          hintText: "Search in dictionary".i18n,
          onSubmitted: (enteredString) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DictionaryView(
                        word: enteredString, buildContext: context)));
          },
        ),
        const VerticalSpacing.large(),

        /// Two big brother button
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _listPrimaryFunction.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 180,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return _listPrimaryFunction[index];
            }),
        const SizedBox(height: 8),

        /// Other functions
        SubFunctionBox(height: 180, listSubFunction: _listSubFunction),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Column largeSizeBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Head welcome to essential tab
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Center(
              child: Column(
            children: [
              Text(
                "Diccon Dictionary",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Opacity(
                  opacity: 0.5,
                  child: Text(
                    "Empower Your English Proficiency",
                    style: TextStyle(fontSize: 40),
                  )),
            ],
          )),
        ),
        const VerticalSpacing.medium(),
        const PlanButton(),
        const VerticalSpacing.large(),

        /// TextField for user to enter their words
        SearchBox(
          prefixIcon: const Icon(Icons.search),
          hintText: "Search in dictionary".i18n,
          onSubmitted: (enteredString) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DictionaryView(
                        word: enteredString, buildContext: context)));
          },
        ),
        const VerticalSpacing.large(),

        /// List Funtions
        SizedBox(
          height: 220,
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisExtent: 220,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            children: const [
              ToDictionaryButton(),
              ToConversationButton(),
              ToReadingChamberButton(),
              ToEssentialWordButton(),
            ],
          ),
        ),

        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

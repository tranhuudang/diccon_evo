import 'package:flutter/foundation.dart';
import 'package:window_manager/window_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WindowListener {
  final List<Widget> _listPrimaryFunction = const [
    ToDictionaryButton(),
    ToReadingChamberButton(),

  ];
  final List<Widget> _listSubFunction = const [
    ToConversationButton(),

    ToEssentialWordButton(),

  ];

  DateTime _backPressedTime = DateTime.now();

  _loadUpData() async {
    /// Increase count number to count the how many time user open app
    Properties.instance.saveSettings(Properties.instance.settings
        .copyWith(openAppCount: Properties.instance.settings.openAppCount + 1));
    if (kDebugMode) {
      print(
          " Current Properties.instance.settings.openAppCount value: ${Properties.instance.settings.openAppCount.toString()}");
    }
  }

  /// Detect when windows is changing size
  @override
  void onWindowResize() async {
    Size windowsSize = await WindowManager.instance.getSize();
    // Save windows size to setting
    final newSettings = Properties.instance.settings.copyWith(
        windowsWidth: windowsSize.width, windowsHeight: windowsSize.height);
    Properties.instance.saveSettings(newSettings);
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
        child: Scaffold(
          backgroundColor: context.theme.colorScheme.surface,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                /// Menu button
                const HomeMenuButton(),

                /// Body
                Column(
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
                    const VerticalSpacing.medium(),

                    /// Other functions
                    SubFunctionBox(height: 180, listSubFunction: _listSubFunction),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

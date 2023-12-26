import 'package:fluttertoast/fluttertoast.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Widget> _listPrimaryFunction = const [
    ToDictionaryButton(),
    ToReadingChamberButton(),
  ];
  final List<Widget> _listSubFunction = const [
    ToConversationButton(),
    ToEssentialWordButton(),
  ];

  DateTime _backPressedTime = DateTime.now();

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
            padding: const EdgeInsets.all(16),
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
                    8.height,
                    const PlanButton(),
                    16.height,

                    /// TextField for user to enter their words
                    SearchBox(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search in dictionary".i18n,
                      onSubmitted: (enteredString) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DictionaryView(
                                    word: enteredString,
                                    buildContext: context)));
                      },
                    ),
                    16.height,

                    /// Two big brother button
                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _listPrimaryFunction.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 180,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return _listPrimaryFunction[index];
                        }),
                    8.height,

                    /// Other functions
                    SubFunctionBox(
                        height: 180, listSubFunction: _listSubFunction),
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

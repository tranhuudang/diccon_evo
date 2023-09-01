import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/target_platform.dart';
import 'package:diccon_evo/screens/setting/ui/settings.dart';
import 'package:flutter/foundation.dart';
import '../../components/head_sentence.dart';
import 'to_dictionary_view_button.dart';
import 'to_essential_word_view_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'list_home_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.oxygen(
        textStyle: const TextStyle(letterSpacing: .5, fontSize: 36));
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            /// Menu button
            defaultTargetPlatform.isMobile()
                ? Positioned(
                    right: 16,
                    top: 16,
                    child: PopupMenuButton(
                      icon: const Icon(Icons.menu),
                      //splashRadius: 10.0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Theme.of(context).dividerColor),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            child: Text("Settings".i18n),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsView()));
                            }),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Head welcome to essential tab
                  HeadSentence(
                      listText: ["Empower", "Your English", "Proficiency"]),

                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ///  phrasal verb
                      ToDictionaryViewButton(),
                      SizedBox(
                        width: 8,
                      ),
                      ToEssentialWordView(),
                    ],
                  ),

                  /// History
                  ListHomeItem(
                    title: "History",
                    icon: Icon(Icons.history), /*trailing: "2000",*/
                  ),

                  /// Encourage user to use
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "fdmmmmmmmmm"
                                "mmmmmmmmmmmmm"
                                "mmmmmmmmmmmmmmmmmmmmmmmm"
                                "mmmmmmmmmmmmmmmmmmmm"
                                "mmmmmmmmmmmmmmmmmmmmmmmm"
                                "mmmmmmmmmmmmmmmmmmmmmmm"
                                "mmmmmmmmmmmmmmmmmmmmmmm"
                                "mmmmmmmmmmmmmmmmmmmmmf",
                                softWrap: true,
                                maxLines: 200,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        /// Close button
                        Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            )),
                      ],
                    ),
                  ),
                  //const ListHomeItem(title: 'Practice', icon: Icon(Icons.accessible_sharp)),
                  //const ListHomeItem(title: 'Community', icon: Icon(Icons.accessible_sharp)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/target_platform.dart';
import 'package:diccon_evo/screens/setting/ui/settings.dart';
import 'package:flutter/foundation.dart';
import '../../components/head_sentence.dart';
import 'components/to_dictionary_view_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/to_essential_word_view_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/list_home_item.dart';

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
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "We recognize that application quality is crucial for customer satisfaction. "
                            "Your feedback is greatly appreciated and drives ongoing improvements for our valued customers.",
                            softWrap: true,
                            maxLines: 200,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: InkWell(
                              onTap: () async {
                                if (defaultTargetPlatform.isMobile()) {
                                  final Uri url = Uri.parse(
                                      'https://play.google.com/store/apps/details?id=com.zeroboy.diccon_evo');
                                  if (!await launchUrl(url,
                                      mode: LaunchMode.externalApplication)) {
                                    throw Exception('Could not launch $url');
                                  }
                                } else {
                                  final Uri url = Uri.parse(
                                      'https://apps.microsoft.com/store/detail/diccon-evo/9NPF4HBMNG5D');
                                  if (!await launchUrl(url,
                                      mode: LaunchMode.externalApplication)) {
                                    throw Exception('Could not launch $url');
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(32),
                                    color: Colors.orange),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text("Give feedbacks"),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
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

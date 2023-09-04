import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/target_platform.dart';
import 'package:diccon_evo/screens/setting/ui/settings.dart';
import 'package:flutter/foundation.dart';
import '../../article/ui/article_history.dart';
import '../../article/ui/article_list.dart';
import '../../components/head_sentence.dart';
import '../../dictionary/ui/dictionary.dart';
import '../../essential/ui/essential.dart';
import '../../word_history/ui/word_history.dart';
import 'components/feature_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'components/list_home_item.dart';
import 'package:unicons/unicons.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            /// Menu button
            Positioned(
              right: 16,
              top: 16,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).cardColor,
                ),
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
                                builder: (context) => const SettingsView()));
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Head welcome to essential tab
                   HeadSentence(
                      listText: ["Empower".i18n, "Your English".i18n, "Proficiency".i18n]),

                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      FeatureButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DictionaryView(),
                            ),
                          );
                        },
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Diccon chat-based",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "Dictionary".i18n,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      FeatureButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EssentialView()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "1848",
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "words to learn".i18n,
                            ),
                            Spacer(),
                            Text(
                              "1848 Essential English Words".i18n,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ///
                  ListHomeItem(
                    title: "Reading Chamber".i18n,
                    icon: const Icon(UniconsLine.books),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ArticleListView(),
                          ));
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  HeadSentence(listText: ["Other tools".i18n]),
                  const SizedBox(
                    height: 16,
                  ),

                  /// Word History
                  ListHomeItem(
                    title: "Dictionary History".i18n,
                    icon: const Icon(Icons.history),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WordHistoryView(),
                          ));
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  /// Story History
                  ListHomeItem(
                    title: "Reading History".i18n,
                    icon: const Icon(Icons.history),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ArticleListHistoryView(),
                          ));
                    },
                  ),

                  /// Encourage user to use
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                           Text(
                            "We recognize that application quality is crucial for customer satisfaction. "
                            "Your feedback is greatly appreciated and drives ongoing improvements for our valued customers.".i18n,
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
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(32),
                                    color: Colors.orange),
                                child:  Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text("Give feedbacks".i18n),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

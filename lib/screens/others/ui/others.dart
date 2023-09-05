import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';

import '../../article/ui/article_history.dart';
import '../../home/ui/components/list_home_item.dart';
import '../../word_history/ui/word_history.dart';

class OthersView extends StatefulWidget {
  const OthersView({super.key});

  @override
  State<OthersView> createState() => _OthersViewState();
}

class _OthersViewState extends State<OthersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Container(
            height: 300,
            child: ListWheelScrollView(
                overAndUnderCenterOpacity: 1,
                physics: FixedExtentScrollPhysics(),
                //useMagnifier: true,
                //magnification: 1.5,
                itemExtent: 150, children: [
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
            ]),
          ),
        ],
      ),
    );
  }
}

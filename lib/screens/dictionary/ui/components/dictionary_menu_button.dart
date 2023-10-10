import 'dart:async';
import 'package:diccon_evo/config/properties.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/screens/commons/switch_translation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unicons/unicons.dart';

class DictionaryMenuButton extends StatefulWidget {
  const DictionaryMenuButton({super.key});

  @override
  State<DictionaryMenuButton> createState() => _DictionaryMenuButtonState();
}

class _DictionaryMenuButtonState extends State<DictionaryMenuButton> {
  final streamController = StreamController<TranslationChoices>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TranslationChoices>(
      initialData: Properties.translationChoice,
      stream: streamController.stream,
      builder: (context, snapshot) {
        return PopupMenuButton(
          //splashRadius: 10.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(16.0),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: snapshot.data! == TranslationChoices.ai
                  ? Row(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox().mediumWidth(),
                        Text(
                          "AI Dictionary",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        const Icon(
                          Icons.auto_awesome,
                        ),
                        const SizedBox().mediumWidth(),
                        const Text(
                          "AI Dictionary",
                        ),
                      ],
                    ),
              onTap: () {
                streamController.sink.add(TranslationChoices.ai);
                Properties.translationChoice = TranslationChoices.ai;
                if (kDebugMode) {
                  print("Enable chatbot dictionary");
                }
              },
            ),
            PopupMenuItem(
              child: snapshot.data! == TranslationChoices.classic
                  ? Row(
                      children: [
                        const Icon(
                          UniconsLine.books,
                          color: Colors.blue,
                        ),
                        const SizedBox().mediumWidth(),
                        Text("Classic Dictionary",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    )
                  : Row(
                      children: [
                        const Icon(Icons.book),
                        const SizedBox().mediumWidth(),
                        const Text("Classic Dictionary"),
                      ],
                    ),
              onTap: () {
                streamController.sink.add(TranslationChoices.classic);
                Properties.translationChoice = TranslationChoices.classic;
                if (kDebugMode) {
                  print("Enable classic dictionary");
                }
              },
            ),
            PopupMenuItem(
              child: Row(
                children: [
                  const Icon(Icons.settings),
                  const SizedBox().mediumWidth(),
                  Text("Custom".i18n),
                ],
              ),
              onTap: () {
                context.pushNamed('custom-dictionary');
              },
            ),
          ],
        );
      },
    );
  }
}

import 'dart:async';
import 'package:diccon_evo/config/properties.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/screens/dictionary/ui/custom_dictionary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class DictionaryMenuButton extends StatefulWidget {
  const DictionaryMenuButton({super.key});

  @override
  State<DictionaryMenuButton> createState() => _DictionaryMenuButtonState();
}

class _DictionaryMenuButtonState extends State<DictionaryMenuButton> {
  final streamController = StreamController<bool>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: Properties.chatbotEnable,
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
              child: snapshot.data!
                  ? Row(
                      children: [
                        const Icon(
                          Icons.auto_awesome,
                          color: Colors.blue,
                        ),
                        const SizedBox().mediumWidth(),
                        const Text(
                          "AI Dictionary",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
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
                streamController.sink.add(true);
                Properties.chatbotEnable = true;
                if (kDebugMode) {
                  print("Enable chatbot dictionary");
                }
              },
            ),
            PopupMenuItem(
              child: snapshot.data!
                  ? Row(
                      children: [
                        const Icon(UniconsLine.books),
                        const SizedBox().mediumWidth(),
                        const Text("Classic Dictionary"),
                      ],
                    )
                  : Row(
                      children: [
                        const Icon(
                          UniconsLine.books,
                          color: Colors.blue,
                        ),
                        const SizedBox().mediumWidth(),
                        const Text("Classic Dictionary",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
              onTap: () {
                streamController.sink.add(false);
                Properties.chatbotEnable = false;
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomDictionary()));
              },
            ),
          ],
        );
      },
    );
  }
}

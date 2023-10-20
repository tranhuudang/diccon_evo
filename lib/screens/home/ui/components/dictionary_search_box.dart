import 'dart:async';

import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';

import '../../../commons/tiny_close_button.dart';
import '../../../dictionary/ui/dictionary.dart';
import '../home.dart';
class DictionarySearchBoxInHome extends StatefulWidget {
  const DictionarySearchBoxInHome({super.key});

  @override
  State<DictionarySearchBoxInHome> createState() =>
      _DictionarySearchBoxInHomeState();
}

class _DictionarySearchBoxInHomeState extends State<DictionarySearchBoxInHome> {
  final _searchTextController = TextEditingController();
  final _tinyCloseButtonStreamController = StreamController<bool>();

  @override
  void dispose() {
    super.dispose();
    _tinyCloseButtonStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        /// Search dictionay textfield
        Expanded(
          child: StreamBuilder<bool>(
              stream: _tinyCloseButtonStreamController.stream,
              initialData: false,
              builder: (context, snapshot) {
                return Stack(
                  children: [
                    TextField(
                      controller: _searchTextController,
                      onChanged: (value) {
                        if (value == "") {
                          _tinyCloseButtonStreamController.add(false);
                        } else {
                          _tinyCloseButtonStreamController.add(true);
                        }
                      },
                      onSubmitted: (String value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DictionaryView(
                                    word: value, buildContext: context)));
                        // Remove text in textfield
                        _searchTextController.clear();
                        _tinyCloseButtonStreamController.add(false);
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16),
                        hintText: "Search in dictionary".i18n,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                        ),
                      ),
                    ),
                    if (snapshot.data!)
                      SizedBox(
                        height: 48,
                        //color: Colors.black54,
                        child: Row(
                          children: [
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Center(child: TinyCloseButton(onTap: () {
                                _searchTextController.clear();
                                // Dismiss keyboard
                                FocusScopeNode currentFocus =
                                FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                // Erase tiny button
                                _tinyCloseButtonStreamController.add(false);
                                _tinyCloseButtonStreamController.add(false);
                              })),
                            )
                          ],
                        ),
                      ),
                  ],
                );
              }),
        ),
      ],
    );
  }
}
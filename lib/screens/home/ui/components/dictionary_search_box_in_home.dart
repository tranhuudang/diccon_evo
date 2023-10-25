import 'dart:async';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import '../../../commons/voice_listening_bottom_sheet.dart';
import '../../../dictionary/ui/dictionary.dart';

class DictionarySearchBoxInHome extends StatefulWidget {
  final Function(String) onSubmit;
  const DictionarySearchBoxInHome({super.key, required this.onSubmit});

  @override
  State<DictionarySearchBoxInHome> createState() =>
      _DictionarySearchBoxInHomeState();
}

class _DictionarySearchBoxInHomeState extends State<DictionarySearchBoxInHome> {
  final _searchTextController = TextEditingController();
  final _closeTextFieldController = StreamController<bool>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _closeTextFieldController.close();
    _searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _closeTextFieldController.stream,
      initialData: false,
      builder: (context, showCloseButton) {
        return Stack(
          children: [
            /// Input box
            TextField(
              controller: _searchTextController,
              onChanged: (value) {
                if (value == "") {
                  _closeTextFieldController.add(false);
                } else {
                  _closeTextFieldController.add(true);
                }
              },
              onSubmitted: (String enteredString) {
                widget.onSubmit(enteredString);
                // Remove text in textfield
                _searchTextController.clear();
                _closeTextFieldController.add(false);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                hintText: "Search in dictionary".i18n,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                ),
              ),
            ),

            /// Close button
            if (showCloseButton.data!)
              Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        _searchTextController.clear();
                        // Dismiss keyboard
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        // Erase tiny button
                        _closeTextFieldController.add(false);
                        _closeTextFieldController.add(false);
                      },
                      icon: const Icon(Icons.close))),

            /// Micro button
            if (!showCloseButton.data!)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => VoiceListeningBottomSheet(
                        onSubmit: (speechResult) {
                          widget.onSubmit(speechResult);
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.mic_none),
                ),
              ),
          ],
        );
      },
    );
  }
}

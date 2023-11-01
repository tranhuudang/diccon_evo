import 'dart:async';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:unicons/unicons.dart';

import '../../../../dictionary/presentation/ui/screens/camera.dart';

class SearchBox extends StatefulWidget {
  final Function(String) onSubmitted;
  final Function(String)? onChanged;
  final bool? enabled;
  final String? hintText;

  final bool? enableCamera;

  final Icon? prefixIcon;
  const SearchBox(
      {super.key,
      required this.onSubmitted,
      this.onChanged,
      this.enabled = true,
      this.hintText,
      this.prefixIcon,
      this.enableCamera = true});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
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
              enabled: widget.enabled,
              controller: _searchTextController,
              onChanged: (currentValue) {
                widget.onChanged != null
                    ? widget.onChanged!(currentValue)
                    : null;
                // Whether to show close button or not
                if (currentValue == "") {
                  _closeTextFieldController.add(false);
                } else {
                  _closeTextFieldController.add(true);
                }
              },
              onSubmitted: (String enteredString) {
                widget.onSubmitted(enteredString);
                // Remove text in textfield
                _searchTextController.clear();
                _closeTextFieldController.add(false);
              },
              decoration: InputDecoration(
                prefixIcon: widget.prefixIcon,
                contentPadding: const EdgeInsets.only(left: 16, right: 50),
                hintText: widget.hintText,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                ),
              ),
            ),

            /// Close button
            if (showCloseButton.data!)
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: defaultTargetPlatform.isWindows()
                        ? const EdgeInsets.all(4.0)
                        : EdgeInsets.zero,
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
                        icon: const Icon(Icons.close)),
                  )),

            /// Micro button
            if (defaultTargetPlatform.isAndroid())
              if (!showCloseButton.data!)
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.enableCamera!)
                        IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const Camera()));
                          },
                          icon: const Icon(UniconsLine.capture),
                        ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => VoiceListeningBottomSheet(
                              onSubmit: (speechResult) {
                                widget.onSubmitted(speechResult);
                              },
                            ),
                          );
                        },
                        icon: const Icon(Icons.mic_none),
                      ),
                    ],
                  ),
                ),
          ],
        );
      },
    );
  }
}

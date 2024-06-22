import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wave_divider/wave_divider.dart';

import '../../../presentation.dart';

class DictionaryBubbleDefinition extends StatelessWidget {
  final String word;
  final String translation;
  const DictionaryBubbleDefinition(
      {super.key, required this.word, required this.translation});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 86.sw,
                  minWidth: 28.sw,
                ),
                //height: _isTooLarge ? 500 : null,
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(0.0),
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 20, right: 12, bottom: 10),
                              child: SelectableText(translation,style: context.theme.textTheme.bodyMedium
                                       ?.copyWith(color: context.theme.colorScheme.onSecondary),),
                            ),
                          ],
                        ),
                        WaveDivider(
                          thickness: .3,
                          color: context.theme.colorScheme.onSecondary,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: context.theme.colorScheme.secondary,
                            //color: Colors.red,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              8.width,
                              PlaybackButton(
                                message: word,
                              ),
                              IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: translation));
                                  Fluttertoast.showToast(
                                      msg: 'Copied to clipboard'.i18n);
                                },
                                icon: Icon(
                                  Icons.copy,
                                  color: context.theme.colorScheme.onSecondary,
                                  size: 16,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}

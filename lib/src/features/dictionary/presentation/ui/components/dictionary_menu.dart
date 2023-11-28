import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:wave_divider/wave_divider.dart';

import '../../../../../core/core.dart';

class DictionaryMenu extends StatefulWidget {
  const DictionaryMenu({super.key});

  @override
  State<DictionaryMenu> createState() => _DictionaryMenuState();
}

class _DictionaryMenuState extends State<DictionaryMenu> {
  final _streamController = StreamController<TranslationChoices>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }
  @override
  Widget build(BuildContext context) {
    final currentSettings = Properties.instance.settings;
    return StreamBuilder<TranslationChoices>(
      initialData:
      currentSettings.translationChoice.toTranslationChoice(),
      stream: _streamController.stream,
      builder: (context, snapshot) {
        return PopupMenuButton(
          //splashRadius: 10.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: context.theme.dividerColor),
            borderRadius: BorderRadius.circular(16.0),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: snapshot.data! == TranslationChoices.explain
                  ? Text(
                      "Prefer AI".i18n,
                      style: TextStyle(
                        color: context.theme.colorScheme.primary,
                      ),
                    )
                  : Text(
                      "Prefer AI".i18n,
                    ),
              onTap: () {
                _streamController.sink.add(TranslationChoices.explain);
                final newSettings = currentSettings
                    .copyWith(translationChoice: TranslationChoices.explain.title());
                Properties.instance.saveSettings(newSettings);
                if (kDebugMode) {
                  print("Enable prefer chatbot dictionary");
                }
              },
            ),
            PopupMenuItem(
              child: snapshot.data! == TranslationChoices.translate
                  ? Text("Prefer Classic".i18n,
                      style: TextStyle(
                        color: context.theme.colorScheme.primary,
                      ))
                  : Text("Prefer Classic".i18n),
              onTap: () {
                _streamController.sink.add(TranslationChoices.translate);
                final newSettings = currentSettings.copyWith(
                    translationChoice: TranslationChoices.translate.title());
                Properties.instance.saveSettings(newSettings);
                if (kDebugMode) {
                  print("Enable prefer classic dictionary");
                }
              },
            ),
            const PopupMenuItem(
              height: 0,
              child:  WaveDivider(thickness: .3,),

            ),
            PopupMenuItem(
              child: Text("Custom".i18n),
              onTap: () {
                context.pushNamed(RouterConstants.dictionaryPreferences);
              },
            ),
          ],
        );
      },
    );
  }
}

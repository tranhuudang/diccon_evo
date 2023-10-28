import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:diccon_evo/common/common.dart';

class DictionaryMenuButton extends StatefulWidget {
  const DictionaryMenuButton({super.key});

  @override
  State<DictionaryMenuButton> createState() => _DictionaryMenuButtonState();
}

class _DictionaryMenuButtonState extends State<DictionaryMenuButton> {
  final _streamController = StreamController<TranslationChoices>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TranslationChoices>(
      initialData:
          Properties.defaultSetting.translationChoice.toTranslationChoice(),
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
              child: snapshot.data! == TranslationChoices.ai
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
                _streamController.sink.add(TranslationChoices.ai);
                Properties.defaultSetting = Properties.defaultSetting
                    .copyWith(translationChoice: TranslationChoices.ai.title());
                Properties.saveSettings(Properties.defaultSetting);
                if (kDebugMode) {
                  print("Enable prefer chatbot dictionary");
                }
              },
            ),
            PopupMenuItem(
              child: snapshot.data! == TranslationChoices.classic
                  ? Text("Prefer Classic".i18n,
                      style: TextStyle(
                        color: context.theme.colorScheme.primary,
                      ))
                  : const Text("Prefer Classic"),
              onTap: () {
                _streamController.sink.add(TranslationChoices.classic);
                Properties.defaultSetting = Properties.defaultSetting.copyWith(
                    translationChoice: TranslationChoices.classic.title());
                Properties.saveSettings(Properties.defaultSetting);
                if (kDebugMode) {
                  print("Enable prefer classic dictionary");
                }
              },
            ),
            const PopupMenuItem(
              height: 0,
              child: Divider(),
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

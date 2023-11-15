import 'package:diccon_evo/src/common/data/enum/translate_language_target.dart';
import 'package:diccon_evo/src/features/dictionary/data/bloc/bloc.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_divider/wave_divider.dart';
import 'package:diccon_evo/src/common/common.dart';

class DictionaryBottomMenu extends StatelessWidget {
  const DictionaryBottomMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final chatListBloc = context.read<ChatListBloc>();
    final settingBloc = context.read<SettingBloc>();
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 300,
                  child: BlocBuilder<SettingBloc, SettingState>(
                      builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.add_circle_outline),
                          title: Text('Create a new section'.i18n),
                          onTap: () {
                            context.showAlertDialog(
                              title: "Close this session?",
                              content:
                                  "Clear all the bubbles in this translation session.",
                              action: () {
                                //resetSuggestion();
                                chatListBloc.add(CreateNewChatList());
                              },
                            );
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: WaveDivider(
                            thickness: .3,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.auto_awesome_outlined),
                          title: Text('Auto detect language'.i18n),
                          onTap: () {
                            settingBloc.add(AutoDetectLanguage());
                          },
                          trailing: state.params.translationLanguageTarget ==
                                  TranslationLanguageTarget.autoDetect
                              ? const Icon(Icons.check)
                              : const SizedBox.shrink(),
                        ),
                        ListTile(
                          title: Text(
                              'Force translate Vietnamese to English'.i18n),
                          onTap: () {
                            settingBloc
                                .add(ForceTranslateVietnameseToEnglish());
                          },
                          trailing: state.params.translationLanguageTarget ==
                              TranslationLanguageTarget.vietnameseToEnglish
                              ? const Icon(Icons.check)
                              : const SizedBox.shrink(),
                        ),
                        ListTile(
                          title: Text(
                              'Force translate English to Vietnamese'.i18n),
                          onTap: () {
                            settingBloc
                                .add(ForceTranslateEnglishToVietnamese());
                          },
                          trailing: state.params.translationLanguageTarget ==
                              TranslationLanguageTarget.englishToVietnamese
                              ? const Icon(Icons.check)
                              : const SizedBox.shrink(),
                        ),
                      ],
                    );
                  }),
                );
              });
        },
        icon: const Icon(Icons.add_circle_outline));
  }
}

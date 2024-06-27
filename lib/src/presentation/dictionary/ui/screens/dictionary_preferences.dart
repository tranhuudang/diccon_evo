import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/settings/settings.dart';

class DictionaryPreferences extends StatefulWidget {
  const DictionaryPreferences({super.key});

  @override
  State<DictionaryPreferences> createState() => _DictionaryPreferencesState();
}

class _DictionaryPreferencesState extends State<DictionaryPreferences> {
  final dictionaryPreferencesBloc = DictionaryPreferencesBloc();
  List<String> listChoices = [
    "Phiên âm",
    "Định nghĩa",
    "Ví dụ",
    "Nguồn gốc",
    "Loại từ",
    "Ghi chú về cách sử dụng",
    "Từ đồng âm",
    "Cụm động từ",
    "Viết tắt",
    "Lưu ý về cách sử dụng",
  ];
  List<String> listSpecializedFields = [
    "Y học",
    "Luật pháp",
    "Khoa học",
    "Kỹ thuật",
    "Tài chính và Kinh tế",
    "Môi trường",
    "Ngôn ngữ học",
    "Toán học",
    "Nghệ thuật",
    "Âm nhạc",
    "Tâm lý học",
    "Triết học",
    "Thiên văn học",
    "Địa chất học",
    "Thực vật học",
    "Động vật học",
    "Kiến trúc",
    "Lịch sử",
    "Ẩm thực",
    "Thời trang",
    "Thể thao",
    "Du lịch",
    "Hàng không vũ trụ",
    "Hàng hải",
    "Giao thông vận tải",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preferences".i18n),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<DictionaryPreferencesBloc,
                DictionaryPreferencesState>(
            bloc: dictionaryPreferencesBloc,
            listenWhen: (previous, current) =>
                current is DictionaryPreferencesActionState,
            buildWhen: (previous, current) =>
                current is! DictionaryPreferencesActionState,
            listener: (context, state) {
              if (state is DictionaryPreferencesNotifyAboutLimitChoices) {
                context.showAlertDialogWithoutAction(
                    title: "Maximum Choices Reached".i18n,
                    content:
                        "You've reached the maximum limit of 7 choices in your selection. Please review your choices and make any necessary adjustments before proceeding"
                            .i18n);
              }
            },
            builder: (context, state) {
              final dictionaryPrefBloc =
                  context.read<DictionaryPreferencesBloc>();
              return Column(
                children: [
                  Section(title: 'Generate Engine'.i18n, children: [
                    // Create two radio buttons to select DictionaryEngine
                    RadioListTile<DictionaryEngine>(
                      title: Text('Stream'.i18n),
                      subtitle: Text(
                          'Faster but less reliable and stable.'.i18n,
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            color: context.theme.textTheme.bodyMedium?.color
                                ?.withOpacity(.5),
                          )),
                      value: DictionaryEngine.stream,
                      groupValue: state.params.dictionaryEngine,
                      onChanged: (DictionaryEngine? value) {
                        if (value != null) {
                          dictionaryPreferencesBloc.add(
                              ChangeDictionaryEngine(dictionaryEngine: value));
                        }
                      },
                    ),
                    RadioListTile<DictionaryEngine>(
                      title: Text('${'Time-bomb'.i18n} (${'Recommend'.i18n})'),
                      subtitle: Text(
                          'Slower but more accurate and precise.'.i18n,
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            color: context.theme.textTheme.bodyMedium?.color
                                ?.withOpacity(.5),
                          )),
                      value: DictionaryEngine.timeBomb,
                      groupValue: state.params.dictionaryEngine,
                      onChanged: (DictionaryEngine? value) {
                        if (value != null) {
                          dictionaryPreferencesBloc.add(
                              ChangeDictionaryEngine(dictionaryEngine: value));
                        }
                      },
                    ),
                  ]),
                  Section(
                    title: "Customize response format".i18n,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 3,
                          runSpacing: 3,
                          children:
                              state.params.listSelectedVietnamese.map((item) {
                            if (DefaultSettings
                                    .dictionaryResponseEnglishConstant
                                    .contains(item) ||
                                DefaultSettings
                                    .dictionaryResponseVietnameseConstant
                                    .contains(item)) {
                              return ActionChip(
                                backgroundColor: context
                                    .theme.colorScheme.secondary
                                    .withOpacity(.5),
                                label: Text(
                                  item.i18n,
                                  style: TextStyle(
                                      color: context
                                          .theme.colorScheme.onSecondary),
                                ),
                                onPressed: () {},
                              );
                            } else {
                              return ActionChip(
                                backgroundColor:
                                    context.theme.colorScheme.secondary,
                                label: Text(
                                  item.i18n,
                                  style: TextStyle(
                                      color: context
                                          .theme.colorScheme.onSecondary),
                                ),
                                onPressed: () => dictionaryPreferencesBloc
                                    .add(RemoveItemInList(itemToRemove: item)),
                              );
                            }
                          }).toList(),
                        ),
                      ),
                      Text(
                          'The complexity of the response will significantly increase the time it takes for the application to reply.'
                              .i18n,
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            color: context.theme.textTheme.bodyMedium?.color
                                ?.withOpacity(.5),
                          )),
                      IgnorePointer(
                        child: Opacity(
                          opacity: .2,
                          child: Column(
                            children: [
                              16.height,
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Word details".i18n,
                                  style: context.theme.textTheme.titleMedium?.copyWith(
                                      color: context.theme.colorScheme.primary),
                                ),
                              ),
                              16.height,
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  spacing: 3,
                                  runSpacing: 3,
                                  children: listChoices.map((item) {
                                    bool isSelected = false;
                                    if (state.params.listSelectedVietnamese
                                        .contains(item)) {
                                      isSelected = true;
                                    }
                                    if (DefaultSettings
                                            .dictionaryResponseEnglishConstant
                                            .contains(item) ||
                                        DefaultSettings
                                            .dictionaryResponseVietnameseConstant
                                            .contains(item)) {
                                      return ChoiceChip(
                                        label: Text(item.i18n),
                                        selected: isSelected,
                                        onSelected: (selected) {},
                                      );
                                    } else {
                                      return ChoiceChip(
                                        label: Text(item.i18n),
                                        selected: isSelected,
                                        onSelected: (selected) {
                                          if (state.params.listSelectedVietnamese
                                              .contains(item)) {
                                            dictionaryPreferencesBloc.add(
                                                RemoveItemInList(itemToRemove: item));
                                          } else {
                                            dictionaryPreferencesBloc.add(
                                                AddItemToSelectedList(itemToAdd: item));
                                          }
                                        },
                                      );
                                    }
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      16.height,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Specialized meanings".i18n,
                          style: context.theme.textTheme.titleMedium?.copyWith(
                              color: context.theme.colorScheme.primary),
                        ),
                      ),
                      16.height,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 3,
                          runSpacing: 3,
                          children: listSpecializedFields.map((item) {
                            bool isSelected = false;
                            if (state.params.listSelectedVietnamese
                                .contains(item)) {
                              isSelected = true;
                            }
                            return ChoiceChip(
                              label: Text(item.i18n),
                              selected: isSelected,
                              onSelected: (selected) {
                                if (state.params.listSelectedVietnamese
                                    .contains(item)) {
                                  dictionaryPreferencesBloc.add(
                                      RemoveItemInList(itemToRemove: item));
                                } else {
                                  dictionaryPreferencesBloc.add(
                                      AddItemToSelectedList(itemToAdd: item));
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}

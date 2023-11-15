import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    "Từ liên quan",
    "Từ đồng âm",
    "Biến thể vùng miền",
    "Bối cảnh văn hóa hoặc lịch sử",
    "Từ tạo thành từ này",
    "Động từ thành ngữ",
    "Viết tắt",
    "Khái niệm liên quan",
    "Tần suất sử dụng",
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.surface,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: BlocConsumer<DictionaryPreferencesBloc,
                  DictionaryPreferencesState>(
                  bloc: dictionaryPreferencesBloc,
                  listenWhen: (previous, current) => current is DictionaryPreferencesActionState,
                  buildWhen: (previous, current) => current is !DictionaryPreferencesActionState,
                  listener: (context, state) {
                if (state is DictionaryPreferencesNotifyAboutLimitChoices) {
                  context.showAlertDialogWithoutAction(
                      title: "Maximum Choices Reached".i18n,
                      content:
                          "You've reached the maximum limit of 7 choices in your selection. Please review your choices and make any necessary adjustments before proceeding"
                              .i18n);
                }
              }, builder: (context, state) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Section(
                      title: "Customize the AI response format.".i18n,
                      children: [
                        Wrap(
                          spacing: 3,
                          runSpacing: 3,
                          children: state.listSelectedVietnamese
                              .map((item) => ActionChip(
                                    backgroundColor:
                                        context.theme.colorScheme.secondary,
                                    label: Text(
                                      item.i18n,
                                      style: TextStyle(
                                          color: context
                                              .theme.colorScheme.onSecondary),
                                    ),
                                    onPressed: () => dictionaryPreferencesBloc
                                        .add(RemoveItemInList(
                                            itemToRemove: item)),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                    Section(
                      title: "Available options".i18n,
                      children: [
                        Wrap(
                          spacing: 3,
                          runSpacing: 3,
                          children: listChoices.map((item) {
                            bool isSelected = false;
                            if (state.listSelectedVietnamese.contains(item)) {
                              isSelected = true;
                            }
                            return ChoiceChip(
                              label: Text(item.i18n),
                              selected: isSelected,
                              onSelected: (selected) {
                                if (state.listSelectedVietnamese.contains(item)) {
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
                      ],
                    ),
                    Section(
                      title: "Specialized Meanings".i18n,
                      children: [
                        Wrap(
                          spacing: 3,
                          runSpacing: 3,
                          children: listSpecializedFields.map((item) {
                            bool isSelected = false;
                            if (state.listSelectedVietnamese.contains(item)) {
                              isSelected = true;
                            }
                            return ChoiceChip(
                              label: Text(item.i18n),
                              selected: isSelected,
                              onSelected: (selected) {
                                if (state.listSelectedVietnamese.contains(item)) {
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
                      ],
                    ),
                  ],
                );
              }),
            ),
            Header(
              title: "Preferences".i18n,
              actions: const [],
            ),
          ],
        ),
      ),
    );
  }
}

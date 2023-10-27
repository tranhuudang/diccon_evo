import 'package:flutter/material.dart';
import 'package:diccon_evo/features/features.dart';
import 'package:diccon_evo/common/common.dart';

class DictionaryPreferences extends StatefulWidget {
  const DictionaryPreferences({super.key});

  @override
  State<DictionaryPreferences> createState() => _DictionaryPreferencesState();
}

class _DictionaryPreferencesState extends State<DictionaryPreferences> {
  List<String> listSelected =
      Properties.defaultSetting.dictionaryResponseSelectedList.split(", ");
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

  void _compileSelectedItems() {
    final convertedString =
        listSelected.join(", "); // Joins the items with a space
    Properties.saveSettings(Properties.defaultSetting
        .copyWith(dictionaryResponseSelectedList: convertedString));
    Properties.defaultSetting = Properties.defaultSetting
        .copyWith(dictionaryResponseSelectedList: convertedString);
  }

  void _addItemToLists(
      {required String item, required List<String> targetList}) {
    setState(() {
      targetList.add(item);
    });
  }

  void _removeItemInLists(
      {required String item, required List<String> targetList}) {
    setState(() {
      targetList.remove(item);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
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
                        children: listSelected
                            .map((item) => ActionChip(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  label: Text(
                                    item.i18n,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary),
                                  ),
                                  onPressed: () {
                                    _removeItemInLists(
                                        item: item, targetList: listSelected);
                                    // rebuild list selected item and save it to setting
                                    _compileSelectedItems();
                                  },
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
                          if (listSelected.contains(item)) isSelected = true;
                          return ChoiceChip(
                            label: Text(item.i18n),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (listSelected.contains(item)) {
                                _removeItemInLists(
                                    item: item, targetList: listSelected);
                              } else {
                                _addItemToLists(
                                    item: item, targetList: listSelected);
                              }
                              // rebuild list selected item and save it to setting
                              _compileSelectedItems();
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
                          if (listSelected.contains(item)) isSelected = true;
                          return ChoiceChip(
                            label: Text(item.i18n),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (listSelected.contains(item)) {
                                _removeItemInLists(
                                    item: item, targetList: listSelected);
                              } else {
                                _addItemToLists(
                                    item: item, targetList: listSelected);
                              }

                              // rebuild list selected item and save it to setting
                              _compileSelectedItems();
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
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

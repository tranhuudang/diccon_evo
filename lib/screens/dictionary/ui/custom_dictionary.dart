import 'dart:async';
import 'package:diccon_evo/config/properties.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/extensions/string.dart';
import 'package:diccon_evo/extensions/target_platform.dart';
import 'package:diccon_evo/screens/commons/header.dart';
import 'package:diccon_evo/screens/dictionary/ui/components/chatbot_buble_preview.dart';
import 'package:diccon_evo/screens/dictionary/ui/components/user_bubble_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../data/data_providers/chat_preview_list_data.dart';
import '../../../data/models/dictionary_response_type.dart';
import 'components/pageview_navigator.dart';

class CustomDictionary extends StatefulWidget {
  const CustomDictionary({super.key});

  @override
  State<CustomDictionary> createState() => _CustomDictionaryState();
}

class _CustomDictionaryState extends State<CustomDictionary> {
  final _pageViewController = PageController();
  final _isSelectedStreamController = StreamController<DictionaryResponseType>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 90,
                  ),
                  SizedBox(
                    height: 550,
                    child: Stack(
                      children: [
                        StreamBuilder<DictionaryResponseType>(
                            stream: _isSelectedStreamController.stream,
                            initialData: Properties.defaultSetting.dictionaryResponseType.toDictionaryResponseType(),
                            builder: (context, snapshot) {
                              return PageView(
                                controller: _pageViewController,
                                children: listChatPreviewContent.map((item) {
                                  return CustomItem(
                                      isSelected:
                                          snapshot.data == item.responseType,
                                      content: item.content,
                                      onTap: () {
                                        _isSelectedStreamController.sink
                                            .add(item.responseType);
                                        Properties.defaultSetting = Properties.defaultSetting.copyWith(dictionaryResponseType: item.responseType.title());
                                        Properties.saveSettings(Properties.defaultSetting);
                                      });
                                }).toList(),
                              );
                            }),
                        defaultTargetPlatform.isDesktop()
                            ? Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: PageViewNavigator(
                                    itemCount: listChatPreviewContent.length,
                                    controller: _pageViewController,
                                    height: 550),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageViewController,
                    count: listChatPreviewContent.length,
                    effect: ScrollingDotsEffect(
                      maxVisibleDots: 5,
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Theme.of(context).primaryColor,
                      dotColor: Theme.of(context).highlightColor,
                    ),
                  ),
                  const SizedBox().mediumHeight(),
                ],
              ),
            ),
            Header(
              title: "Custom".i18n,
              actions: const [],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomItem extends StatelessWidget {
  final String content;
  final VoidCallback onTap;
  final bool isSelected;
  const CustomItem({
    super.key,
    required this.content,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          children: [
            const UserBubblePreview(content: "Happy"),
            ChatbotBubblePreview(
              textReturn: content,
            ),
            const Spacer(),
            InkWell(
              onTap: onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 32,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).highlightColor,
                  ),
                  const SizedBox().mediumWidth(),
                  Text(
                    "Set as default format".i18n,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox().mediumHeight(),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:diccon_evo/src/features/features.dart';
import 'package:flutter/material.dart';
class PageViewNavigator extends StatefulWidget {
  const PageViewNavigator({
    super.key,
    this.height = 500,
    required this.controller,
    required this.itemCount,
  });

  final double? height;
  final PageController controller;
  final int itemCount;

  @override
  State<PageViewNavigator> createState() => _PageViewNavigatorState();
}

class _PageViewNavigatorState extends State<PageViewNavigator> {
  StreamController currentPageStreamController = StreamController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
              initialData: 1,
              stream: currentPageStreamController.stream,
              builder: (context, currentPage) {
                return Row(
                  children: [
                    if (currentPage.data > 1)
                      RectangleButton(
                          iconData: Icons.chevron_left,
                          onTap: () {
                            widget.controller.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                            currentPageStreamController
                                .add(currentPage.data - 1);
                          }),
                    const Spacer(),
                    if (currentPage.data < widget.itemCount)
                      RectangleButton(
                          iconData: Icons.chevron_right,
                          onTap: () {
                            widget.controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                            currentPageStreamController
                                .add(currentPage.data + 1);
                          }),
                  ],
                );
              }),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';

class SubFunctionBox extends StatefulWidget {
  const SubFunctionBox({
    super.key,
    required this.listSubFunction,
    this.height = 150,
  });

  final List<Widget> listSubFunction;
  final double? height;

  @override
  State<SubFunctionBox> createState() => _SubFunctionBoxState();
}

class _SubFunctionBoxState extends State<SubFunctionBox> {
  var listSubFunction= [];
  @override
  void initState(){
    super.initState();
    if (Properties.defaultSetting.openAppCount.isEven){
      listSubFunction = widget.listSubFunction.reversed.toList();
    }
    else {
      listSubFunction  = widget.listSubFunction;

    }
  }
  @override
  Widget build(BuildContext context) {
    StreamController<int> streamController = StreamController<int>();
    PageController pageController = PageController();
    return StreamBuilder<int>(
      initialData: 0,
      stream: streamController.stream,
      builder: (context, snapshot) {
        return Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: widget.height,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: listSubFunction.length,
                      onPageChanged: (index) =>
                          streamController.sink.add(index),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(child: listSubFunction[index]),
                        );
                      }),
                ),
                if (defaultTargetPlatform.isDesktop())
                    PageViewNavigator(
                        itemCount: widget.listSubFunction.length,
                        controller: pageController,
                        height: widget.height),
              ],
            ),
            const VerticalSpacing.large(),
            SmoothPageIndicator(
              controller: pageController,
              count: listSubFunction.length,
              effect: ScrollingDotsEffect(
                maxVisibleDots: 5,
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: context.theme.colorScheme.primary,
                dotColor: context.theme.highlightColor,
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'dart:async';

import 'package:diccon_evo/extensions/target_platform.dart';
import 'package:diccon_evo/screens/commons/circle_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SubFunctionBox extends StatelessWidget {
  const SubFunctionBox({
    super.key,
    required this.listSubFunction,
    this.height = 150,
  });

  final List<Widget> listSubFunction;
  final double? height;

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
            SizedBox(
              height: height,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: listSubFunction.length,
                  onPageChanged: (index) => streamController.sink.add(index),
                  itemBuilder: (context, index) {
                    return listSubFunction[index];
                  }),
            ),
            defaultTargetPlatform.isDesktop()
                ?

                /// List number indicator for desktop devices
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CircleButtonBar(
                          children: [
                            for (int index = 0;
                                index < listSubFunction.length;
                                index++)
                              CircleTextButton(
                                backgroundColor: snapshot.data == index
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).highlightColor,
                                text: (index + 1).toString(),
                                onTap: () {
                                  pageController.animateToPage(index,
                                      duration: const Duration(microseconds: 500),
                                      curve: Curves.easeIn);
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  )
                :

                /// List indicator dot for mobile devices
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int index = 0;
                          index < listSubFunction.length;
                          index++)
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8, left: 8, right: 8),
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: snapshot.data == index
                                  ? Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .color
                                  : Theme.of(context).highlightColor,
                            ),
                          ),
                        ),
                    ],
                  ),
          ],
        );
      },
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

class SubFunctionBox extends StatelessWidget {
  const SubFunctionBox({
    super.key,
    required this.listSubFunction, this.height = 150,
  });

  final List<Widget> listSubFunction;
  final double? height;

  @override
  Widget build(BuildContext context) {
    StreamController<int> streamController = StreamController<int>();
    return StreamBuilder<int>(
        initialData: 1,
        stream: streamController.stream,
        builder: (context, snapshot) {
          return Column(
            children: [
              SizedBox(
                height: height,
                child: PageView.builder(
                    itemCount: listSubFunction.length,
                    onPageChanged: (index) => streamController.sink.add(index),
                    itemBuilder: (context, index) {
                      return listSubFunction[index];
                    }),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (int index = 0; index < listSubFunction.length; index++)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: snapshot.data == index
                              ? Theme.of(context).textTheme.labelMedium!.color
                              : Theme.of(context).highlightColor,
                        )),
                  ),
              ]),
            ],
          );
        });
  }
}

import 'dart:async';

import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:flutter/material.dart';

import '../../../../config/properties.dart';

class DictionaryWelcome extends StatefulWidget {
  const DictionaryWelcome({super.key});

  @override
  State<DictionaryWelcome> createState() => _DictionaryWelcomeState();
}

class _DictionaryWelcomeState extends State<DictionaryWelcome> {
final streamController = StreamController<bool>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: streamController.stream,
      builder: (context, snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child:  Column(
                children: [
                  const Image(
                    image: AssetImage('assets/stickers/book.png'),
                    width: 200,
                  ),
                  const SizedBox().mediumHeight(),
                  Text(
                    "TitleWordInDictionaryWelcomeBox".i18n,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox().mediumHeight(),
                  Opacity(
                    opacity: 0.5,
                    child: Text(
                      "SubWordInDictionaryWelcomeBox".i18n,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox().largeHeight(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(32),

                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            streamController.sink.add(true);
                            Properties.chatbotEnable = true;
                          },
                          child: Properties.chatbotEnable ?
                          const Column(
                            children: [
                              Text("AI", style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("Dictionary", style:TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ):
                          const Column(
                            children: [
                              Text("AI"),
                              Text("Dictionary"),
                            ],
                          )
                          ,
                        ),
                        const VerticalDivider(),
                        InkWell(
                          onTap: (){
                            streamController.sink.add(false);
                            Properties.chatbotEnable = false;
                          },
                          child: Properties.chatbotEnable ?
                          const Column(
                            children: [
                              Text("Classic"),
                              Text("Dictionary"),
                            ],
                          ):
                          const Column(
                            children: [
                              Text("Classic",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("Dictionary",style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],

              ),
            ),

          ],
        );
      }
    );
  }
}

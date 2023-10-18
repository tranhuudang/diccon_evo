import 'dart:async';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:flutter/material.dart';

class DictionaryWelcome extends StatefulWidget {
  const DictionaryWelcome({super.key});

  @override
  State<DictionaryWelcome> createState() => _DictionaryWelcomeState();
}

class _DictionaryWelcomeState extends State<DictionaryWelcome> {
  final _streamController = StreamController<bool>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 300,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage('assets/stickers/book.png'),
                      height: 180,
                    ),
                    const SizedBox().mediumHeight(),
                    Text(

                      "TitleWordInDictionaryWelcomeBox".i18n,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox().mediumHeight(),
                    Opacity(
                      opacity: 0.5,
                      child: Text(
                        "SubWordInDictionaryWelcomeBox".i18n,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

class AiDictionaryPillButton extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;

  const AiDictionaryPillButton({
    super.key,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32), bottomLeft: Radius.circular(32)),
          color: selected
              ? Theme.of(context).primaryColor
              : Theme.of(context).cardColor,
        ),
        child: Column(
          children: [
            Text(
              "AI",
              style: TextStyle(
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal),
            ),
            Text(
              "Dictionary",
              style: TextStyle(
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassicDictionaryPillButton extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  const ClassicDictionaryPillButton({
    super.key,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(32), bottomRight: Radius.circular(32)),
          color: !selected
              ? Theme.of(context).primaryColor
              : Theme.of(context).cardColor,
        ),
        child: Column(
          children: [
            Text(
              "Classic",
              style: TextStyle(
                  fontWeight: !selected ? FontWeight.bold : FontWeight.normal),
            ),
            Text(
              "Dictionary",
              style: TextStyle(
                  fontWeight: !selected ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}

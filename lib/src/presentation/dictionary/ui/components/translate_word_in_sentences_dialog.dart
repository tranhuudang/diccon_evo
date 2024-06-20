import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../data/bloc/dictionary_bloc.dart';

class TranslateWordInSentenceDialog extends StatefulWidget {
  const TranslateWordInSentenceDialog({super.key});

  @override
  State<TranslateWordInSentenceDialog> createState() => _TranslateWordInSentenceDialogState();
}
class _TranslateWordInSentenceDialogState extends State<TranslateWordInSentenceDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController wordController = TextEditingController();
  final TextEditingController sentenceController = TextEditingController();
  String translatedSentence = '';

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    final dictionaryBloc = context.read<ChatListBloc>();
    return AlertDialog(
     title:  Text('Translate word from sentences'.i18n, style: context.theme.textTheme.titleMedium,),
      content: Form(
        key: _formKey,
        child: SizedBox(
          height: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: wordController,
                validator: validateInput,
                decoration: InputDecoration(
                  labelText: 'Enter word to translate'.i18n,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)), // border for textfield
                ),
              ),
              20.height,
              TextFormField(
                controller: sentenceController,
                validator: validateInput,
                decoration: InputDecoration(
                  labelText: 'Enter sentence'.i18n,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                ),
              ),
              Expanded(
                child: Center(
                  child: FilledButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        dictionaryBloc.add(AddTranslateWordFromSentence(word: wordController.text, sentence: sentenceController.text));
                        context.pop();
                      }
                    },
                    child: Text('Translate'.i18n),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

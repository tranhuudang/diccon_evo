import 'package:diccon_evo/components/header.dart';
import 'package:flutter/material.dart';

class WritingView extends StatefulWidget {
  @override
  _WritingViewState createState() => _WritingViewState();
}

class _WritingViewState extends State<WritingView> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _typingScrollController = ScrollController();
  final ScrollController _resultScrollController = ScrollController();
  String _submittedText = '';

  @override
  void dispose() {
    _textEditingController.dispose();
    _typingScrollController.dispose();
    _resultScrollController.dispose();
    super.dispose();
  }

  void _submitText() {
    setState(() {
      _submittedText = _textEditingController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: "Writing assistant",
        icon: Icons.draw,
      ),
      body: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                  "Compose your sentences, and Diccon will aid you in rectifying any spelling or grammar errors."),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    //color: Colors.red,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black12)),
                child: SingleChildScrollView(
                  controller: _typingScrollController,
                  child: TextField(
                    controller: _textEditingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Enter a long paragraph...',
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _submitText,
            child: const Text('Submit'),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    //color: Colors.red,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black12)),
                child: SingleChildScrollView(
                  controller: _resultScrollController,
                  child: SelectableText(
                    _submittedText,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

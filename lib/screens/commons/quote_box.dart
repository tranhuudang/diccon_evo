import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QuoteBox extends StatefulWidget {
  const QuoteBox({super.key});

  @override
  State<QuoteBox> createState() => _QuoteBoxState();
}

class _QuoteBoxState extends State<QuoteBox> {
  final streamController = StreamController<String>();

  void _getAndUpdateQuote() async {
    var quote = await _quoteFetch();
    streamController.sink.add(quote);
  }

  Future<String> _quoteFetch() async {
    String defaultQuote =
        "Nourish your mind, even offline: Where words illuminate without the web.";
    try {
      var response =
          await http.get(Uri.parse("https://api.adviceslip.com/advice"));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        // Sample data response: {"slip": { "id": 173, "advice": "Always bet on black."}}
        if (kDebugMode) {
          print(jsonData["slip"]["advice"]);
        }
        return jsonData["slip"]["advice"];
      }
      return defaultQuote;
    } catch (e) {
      if (kDebugMode) {
        print("Error trying to get quote: $e");
      }
      return defaultQuote;
    }
  }

  @override
  void initState() {
    _getAndUpdateQuote();
    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 68),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(16)),
                        child: Text("From the universe".i18n))),
                StreamBuilder(
                    stream: streamController.stream,
                    builder: (context, snapshot) {
                      return Text(snapshot.data ?? "");
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

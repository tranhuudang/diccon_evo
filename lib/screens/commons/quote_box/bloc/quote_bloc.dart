import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  QuoteBloc() : super(QuoteInitialState()) {
    on<QuoteInitialFetchEvent>(_quoteInitialFetchEvent);
  }

  FutureOr<void> _quoteInitialFetchEvent(
      QuoteInitialFetchEvent event, Emitter<QuoteState> emit) async {
    try {
      var response =
          await http.get(Uri.parse("https://api.adviceslip.com/advice"));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        // Sample data response: {"slip": { "id": 173, "advice": "Always bet on black."}}
        if (kDebugMode) {
          print(jsonData["slip"]["advice"]);
        }
        String quote = jsonData["slip"]["advice"];
        emit(QuoteLoadedState(quote: quote));
      }
    } catch (e) {
      emit(QuoteErrorState());
    }
  }
}

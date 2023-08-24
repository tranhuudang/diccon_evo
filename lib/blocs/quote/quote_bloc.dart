import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http ;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState>{
  QuoteBloc() : super(QuoteInitialState()){
    on<QuoteInitialFetchEvent>(_quoteInitialFetchEvent);
  }

  FutureOr<void> _quoteInitialFetchEvent(QuoteInitialFetchEvent event, Emitter<QuoteState> emit) async{
    var response = await http.get(Uri.parse("https://api.adviceslip.com/advice"));
    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);
      // Sample data response: {"slip": { "id": 173, "advice": "Always bet on black."}}
      print(jsonData["slip"]["advice"]);
      String quote = jsonData["slip"]["advice"];
      emit(QuoteFetchingSuccessfulState(quote: quote));
    }
  }
}
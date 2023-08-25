part of 'quote_bloc.dart';


@immutable
abstract class QuoteState{}
abstract class QuoteActionState extends QuoteState{}


class QuoteInitialState extends QuoteState{}


class QuoteLoadedState extends QuoteState{
   final String quote;

   QuoteLoadedState({required this.quote});
}

class QuoteErrorState extends QuoteState{

}
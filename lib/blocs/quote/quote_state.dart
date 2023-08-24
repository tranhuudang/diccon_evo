part of 'quote_bloc.dart';


@immutable
abstract class QuoteState{}
abstract class QuoteActionState extends QuoteState{}


class QuoteInitialState extends QuoteState{}


class QuoteFetchingSuccessfulState extends QuoteState{
   final String quote;

  QuoteFetchingSuccessfulState({required this.quote});
}
import 'package:diccon_evo/blocs/quote/quote_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeBox extends StatelessWidget {
  const WelcomeBox({super.key});

  @override
  Widget build(BuildContext context) {
    var quoteBloc = context.read<QuoteBloc>();
    quoteBloc.add(QuoteInitialFetchEvent());
    return BlocConsumer<QuoteBloc, QuoteState>(
      listenWhen: (previous, current) => current is QuoteActionState,
      buildWhen: (previous, current) => current is! QuoteActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case QuoteLoadedState:
            final successfulState = state as QuoteLoadedState;
            return QuoteContent(text: successfulState.quote);
          case QuoteErrorState:
            return const QuoteContent(text: "Nourish your mind, even offline: Where words illuminate without the web.",);
          default:
            return const QuoteContent();
        }
      },
    );
  }
}

class QuoteContent extends StatelessWidget {
  const QuoteContent({
    super.key,
    this.text,
  });

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, left: 16, bottom: 16, right: 16),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          constraints: const BoxConstraints(
            minHeight: 120,
            maxWidth: 600,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).primaryColor,
                    blurRadius: 1,
                    blurStyle: BlurStyle.outer,
                    offset: const Offset(6, 9)),
                BoxShadow(
                    color: Theme.of(context).primaryColor,
                    blurRadius: 1,
                    blurStyle: BlurStyle.outer,
                    offset: const Offset(-2, -9)),
                BoxShadow(
                    color: Theme.of(context).primaryColor,
                    blurRadius: 1,
                    blurStyle: BlurStyle.outer,
                    offset: const Offset(-8, 1)),

                //BoxShadow(color: Theme.of(context).scaffoldBackgroundColor,),
              ],
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2.0,
              ),
              //color: Colors.amberAccent,
              borderRadius: const BorderRadius.all(Radius.circular(16))),
          child: Center(
            child: Text(text ?? "Unlock the Doors to Words: Explore, Discover, and Learn"),
          ),
        ),
      ),
    );
  }
}


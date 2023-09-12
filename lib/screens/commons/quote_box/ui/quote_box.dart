import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quote_bloc.dart';

class QuoteBox extends StatelessWidget {
  const QuoteBox({super.key});

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
            return const QuoteContent(
              text:
                  "Nourish your mind, even offline: Where words illuminate without the web.",
            );
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
    return Container(
      padding: const EdgeInsets.only(left: 16,right: 16, top: 16, bottom: 32),
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
                        child:  Text("From the universe".i18n))),
                Container(
                  //width: 200,
                  child: Text(text ??
                      "Unlock the Doors to Words: Explore, Discover, and Learn"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

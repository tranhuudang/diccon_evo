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
          case QuoteFetchingSuccessfulState:
            final successfulState = state as QuoteFetchingSuccessfulState;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  constraints: const BoxConstraints(
                    minHeight: 100,
                    maxWidth: 600,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                      //color: Colors.amberAccent,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16))),
                  child: Center(child: Text(successfulState.quote),),
                ),
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

// return Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Expanded(
// child: Padding(
// padding: const EdgeInsets.all(16.0),
// child: Container(
// height: 170,
// decoration: BoxDecoration(
// border: Border.all(
// color: Theme.of(context).primaryColor,
// width: 2.0,
// ),
// color: Colors.amberAccent,
// borderRadius: const BorderRadius.all(Radius.circular(16))),
// child: Text("hello"),
// ),
// ),
// ),
// ],
// );

import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter/material.dart';

class WordPronunciation extends StatelessWidget {
  const WordPronunciation({
    super.key,
    required this.pronunciation, this.color,
  });

  final String? pronunciation;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return
      pronunciation != null ?
      Text( "/$pronunciation/" == '//' ? '': "/$pronunciation/",
      style: TextStyle(
        color: color?? context.theme.colorScheme.onSurface,
       // fontStyle: FontStyle.italic,
      ),
    ) :const SizedBox.shrink();
  }
}
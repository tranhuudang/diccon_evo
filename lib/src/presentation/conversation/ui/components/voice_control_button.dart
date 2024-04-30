import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation.dart';

class VoiceStopButton extends StatelessWidget {
  const VoiceStopButton({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    final voiceBloc = context.read<VoiceBloc>();
    return SizedBox(
      height: 158,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon:  const Icon(
              Icons.stop_circle,
              size: 68,
              color: Color(0xffd80000),
            ),
            onPressed: () => voiceBloc.add(StopRecordEvent()),
          ),
          16.height,
          Text(
            title.toUpperCase(),
            style: context.theme.textTheme.titleLarge,
          ),

        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:diccon_evo/common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:speech_to_text/speech_to_text.dart';
class VoiceListeningBottomSheet extends StatefulWidget {
  final Function(String) onSubmit;
  const VoiceListeningBottomSheet({super.key, required this.onSubmit});

  @override
  State<VoiceListeningBottomSheet> createState() =>
      _VoiceListeningBottomSheetState();
}

class _VoiceListeningBottomSheetState extends State<VoiceListeningBottomSheet> {
  final _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = true;
  final _listeningResultController = StreamController<String>();
  void startListening() async {
    if (_speechEnabled) {
      await _speechToText.listen(
          localeId: 'en',
          listenMode: ListenMode.dictation,
          onResult: onSpeechResult);
    } else {
      if (kDebugMode) {
        print("Not able to listen");
      }
    }
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    _listeningResultController.add(result.recognizedWords);
  }

  void onListeningStatus(String currentStatus) {
    if (currentStatus == "notListening") {
      setState(() {
        _isListening = false;
      });
    }
    if (currentStatus == "done") {
      setState(() {
        _isListening = false;
      });
    }
  }

  /// This has to happen only once per app
  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize(
      onStatus: onListeningStatus,
    );
    if (_speechEnabled) {
      startListening();
    }
  }

  void _stopListening() async {
    await _speechToText.stop();
  }

  @override
  void initState() {
    super.initState();

    initSpeech();
  }

  @override
  void dispose() {
    _listeningResultController.close();
    _speechToText.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _listeningResultController.stream,
      initialData: '',
      builder: (context, listeningResult) {
        return SizedBox(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 80,
                ),
                child: _isListening == true
                    ? LoadingIndicator(
                  pause: false,
                  indicatorType: Indicator.lineScalePulseOut,
                  colors: [
                    context.theme.colorScheme.primary.withOpacity(.5),
                    context.theme.colorScheme.primary.withOpacity(.9),
                    context.theme.colorScheme.primary.withOpacity(.4),
                    context.theme.colorScheme.primary.withOpacity(.8),
                    context.theme.colorScheme.primary.withOpacity(.2),
                  ],
                )
                    : LoadingIndicator(
                  pause: true,
                  indicatorType: Indicator.lineScalePulseOut,
                  colors: [
                    context.theme.colorScheme.primary.withOpacity(.5),
                    context.theme.colorScheme.primary.withOpacity(.9),
                    context.theme.colorScheme.primary.withOpacity(.4),
                    context.theme.colorScheme.primary.withOpacity(.8),
                    context.theme.colorScheme.primary.withOpacity(.2),
                  ],
                ),
              ),
              listeningResult.data!.isEmpty
                  ? Text(_isListening
                  ? "Listening to you...".i18n
                  : "Tap to the mic to start again".i18n)
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  listeningResult.data!,
                  style: listeningResult.data!.length < 40
                      ? context.theme.textTheme.headlineSmall
                      : listeningResult.data!.length < 80
                      ? context.theme.textTheme.titleMedium
                      : context.theme.textTheme.titleSmall,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: context.theme.colorScheme.primary,
                    ),
                    child: listeningResult.data!.isNotEmpty
                        ? IconButton(
                      onPressed: () {
                        _stopListening();
                        context.pop();
                        widget.onSubmit(listeningResult.data!);
                      },
                      icon: Icon(
                        Icons.send_rounded,
                        color: context.theme.colorScheme.onPrimary,
                        size: 30,
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: context.theme.colorScheme.primary,
                      ),
                      child: IconButton(
                        onPressed: () {
                          startListening();
                        },
                        icon: const Icon(Icons.mic_none),
                        color: context.theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:avatar_glow/avatar_glow.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation.dart';
import '../components/voice_control_button.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  @override
  Widget build(BuildContext context) {
    final voiceBloc = context.read<VoiceBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Chat'),
      ),
      body: BlocConsumer<VoiceBloc, VoiceState>(
        buildWhen: (previous, current) => current is! VoiceActionState,
        listenWhen: (previous, current) => current is VoiceActionState,
        listener: (context, state) {
          if (state is UserNotAllowRecordState) {
            context.showAlertDialogWithoutAction(
              title: 'Permission Required',
              content:
                  'You must allow application to get access to microphone to able to record your voice',
            );
          }
          if (state is NoInternetState) {
            context.showAlertDialogWithoutAction(
              title: 'No Internet',
              content:
                  'You not connected to the internet or the application having trouble while trying to connect to the network.',
            );
          }
        },
        builder: (context, state) {
          switch (state) {
            case VoiceBotThinkingState _:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 300,
                        child: AvatarGlow(
                          glowRadiusFactor: 1.4,
                          repeat: true,
                          startDelay: const Duration(milliseconds: 1000),
                          glowColor: context.theme.colorScheme.primary,
                          glowShape: BoxShape.circle,
                          animate: true,
                          curve: Curves.fastOutSlowIn,
                          child: Material(
                            elevation: 0.0,
                            shape: const CircleBorder(),
                            color: context.theme.colorScheme.secondaryContainer.withOpacity(.5),
                            child: Container(
                              height: 86,
                              width: 86,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const VoiceStopButton(
                      title: 'Bot is thinking',
                    ),
                  ],
                ),
              );
            case VoiceBotSpeakingState _:
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 300,
                        width: 200,
                        child: WaveAuto(inputValue: 100),
                      ),
                    ),
                    VoiceStopButton(
                      title: 'Bot is speaking',
                    ),
                  ],
                ),
              );
            case VoiceUserSpeakingState _:
              return Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 300,
                            width: 200,
                            child: Wave(
                              inputValue: state.decibelValue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VoiceStopButton(
                      title: 'Listening from you',
                    ),
                  ],
                ),
              );
            case VoiceInitState _:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.mic_none,
                        size: 90,
                      ),
                      onPressed: () => voiceBloc.add(StartRecordEvent()),
                    ),
                    16.height,
                    Text(
                      'Touch to start'.toUpperCase(),
                      style: context.theme.textTheme.titleLarge,
                    ),
                  ],
                ),
              );
          }
          return Container();
        },
      ),
    );
  }
}
import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wave_divider/wave_divider.dart';
import '../../../presentation.dart';
import 'dart:io';

class TextRecognizerView extends StatelessWidget {
  const TextRecognizerView({super.key});

  @override
  Widget build(BuildContext context) {
    final textRecognizerBloc = context.read<TextRecognizerBloc>();
    final dictionaryChatListBloc = context.read<ChatListBloc>();
    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<TextRecognizerBloc, TextRecognizerState>(
            builder: (context, state) {
          return ListView(
              padding: const EdgeInsets.only(top: 70),
              shrinkWrap: true,
              children: [
                /// Head and sub title
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: HeadSentence(listText: ['Capture your text']),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 18),
                    child: Text("SubSentenceInImageRecognizer".i18n)),

                /// Image preview
                state.params.filePath.isNotEmpty
                    ? SizedBox(
                        height: 400,
                        width: 400,
                        child: Image.file(File(state.params.filePath)),
                      )
                    : ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            context.theme.colorScheme.primary, BlendMode.srcIn),
                        child: Image(
                          image: AssetImage(
                              LocalDirectory.textRecognizerIllustration),
                          height: 200,
                        ),
                      ),

                /// Take picture button and gallery
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => textRecognizerBloc.add(
                            AddImageToRecognizer(
                                imageSource: ImageSource.camera)),
                        icon: const Icon(Icons.camera_alt_outlined),
                        label: Text('Take a picture'.i18n),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => textRecognizerBloc.add(
                            AddImageToRecognizer(
                                imageSource: ImageSource.gallery)),
                        icon: const Icon(Icons.collections_outlined),
                        label: Text('Gallery'.i18n),
                      ),
                    ],
                  ),
                ),
                if (state is TextRecognizerUpdatedState)

                  /// Text Recognized Result
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Section(title: 'Recognized Text'.i18n, children: [
                        /// RAW result
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText(state.params.rawContent),
                            const WaveDivider(
                              thickness: .3,
                            ),
                            if (state.params.isGoogleTranslating)
                              const LinearProgressIndicator(),
                            SelectableText(
                                state.params.googleTranslatedContent),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: FilledButton.icon(
                                      onPressed: () {
                                        context.pushNamed(RouterConstants.dictionary);
                                        dictionaryChatListBloc.add(
                                            AddTranslationEvent(
                                                providedWord:
                                                    state.params.rawContent));
                                      },
                                      icon: const Icon(Icons.translate),
                                      label: Text("Send to dictionary".i18n)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: OutlinedButton(
                                      onPressed: () => textRecognizerBloc
                                          .add(TranslateFromGoogle()),
                                      child: Text("Translate now".i18n)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
              ]);
        }));
  }
}

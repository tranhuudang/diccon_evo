import '../../../../domain/domain.dart';
import '../../../presentation.dart';

class VietnameseToEnglishClassicBubble extends StatelessWidget {
  const VietnameseToEnglishClassicBubble({
    super.key,
    required this.word,
    this.onWordTap,
  });

  final Word word;
  final Function(String)? onWordTap;

  @override
  Widget build(BuildContext context) {
    return ClassicBubble(
      word: word,
      onWordTap: onWordTap ?? (value) {},
      language: 'vi-VI',
    );
  }
}

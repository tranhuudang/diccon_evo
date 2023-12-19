import '../../../../domain/domain.dart';
import '../../../presentation.dart';

class EnglishToVietnameseClassicBubble extends StatelessWidget {
  const EnglishToVietnameseClassicBubble({
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
      language: 'en-US',
    );
  }
}

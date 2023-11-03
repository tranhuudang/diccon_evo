import 'package:diccon_evo/src/common/common.dart';
part 'question_answer.freezed.dart';
@freezed
class QuestionAnswer with _$QuestionAnswer{
  const factory QuestionAnswer({
    required String question,
    required StringBuffer answer,
  }) = _QuestionAnswer;
}
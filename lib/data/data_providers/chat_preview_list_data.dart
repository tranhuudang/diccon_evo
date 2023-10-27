import '../models/chat_preview.dart';
import '../enums/dictionary_response_type.dart';

List<ChatPreview> listChatPreviewContent = [
  ChatPreview(
    responseType: DictionaryResponseType.shortWithOutPronunciation,
    content: 'Từ "happy" có nghĩa là hạnh phúc hoặc vui vẻ.',
  ),
  ChatPreview(
    responseType: DictionaryResponseType.short,
    content: 'Phiên âm của từ "happy" là /ˈhæpi/.\n\nTừ "happy" có nghĩa là cảm thấy vui vẻ, hạnh phúc, hài lòng hoặc sung sướng.',

  ),
  ChatPreview(
    responseType: DictionaryResponseType.normal,
    content:
        'Phiên âm của từ "happy" trong tiếng Anh là /ˈhæpi/.\nNghĩa của từ "happy" là trạng thái cảm xúc tích cực, hạnh phúc, vui vẻ hoặc hài lòng về một điều gì đó.\nVí dụ:\n- She is always happy when she spends time with her family.\n(Cô ấy luôn luôn hạnh phúc khi cô ấy dành thời gian cùng gia đình.)\n- Winning the lottery made him incredibly happy.\n(Việc trúng số đã làm cho anh ấy cực kỳ hạnh phúc.)")',
  ),
  ChatPreview(
    responseType: DictionaryResponseType.normalWithOutExample,
    content:
        'Phiên âm của từ "happy" là [ˈhæpi].\n\nTừ "happy" là một từ tiếng Anh có nghĩa là "vui vẻ" hoặc "hạnh phúc". Nó được sử dụng để mô tả trạng thái tinh thần tích cực khi bạn cảm thấy thoải mái, hài lòng, và đầy niềm vui. Nếu bạn nói bạn đang cảm thấy "happy," có nghĩa bạn đang trải qua một tình trạng tâm hồn tích cực và hạnh phúc. Từ này thường được sử dụng để diễn đạt tình trạng tinh thần tích cực và làm cho người ta cảm thấy thoải mái và vui vẻ.',
  ),
  ChatPreview(
    responseType: DictionaryResponseType.normalWithOutPronunciation,
    content:
        'Từ "happy" có nghĩa là hạnh phúc, vui vẻ, hứng thú hoặc đầy hạnh phúc và hài lòng. Dưới đây là một số ví dụ:\nVí dụ: Spending time with loved ones makes me happy.\nDịch: Dành thời gian cùng người thân yêu làm tôi hạnh phúc.\nVí dụ: The children were happy to play in the park all day.\nDịch: Các em bé rất vui khi chơi trong công viên cả ngày.\nVí dụ: Winning the competition made him incredibly happy.\nDịch: Chiến thắng trong cuộc thi khiến anh ấy vô cùng hạnh phúc.',
  ),
];

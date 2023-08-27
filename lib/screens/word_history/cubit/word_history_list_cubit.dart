import 'package:diccon_evo/helpers/history_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/properties.dart';
import '../../../helpers/file_handler.dart';
import '../../../models/word.dart';

class HistoryListCubit extends Cubit<List<Word>> {
  HistoryListCubit() : super([]);

  List<Word> words = [];

  void loadHistory() async {
    words = await HistoryManager.readWordHistory();
    emit(words);
  }

  void sortAlphabet() {
    var sorted = words;
    sorted.sort((a, b) => a.word.compareTo(b.word));
    emit(sorted);
  }

  void sortReverse() {
    var sorted = words.reversed.toList();
    emit(sorted);
  }

  void clearHistory() {
    FileHandler(Properties.wordHistoryFileName).deleteFile();
    words = List.empty();
    emit(words);
  }
}
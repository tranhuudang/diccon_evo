import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/properties_constants.dart';
import '../../../data/handlers/file_handler.dart';
import '../../../data/data_providers/history_manager.dart';

class HistoryListCubit extends Cubit<List<String>> {
  HistoryListCubit() : super([]);

  List<String> words = [];

  void loadHistory() async {
    words = await HistoryManager.readWordHistory();
    emit(words);
  }

  void sortAlphabet() {
    var sorted = words;
    sorted.sort((a, b) => a.compareTo(b));
    emit(sorted);
  }

  void sortReverse() {
    var sorted = words.reversed.toList();
    emit(sorted);
  }

  void clearHistory() {
    FileHandler(PropertiesConstants.wordHistoryFileName).deleteOnUserData();
    words = List.empty();
    emit(words);
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/properties_constants.dart';
import '../../../data/handlers/file_handler.dart';
import '../../../data/data_providers/history_manager.dart';

class HistoryListCubit extends Cubit<List<String>> {
  HistoryListCubit() : super([]);

  List<String> _words = [];

  void loadHistory() async {
    _words = await HistoryManager.readWordHistory();
    emit(_words);
  }

  void sortAlphabet() {
    var sorted = _words;
    sorted.sort((a, b) => a.compareTo(b));
    emit(sorted);
  }

  void sortReverse() {
    var sorted = _words.reversed.toList();
    emit(sorted);
  }

  void clearHistory() {
    FileHandler(PropertiesConstants.wordHistoryFileName).deleteOnUserData();
    _words = List.empty();
    emit(_words);
  }
}
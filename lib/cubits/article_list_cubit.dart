import '../global.dart';
import '../models/article.dart';
import 'package:bloc/bloc.dart';

class ArticleListCubit extends Cubit<List<Article>> {
  ArticleListCubit() : super([]);

  Future<void> loadUp() async {
    Global.defaultArticleList = await Global.dataService.getDefaultStories();
    emit(Global.defaultArticleList);

    var onlineStories = await Global.dataService.getOnlineStoryList();

    for (var story in onlineStories) {
      if (story.title != "") {
        Global.defaultArticleList.add(story);
      }
    }
    Global.defaultArticleList.shuffle();
    emit(Global.defaultArticleList);
  }

  void sortElementary() {
    var elementaryOnly = Global.defaultArticleList
        .where((element) => element.level == Level.elementary)
        .toList();
    emit(elementaryOnly);
  }

  void sortIntermediate() {
    var intermediateOnly = Global.defaultArticleList
        .where((element) => element.level == Level.intermediate)
        .toList();
    emit(intermediateOnly);
  }

  void sortAdvanced() {
    var advancedOnly = Global.defaultArticleList
        .where((element) => element.level == Level.advanced)
        .toList();
    emit(advancedOnly);
  }

  void getAll() {
    var all = Global.defaultArticleList;
    emit(all);
  }
}
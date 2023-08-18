import '../../properties.dart';
import '../../models/article.dart';
import 'package:bloc/bloc.dart';

class ArticleListCubit extends Cubit<List<Article>> {
  ArticleListCubit() : super([]);

  Future<void> loadUp() async {
    Properties.defaultArticleList = await Properties.dataService.getDefaultStories();
    //emit(Global.defaultArticleList);

    var onlineStories = await Properties.dataService.getOnlineStoryList();

    for (var story in onlineStories) {
      if (story.title != "") {
        Properties.defaultArticleList.add(story);
      }
    }
    Properties.defaultArticleList.shuffle();
    emit(Properties.defaultArticleList);
  }

  void sortElementary() {
    var elementaryOnly = Properties.defaultArticleList
        .where((element) => element.level == Level.elementary)
        .toList();
    emit(elementaryOnly);
  }

  void sortIntermediate() {
    var intermediateOnly = Properties.defaultArticleList
        .where((element) => element.level == Level.intermediate)
        .toList();
    emit(intermediateOnly);
  }

  void sortAdvanced() {
    var advancedOnly = Properties.defaultArticleList
        .where((element) => element.level == Level.advanced)
        .toList();
    emit(advancedOnly);
  }

  void getAll() {
    var all = Properties.defaultArticleList;
    emit(all);
  }
}
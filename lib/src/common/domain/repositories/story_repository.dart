import 'package:diccon_evo/src/common/common.dart';


abstract class StoryRepository {
  Future<List<Story>> getDefaultStories();
  Future<List<Story>> getOnlineStoryList();
  Future<List<Story>> readStoryHistory();
  Future<List<Story>> readStoryBookmark();
  Future<bool> saveReadStoryToHistory(Story story);
  Future<bool> saveReadStoryToBookmark(Story story);
  Future<bool> removeAStoryInBookmark(Story story);
  Future<bool> deleteAllStoryHistory();
  Future<bool> deleteAllStoryBookmark();
}

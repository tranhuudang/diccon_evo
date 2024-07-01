import '../domain.dart';


abstract class StoryRepository {
  Future<List<Story>> getDefaultStories();
  Future<List<Story>> getOnlineStoryList();
  Future<List<Story>> getStoryHistory();
  Future<List<Story>> getStoryBookmark();
  Future<bool> saveReadStoryToBookmark(Story story);
  Future<bool> removeAStoryInBookmark(Story story);
}

import 'package:diccon_evo/interfaces/data.dart';

import '../models/article.dart';
import '../models/video.dart';
import '../models/word.dart';

class DataService {
  final Data data;

  DataService(this.data);
  Future<List<Word>> getWordList() async {
    return await data.getWordList();
  }

  Future<List<Article>> getOnlineStoryList() async {
    return await data.getOnlineStoryList();
  }

  Future<List<Article>> getDefaultStories() async {
    return await data.getDefaultStories();
  }

  Future<List<Video>> getDefaultVideos() async {
    return await data.getDefaultVideos();
  }

  Future<List<Video>> getOnlineVideosList() async {
    return await data.getOnlineVideosList();
  }
}

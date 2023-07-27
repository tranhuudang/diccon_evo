import '../global.dart';
import '../models/article.dart';
import 'package:bloc/bloc.dart';

import '../models/video.dart';

class VideoListCubit extends Cubit<List<Video>> {
  VideoListCubit() : super([]);

  Future<void> loadUp() async {
    Global.defaultVideoList = await Global.dataService.getDefaultVideos();
    //emit(Global.defaultVideoList);

   var onlineVideos = await Global.dataService.getOnlineVideosList();

    for (var video in onlineVideos) {
      print("getting videos");
      print(video.title);
      if (video.title != "") {
        Global.defaultVideoList.add(video);
      }
    }
    Global.defaultVideoList.shuffle();
    emit(Global.defaultVideoList);
  }

  void sortElementary() {
    var elementaryOnly = Global.defaultVideoList
        .where((element) => element.level == Level.elementary)
        .toList();
    emit(elementaryOnly);
  }

  void sortIntermediate() {
    var intermediateOnly = Global.defaultVideoList
        .where((element) => element.level == Level.intermediate)
        .toList();
    emit(intermediateOnly);
  }

  void sortAdvanced() {
    var advancedOnly = Global.defaultVideoList
        .where((element) => element.level == Level.advanced)
        .toList();
    emit(advancedOnly);
  }

  void getAll() {
    var all = Global.defaultVideoList;
    emit(all);
  }
}
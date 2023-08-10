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

  void getFootnote() {
    var elementaryOnly = Global.defaultVideoList
        .where((element) => element.content !="")
        .toList();
    emit(elementaryOnly);
  }

  void getNonFootnote() {
    var intermediateOnly = Global.defaultVideoList
        .where((element) => element.content == "")
        .toList();
    emit(intermediateOnly);
  }


  void getAll() {
    var all = Global.defaultVideoList;
    emit(all);
  }
}
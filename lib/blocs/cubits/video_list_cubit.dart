import 'package:flutter/foundation.dart';
import '../../properties.dart';
import 'package:bloc/bloc.dart';

import '../../models/video.dart';

class VideoListCubit extends Cubit<List<Video>> {
  VideoListCubit() : super([]);

  Future<void> loadUp() async {
    Properties.defaultVideoList = await Properties.dataService.getDefaultVideos();
    //emit(Global.defaultVideoList);

   var onlineVideos = await Properties.dataService.getOnlineVideosList();

    for (var video in onlineVideos) {
      if (kDebugMode) {
        print("getting videos");
      }
      if (kDebugMode) {
        print(video.title);
      }
      if (video.title != "") {
        Properties.defaultVideoList.add(video);
      }
    }
    Properties.defaultVideoList.shuffle();
    emit(Properties.defaultVideoList);
  }

  void getFootnote() {
    var elementaryOnly = Properties.defaultVideoList
        .where((element) => element.content !="")
        .toList();
    emit(elementaryOnly);
  }

  void getNonFootnote() {
    var intermediateOnly = Properties.defaultVideoList
        .where((element) => element.content == "")
        .toList();
    emit(intermediateOnly);
  }


  void getAll() {
    var all = Properties.defaultVideoList;
    emit(all);
  }
}
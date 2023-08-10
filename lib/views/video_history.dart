import 'package:diccon_evo/views/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/video_history_list_cubit.dart';
import '../models/video.dart';
import 'components/video_tile.dart';

class VideoListHistoryView extends StatelessWidget {
  const VideoListHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final videoHistoryListCubit = context.read<VideoHistoryListCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: Header(
          title: 'History',
          iconButton: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
                onPressed: () => videoHistoryListCubit.sortAlphabet(),
                icon: const Icon(Icons.sort_by_alpha)),

          ],
        ),
        body: BlocBuilder<VideoHistoryListCubit, List<Video>>(
          builder: (context, state) {
            if (state.isEmpty) {
              videoHistoryListCubit.loadArticleHistory();
              return const Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(
                            Icons.broken_image,
                            color: Colors.black45,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "History is empty",
                            style: TextStyle(color: Colors.black45, fontSize: 18),
                          )
                        ]),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final maxWidth = constraints.maxWidth;
                        int crossAxisCount;
                        // Adjust the number of columns based on the available width
                        if (maxWidth >= 1600) {
                          crossAxisCount = 5;
                        } else if (maxWidth >= 1300) {
                          crossAxisCount = 4;
                        } else if (maxWidth >= 1000) {
                          crossAxisCount = 3;
                        } else if (maxWidth >= 700) {
                          crossAxisCount = 2;
                        } else {
                          crossAxisCount = 1;
                        }

                        return GridView.builder(
                          itemCount: state.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            mainAxisExtent: 150,
                            childAspectRatio:
                                7 / 3, // Adjust the aspect ratio as needed
                          ),
                          itemBuilder: (context, index) {
                            return VideoTile(video: state[index]);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}


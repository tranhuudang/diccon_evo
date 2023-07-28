import 'package:diccon_evo/helpers/file_handler.dart';
import 'package:diccon_evo/models/video.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../global.dart';
import '../../models/article.dart';
import '../article_page.dart';
import '../video_page.dart';
import 'level_icon.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  const VideoTile({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: InkWell(
        onTap: () {
          // Handle tap on article
          // For example, navigate to article details page
          FileHandler.saveVideoToHistory(video);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoPageView(
                        video: video,
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          const LinearProgressIndicator(
                        backgroundColor: Colors.black45,
                        color: Colors.black54,
                      ),
                      imageUrl: video.videoThumbnail,
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.cover,
                      errorWidget:
                          (context, String exception, dynamic stackTrace) {
                        return Container(
                          width: 100.0,
                          height: 100.0,
                          color: Colors
                              .grey, // Display a placeholder color or image
                          child: const Center(
                            child: Text('No Image'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            video.title,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

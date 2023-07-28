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
                Stack(
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
                    Container(
                      height: 104.0,
                      width: 104.0,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(16),

                      ),

                      child: const Icon(Icons.play_circle_outline, size: 40, color: Colors.white70,),)
                  ],
                ),
                const SizedBox(width: 8.0),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.title,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              SourceTag(video: video),
                              const SizedBox(width: 3,),
                              video.content!= "" ? const FootNoteTag() : const SizedBox.shrink(),
                            ],
                          ),
                        )
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

class SourceTag extends StatelessWidget {
  const SourceTag({
    super.key,
    required this.video,
  });

  final Video video;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          video.source ?? "Unknown",
          style: const TextStyle(
              color: Colors.white, fontSize: 11),
        ),
      ),
    );
  }
}

class FootNoteTag extends StatelessWidget {
  const FootNoteTag({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.orange),
      child: const Align(
        alignment: Alignment.center,
        child: Text(
          "footnote",
          style: TextStyle(color: Colors.white, fontSize: 11),
        ),
      ),
    );
  }
}

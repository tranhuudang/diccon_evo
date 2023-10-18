import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../data/models/story.dart';
import '../../../../data/models/level.dart';
import 'level_icon.dart';
import '../../blocs/story_history_list_bloc.dart';

class ReadingTile extends StatefulWidget {
  final String? tag;
  final Story story;
  final VoidCallback onTap;
  const ReadingTile({
    super.key,
    required this.story, this.tag, required this.onTap,

  });

  @override
  State<ReadingTile> createState() => _ReadingTileState();
}

class _ReadingTileState extends State<ReadingTile> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final storyHistoryBloc = StoryHistoryBloc();
    TextTheme textTheme = Theme.of(context).primaryTextTheme;
    return GridTile(
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: (){
          storyHistoryBloc.add(StoryHistoryAdd(story: widget.story));
          widget.onTap();
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(32),
          ),
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: widget.tag ?? widget.story.title,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: CachedNetworkImage(
                      // placeholder: (context, url) =>
                      //     const LinearProgressIndicator(
                      //   backgroundColor: Colors.black45,
                      //   color: Colors.black54,
                      // ),
                      imageUrl: widget.story.imageUrl ?? '',
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
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.story.title,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          widget.story.shortDescription,
                          textAlign: TextAlign.justify,
                          style: textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(.5)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      LevelIcon(
                        level: widget.story.level ?? Level.intermediate.toLevelNameString(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

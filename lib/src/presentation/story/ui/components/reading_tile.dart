import 'package:cached_network_image/cached_network_image.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/domain/domain.dart';
import '../../bloc/story_history_bloc.dart';

class ReadingTile extends StatelessWidget {
  final String? tag;
  final Story story;
  final VoidCallback onTap;
  const ReadingTile({
    super.key,
    required this.story,
    this.tag,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final storyHistoryBloc = StoryHistoryBloc();
    TextTheme textTheme = context.theme.primaryTextTheme;
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: () {
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
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
                    imageUrl: story.imageUrl ?? '',
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
              8.width,
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        story.title,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: textTheme.titleMedium?.copyWith(
                            color: context.theme.colorScheme.onSurfaceVariant),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          story.shortDescription,
                          textAlign: TextAlign.start,
                          style: textTheme.bodySmall?.copyWith(
                              color: context.theme.colorScheme.onSurfaceVariant
                                  .withOpacity(.5)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Tag(
                            title: story.level ??
                                Level.intermediate.toLevelNameString(),
                          ),
                          4.width,
                          if (story.content.length <
                              NumberConstants.maximumLengthForTextToSpeech)
                            Tag(
                              title: 'Audio',
                              color: context.theme.colorScheme.tertiary,
                              textColor: context.theme.colorScheme.onTertiary,
                            )
                        ],
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
}

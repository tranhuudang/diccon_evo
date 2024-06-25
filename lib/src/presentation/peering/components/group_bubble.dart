import 'package:cached_network_image/cached_network_image.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/peering/components/video_webview.dart';
import 'package:diccon_evo/src/presentation/shared/ui/utils/border_radius_missing.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:http/http.dart' as http;


class GroupUserBubble extends StatefulWidget {
  final String text;
  final String senderId;
  final String senderName;
  final bool isFile;
  const GroupUserBubble({
    super.key,
    required this.text,
    required this.senderId,
    required this.senderName,
    required this.isFile,
  });

  @override
  State<GroupUserBubble> createState() => _GroupUserBubbleState();
}

class _GroupUserBubbleState extends State<GroupUserBubble> {
  late Future<MediaType> _mediaTypeFuture;

  @override
  void initState() {
    super.initState();
    _mediaTypeFuture = _checkIfMedia(widget.text);
  }

  Future<MediaType> _checkIfMedia(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      final contentType = response.headers['content-type'];
      if (contentType != null) {
        if (contentType.startsWith('image/')) {
          return MediaType.image;
        } else if (contentType.startsWith('video/')) {
          return MediaType.video;
        }
      }
    } catch (e) {
      // Handle exception
    }
    return MediaType.none;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.86,
              minWidth: MediaQuery.of(context).size.width * 0.30,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius:
                  BorderRadius.circular(8), // Replace BorderRadiusMissing
            ),
            child: widget.isFile
                ? FutureBuilder<MediaType>(
                    future: _mediaTypeFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          height: 10,
                          width: 50,
                          child: LinearProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        final mediaType = snapshot.data!;
                        if (mediaType == MediaType.image) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(imageUrl: widget.text),
                            ),
                          );
                        } else if (mediaType == MediaType.video) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton.icon(
                              icon: Icon(
                                Icons.play_circle,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        VideoWebView(url: widget.text),
                                  ),
                                );
                              },
                              label: Text(
                                'Watch Video',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // Implement download functionality
                              },
                              child: const Text('Download'),
                            ),
                          );
                        }
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Error loading file'),
                        );
                      }
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText(
                      widget.text,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

enum MediaType {
  image,
  video,
  none,
}



class GroupGuestBubble extends StatefulWidget {
  const GroupGuestBubble(
      {super.key,
      required this.onTap,
      required this.text,
      required this.senderId,
      required this.senderName,
      required this.isFile});
  final String text;
  final String senderId;
  final String senderName;
  final bool isFile;
  final VoidCallback? onTap;

  @override
  State<GroupGuestBubble> createState() => _GroupGuestBubbleState();
}

class _GroupGuestBubbleState extends State<GroupGuestBubble> {
  bool _isLoading = true;
  bool _isImage = false;
  bool _isVideo = false;
  Future<void> _checkIfMedia(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      final contentType = response.headers['content-type'];

      setState(() {
        if (contentType != null) {
          if (contentType.startsWith('image/')) {
            _isImage = true;
          } else if (contentType.startsWith('video/')) {
            _isVideo = true;
          }
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfMedia(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: InkWell(
          onTap: widget.onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 86.sw,
                  minWidth: 28.sw,
                ),
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadiusMissing.topLeft,
                ),
                child: widget.isFile
                    ? _isLoading
                        ? const SizedBox(
                            height: 10,
                            width: 50,
                            child: LinearProgressIndicator())
                        : _isImage
                            ? Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadiusMissing.topLeft,
                                    child: CachedNetworkImage(
                                        imageUrl: widget.text)),
                              )
                            : _isVideo
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton.icon(
                                      icon: Icon(
                                        Icons.play_circle,
                                        color:
                                            context.theme.colorScheme.onSurface,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VideoWebView(url: widget.text),
                                          ),
                                        );
                                      },
                                      label: Text(
                                        'Watch Video',
                                        style: context
                                            .theme.textTheme.labelLarge
                                            ?.copyWith(
                                                color: context.theme.colorScheme
                                                    .onSurface),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Implement download functionality
                                      },
                                      child: const Text('Download'),
                                    ),
                                  )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectableText(
                          widget.text,
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                              color: context.theme.colorScheme.onSurface),
                        ),
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

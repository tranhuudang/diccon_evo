import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class VideoWebView extends StatefulWidget {
  final String url;
  const VideoWebView({super.key, required this.url});

  @override
  State<VideoWebView> createState() => _VideoWebViewState();
}

class _VideoWebViewState extends State<VideoWebView> {
  late final WebViewController _controller;

  @override
  void initState(){
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Player')),
      body:  WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
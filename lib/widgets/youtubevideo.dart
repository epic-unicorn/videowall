import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeVideo extends StatefulWidget {
  @override
  _YoutubeVideoState createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '1IQWxpueONg',
      params: const YoutubePlayerParams(
        mute: true,
        showFullscreenButton: true,
        desktopMode: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      controller: _controller,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: player),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }
}

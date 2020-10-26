import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:videowall/adapters/videowalladapterbase.dart';

class RandomTestVideo extends StatefulWidget {
  final VideowallAdapterBase adapter;

  const RandomTestVideo({
    @required this.adapter,
  }) : assert(adapter != null);

  _RandomTestVideoState createState() => _RandomTestVideoState();
}

class _RandomTestVideoState extends State<RandomTestVideo> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        widget.adapter.getVideowallItem().videourl);
    _controller.addListener(() {
      setState(() {});
    });
    _initializeVideoPlayerFuture = _controller.initialize().then((value) => {
          _controller.setVolume(0),
          _controller.play(),
          _controller.setLooping(true)
        });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _clearPrevious() async {
    await _controller?.pause();
    return true;
  }

  Future<void> _initializePlay(String videoPath) async {
    _controller = VideoPlayerController.network(videoPath);
    _controller.addListener(() {
      setState(() {});
    });
    _initializeVideoPlayerFuture = _controller.initialize().then((value) => {
          _controller.setVolume(0),
          _controller.play(),
          _controller.setLooping(true)
        });
  }

  void _getValuesAndPlay(String videoPath) {
    _startPlay(videoPath);
  }

  Future<void> _startPlay(String videoPath) async {
    setState(() {
      _initializeVideoPlayerFuture = null;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      _clearPrevious().then((_) {
        _initializePlay(videoPath);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: <Widget>[
              Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  color: Colors.black54,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () {
                            _getValuesAndPlay(
                                widget.adapter.getVideowallItem().videourl);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return Center(child: CircularProgressIndicator());
        }
      },
    );

    /*
    return SizedBox.expand(
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            VideoPlayer(_controller),
          ],
        ),
      ),
    );*/
  }
}

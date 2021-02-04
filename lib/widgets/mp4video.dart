import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:videowall/adapters/videowalladapterbase.dart';

class MP4Video extends StatefulWidget {
  final VideowallAdapterBase adapter;

  const MP4Video({
    @required this.adapter,
  }) : assert(adapter != null);

  _MP4VideoState createState() => _MP4VideoState();
}

class _MP4VideoState extends State<MP4Video> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  String _videoTitle;

  @override
  void initState() {
    widget.adapter.getRandomVideowallItem().then((videoWallItem) {
      _controller = VideoPlayerController.network(videoWallItem.videourl);
      _videoTitle = videoWallItem.title;
      _controller.addListener(() {
        setState(() {});
      });
      _initializeVideoPlayerFuture = _controller.initialize().then((value) => {
            _controller.setVolume(0),
            _controller.play(),
            _controller.setLooping(true)
          });
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
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        VideoPlayer(_controller),
                        VideoProgressIndicator(_controller,
                            allowScrubbing: true),
                      ],
                    )),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                    color: Colors.black45,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Text(
                          _videoTitle,
                          textAlign: TextAlign.center,
                        ))
                      ],
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.black45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.replay_10_outlined),
                        onPressed: () {
                          _controller.seekTo(_controller.value.position -
                              Duration(seconds: 10));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh_outlined),
                        onPressed: () {
                          // first play static tv noise
                          _videoTitle = 'Loading...';
                          _getValuesAndPlay('assets/load.mp4');

                          widget.adapter.getRandomVideowallItem().then(
                              (videowallItem) => {
                                    _getValuesAndPlay(videowallItem.videourl),
                                    _videoTitle = videowallItem.title
                                  });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.forward_10_outlined),
                        onPressed: () {
                          _controller.seekTo(_controller.value.position +
                              Duration(seconds: 10));
                        },
                      ),
                      _constructVolumeIconButton()
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _constructVolumeIconButton() {
    if (_controller.value.volume > 0) {
      return IconButton(
        icon: Icon(Icons.volume_up),
        onPressed: () {
          _controller.setVolume(0);
          setState(() {});
        },
      );
    }

    return IconButton(
      icon: Icon(Icons.volume_off),
      onPressed: () {
        _controller.setVolume(1);
        setState(() {});
      },
    );
  }
}

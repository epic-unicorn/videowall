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

  @override
  void initState() {
    widget.adapter.getRandomVideowallItem().then((videoWallItem) {
      _controller = VideoPlayerController.network(videoWallItem.videourl);
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
                  child: VideoPlayer(_controller),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  color: Colors.black12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () {
                            widget.adapter.getRandomVideowallItem().then(
                                (videowallItem) => {
                                      _getValuesAndPlay(videowallItem.videourl)
                                    });
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
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

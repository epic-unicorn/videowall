import 'dart:html';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:videowall/adapters/videowalladapterbase.dart';

class EmbeddedVideo extends StatefulWidget {
  final VideowallAdapterBase adapter;

  const EmbeddedVideo({
    @required this.adapter,
  }) : assert(adapter != null);

  @override
  _EmbeddedVideoState createState() => _EmbeddedVideoState();
}

class _EmbeddedVideoState extends State<EmbeddedVideo> {
  final IFrameElement _iframeElement = IFrameElement();
  String _uniqueId = new Random().nextInt(100).toString();
  String _videoUrl = '';
  String _videoTitle = 'title';

  @override
  void initState() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      _uniqueId,
      (int viewId) => _iframeElement,
    );

    widget.adapter.getRandomVideowallItem().then((videoWallItem) {
      setState(() {
        _videoTitle = videoWallItem.title;
      });
      _videoUrl = videoWallItem.videourl;

      _iframeElement.src = _videoUrl;
      _iframeElement.style.border = 'none';
      _iframeElement.style.pointerEvents = 'none';
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
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
      Expanded(
        child: HtmlElementView(
          key: UniqueKey(),
          viewType: _uniqueId,
        ),
        flex: 1,
      ),
      Container(
        color: Colors.black45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.replay_10_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.refresh_outlined),
              onPressed: () {
                _loadNewVideo();
              },
            ),
            IconButton(
              icon: Icon(Icons.forward_10_outlined),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ]);
  }

  void _loadNewVideo() {
    widget.adapter.getRandomVideowallItem().then((videoWallItem) {
      setState(() {
        _videoTitle = videoWallItem.title;
      });
      _videoUrl = videoWallItem.videourl;

      _iframeElement.src = _videoUrl;
      _iframeElement.style.border = 'none';
      _iframeElement.style.pointerEvents = 'none';
    });
  }
}

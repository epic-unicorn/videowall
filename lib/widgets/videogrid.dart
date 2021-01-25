import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:videowall/adapters/motherlessadapter.dart';
import 'package:videowall/adapters/redtubeadapter.dart';
import 'package:videowall/adapters/testvideoadapter.dart';
import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/adapters/xvideosadapter.dart';
import 'package:videowall/adapters/youtubevideoadapter.dart';
import 'package:videowall/widgets/mp4video.dart';
import 'package:videowall/widgets/youtubevideo.dart';

class VideoGrid extends StatefulWidget {
  final String numberOfVideos;
  final VideowallAdapterBase videowallAdapter;

  VideoGrid(this.numberOfVideos, this.videowallAdapter);

  @override
  _VideoGridState createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  @override
  Widget build(BuildContext context) {
    double _calculatedGridSize = sqrt(int.parse(widget.numberOfVideos));

    return new Container(
      padding: EdgeInsets.all(20),
      child: LayoutGrid(
        columnGap: 20,
        rowGap: 20,
        templateColumnSizes: [
          for (var i = 0; i < _calculatedGridSize; i++) FlexibleTrackSize(1),
        ],
        templateRowSizes: [
          for (var i = 0; i < _calculatedGridSize; i++) FlexibleTrackSize(1),
        ],
        children: [
          for (var i = 0; i < int.parse(widget.numberOfVideos); i++)
            addVideowallItem()
        ],
      ),
    );
  }

  Widget addVideowallItem() {
    switch (widget.videowallAdapter.runtimeType) {
      case TestVideoAdapter:
        return MP4Video(adapter: widget.videowallAdapter);
      case YoutubeVideoAdapter:
        return YoutubeVideo();
      case XVideosAdapter:
        return MP4Video(adapter: widget.videowallAdapter);
      case RedtubeAdapter:
        return MP4Video(adapter: widget.videowallAdapter);
      case MotherlessAdapter:
        return MP4Video(adapter: widget.videowallAdapter);
    }
    // Unkown adapter
    throw new Exception('Unknown adapter is requested.');
  }
}

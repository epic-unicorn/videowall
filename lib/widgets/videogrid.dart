import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:videowall/adapters/testvideoadapter.dart';
import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/widgets/randomtestvideo.dart';

class VideoGrid extends StatefulWidget {
  final String numberOfVideos;

  VideoGrid(this.numberOfVideos);

  @override
  _VideoGridState createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  final VideowallAdapterBase _adapter = new TestVideoAdapter();

  @override
  Widget build(BuildContext context) {
    double _calculatedGridSize = sqrt(int.parse(widget.numberOfVideos));

    return Container(
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
            RandomTestVideo(
              adapter: _adapter,
            ),
        ],
      ),
    );
  }
}

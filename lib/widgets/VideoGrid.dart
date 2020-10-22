import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:videowall/adapters/testvideoadapter.dart';
import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/widgets/randomtestvideo.dart';

class VideoGrid extends StatefulWidget {
  @override
  _VideoGridState createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  final VideowallAdapterBase _adapter = new TestVideoAdapter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: LayoutGrid(
        columnGap: 20,
        rowGap: 20,
        templateColumnSizes: [
          FlexibleTrackSize(1),
          FlexibleTrackSize(1),
        ],
        templateRowSizes: [
          FlexibleTrackSize(1),
          FlexibleTrackSize(1),
        ],
        children: [
          RandomTestVideo(
            adapter: _adapter,
          ),
          RandomTestVideo(
            adapter: _adapter,
          ),
          RandomTestVideo(
            adapter: _adapter,
          ),
          RandomTestVideo(
            adapter: _adapter,
          ),
        ],
      ),
    );
  }
}

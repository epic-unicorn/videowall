import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:videowall/adapters/TestVideoAdapter.dart';
import 'package:videowall/interfaces/IVideowallModelAdapter.dart';
import 'package:videowall/widgets/RandomTestVideo.dart';

class VideoGrid extends StatefulWidget {
  @override
  _VideoGridState createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  final IVideowallModelAdapter adapter = new TestVideoAdapter();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutGrid(
        columnGap: 0,
        rowGap: 0,
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
            adapter: adapter,
          ),
          RandomTestVideo(
            adapter: adapter,
          ),
          RandomTestVideo(
            adapter: adapter,
          ),
          RandomTestVideo(
            adapter: adapter,
          ),
        ],
      ),
    );
  }
}

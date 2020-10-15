import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:videowall/widgets/IFrameElement.dart';

class VideoGrid extends StatefulWidget {
  @override
  _VideoGridState createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: LayoutGrid(
        columnGap: 0,
        rowGap: 0,
        templateColumnSizes: [
          FlexibleTrackSize(1),
          FlexibleTrackSize(1),
        ],
        templateRowSizes: [
          IntrinsicContentTrackSize(),
          IntrinsicContentTrackSize(),
        ],
        children: [
          IFrameElement(),
          IFrameElement(),
          IFrameElement(),
          IFrameElement()
        ],
      ),
    );
  }
}

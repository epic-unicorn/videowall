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
      padding: new EdgeInsets.all(10),
      color: Colors.black12,
      child: LayoutGrid(
        columnGap: 10,
        rowGap: 10,
        templateColumnSizes: [
          FlexibleTrackSize(1),
          FlexibleTrackSize(1),
        ],
        templateRowSizes: [
          IntrinsicContentTrackSize(),
          IntrinsicContentTrackSize(),
        ],
        children: [
          IFrameElement('https://www.youtube.com/embed/1Uf2Bjp0nR8'),
          IFrameElement('https://www.youtube.com/embed/MuNRygvoB-E'),
          IFrameElement('https://www.youtube.com/embed/ckVJcAtyd2w'),
          IFrameElement('https://www.youtube.com/embed/DTIKGtUbRqU')
        ],
      ),
    );
  }
}

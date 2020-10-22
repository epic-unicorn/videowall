import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmbeddedVideo extends StatefulWidget {
  final String videoUrl;

  EmbeddedVideo(this.videoUrl);

  @override
  _EmbeddedVideoState createState() => _EmbeddedVideoState();
}

class _EmbeddedVideoState extends State<EmbeddedVideo> {
  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    /*
    ui.platformViewRegistry.registerViewFactory(
        widget.videoUrl,
        (int id) => html.IFrameElement()
          ..width = MediaQuery.of(context).size.width.toString()
          ..height = MediaQuery.of(context).size.height.toString()
          ..src = widget.videoUrl + '?autoplay=1&mute=1&autohide=1&&showinfo=0'
          ..style.border = 'none'
          ..allow = 'autoplay');
    */
    return Container(
      child: HtmlElementView(
        viewType: widget.videoUrl,
      ),
    );
  }
}

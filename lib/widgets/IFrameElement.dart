import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui' as ui;

class IFrameElement extends StatefulWidget {
  final String videoUrl;

  IFrameElement(this.videoUrl);

  @override
  _IFrameElementState createState() => _IFrameElementState();
}

class _IFrameElementState extends State<IFrameElement> {
  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        widget.videoUrl,
        (int id) => html.IFrameElement()
          ..width = MediaQuery.of(context).size.width.toString()
          ..height = MediaQuery.of(context).size.height.toString()
          ..src = widget.videoUrl + '?autoplay=1&mute=1'
          ..style.border = 'none'
          ..allow = 'autoplay');

    return Container(
      child: HtmlElementView(
        viewType: widget.videoUrl,
      ),
    );
  }
}
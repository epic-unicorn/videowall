import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';
import 'package:videowall/VideoSourceManager.dart';
import 'package:videowall/widgets/videogrid.dart';

void main() {
  if (!kIsWeb) _setTargetPlatformForDesktop();
  return runApp(MyApp());
}

/// If the current platform is desktop, override the default platform to
/// a supported platform (iOS for macOS, Android for Linux and Windows).
/// Otherwise, do nothing.
void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video wall',
      theme: ThemeData.dark().copyWith(accentColor: Colors.red),
      home: MyHomePage(title: 'Video wall'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String numberOfVideos = '1';

  @override
  void initState() {
    super.initState();

    VideoSourceManager.getSubscribedVideoSource();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return ResponsiveScaffold(
      title: Text(widget.title),
      endIcon: Icons.filter_list,
      endDrawer: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          ListTile(
            title: Text('Number of videos'),
            trailing: DropdownButtonHideUnderline(
              child: new DropdownButton<String>(
                value: numberOfVideos,
                items: <DropdownMenuItem<String>>[
                  new DropdownMenuItem(
                    child: new Text('1'),
                    value: '1',
                  ),
                  new DropdownMenuItem(
                    child: new Text('4'),
                    value: '4',
                  ),
                  new DropdownMenuItem(
                    child: new Text('9'),
                    value: '9',
                  ),
                ],
                onChanged: (String value) {
                  setState(() => numberOfVideos = value);
                },
              ),
            ),
          ),
          ListTile(
            title: Text('Video source'),
            subtitle: Text('Change the video source'),
          ),
          ListTile(
            leading: Icon(Icons.video_library),
            title: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
              value: '1',
              items: <DropdownMenuItem<String>>[
                new DropdownMenuItem(
                  child: new Text('Test videos'),
                  value: '1',
                ),
                new DropdownMenuItem(
                  child: new Text('Another video source'),
                  value: '2',
                ),
              ],
              onChanged: (String value) {
                setState(() => numberOfVideos = value);
              },
            )),
          ),
        ],
      ),
      body: VideoGrid(
          numberOfVideos, VideoSourceManager.getSubscribedVideoSource()),
    );
  }
}

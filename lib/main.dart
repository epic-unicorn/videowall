import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  String _numberOfVideos = '1';
  List<String> _videoGridTypes = ['1', '2', '4'];
  VideoSourceManager _videoSourceManager = new VideoSourceManager();
  VideoSource _selectedVideoSource;
  List<VideoSource> _availableVideoSources = [];

  @override
  void initState() {
    super.initState();
    _availableVideoSources = _videoSourceManager.getAvailableVideoSources();
    _selectedVideoSource = _availableVideoSources.first;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: Text(widget.title),
      endIcon: Icons.filter_list,
      endDrawer: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          ListTile(
            title: Text('Number of videos'),
          ),
          ListTile(
            leading: Icon(Icons.grid_view),
            title: DropdownButtonHideUnderline(
              child: new DropdownButton<String>(
                value: _numberOfVideos,
                items: _videoGridTypes.map((String value) {
                  return new DropdownMenuItem<String>(
                      value: value, child: new Text(value));
                }).toList(),
                onChanged: (String value) {
                  setState(() => _numberOfVideos = value);
                },
              ),
            ),
          ),
          ListTile(
            title: Text('Video source'),
          ),
          ListTile(
            leading: Icon(Icons.video_library),
            title: DropdownButtonHideUnderline(
                child: DropdownButton<VideoSource>(
              value: _selectedVideoSource,
              items: _availableVideoSources.map((VideoSource map) {
                return new DropdownMenuItem<VideoSource>(
                    value: map, child: new Text(map.title));
              }).toList(),
              onChanged: (VideoSource newValue) {
                setState(() {
                  _selectedVideoSource = newValue;
                });
              },
            )),
          ),
          if (_selectedVideoSource.videowallAdapter.canPerformSearch())
            ListTile(
                leading: Icon(Icons.search),
                title: TextField(
                    decoration: InputDecoration(labelText: 'Zoeken naar...'),
                    onSubmitted: (text) {
                      _selectedVideoSource.videowallAdapter
                          .setSearchParameter(text);
                    })),
        ],
      ),
      body: VideoGrid(_numberOfVideos, _selectedVideoSource.videowallAdapter),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videowall/settings.dart';
import 'package:videowall/widgets/VideoGrid.dart';

import 'utils/theme_notifier.dart';
import 'utils/themes.dart';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui' as ui;

void main() {
  SharedPreferences.getInstance().then((prefs) {
    var darkModeOn = prefs.getBool('darkMode') ?? false;
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Video Wall',
      theme: themeNotifier.getTheme(),
      home: MyHomePage(title: 'Video Wall'),
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
  String viewID = "your-view-id";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              color: Theme.of(context).accentIconTheme.color,
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Settings()));
              },
            ),
          ],
        ),
        body: Container(
          color: Colors.blueGrey,
          child: Center(
            child: VideoGrid(),
          ),
        ));
  }
}

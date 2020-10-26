import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videowall/settings.dart';
import 'package:videowall/widgets/videogrid.dart';
import 'utils/theme_notifier.dart';
import 'utils/themes.dart';

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
  String viewID = "videowall-id";
  String numberOfVideos = '4';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);    
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            new DropdownButtonHideUnderline(
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
            IconButton(
              icon: Icon(Icons.refresh),
              color: Theme.of(context).accentIconTheme.color,
              onPressed: () async {
                setState(() {});
              },
            ),
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
        body: VideoGrid(numberOfVideos));
  }
}

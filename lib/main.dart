import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videowall/settings.dart';

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
          child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3.0,
              padding: const EdgeInsets.all(4.0),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: <String>[
                'https://lachvandedag.nl/wp-content/uploads/2017/06/ben-je-thuis_lachvandedag-nl.jpg',
                'https://lachvandedag.nl/wp-content/uploads/2017/06/ben-je-thuis_lachvandedag-nl.jpg',
                'https://lachvandedag.nl/wp-content/uploads/2017/06/ben-je-thuis_lachvandedag-nl.jpg',
                'https://lachvandedag.nl/wp-content/uploads/2017/06/ben-je-thuis_lachvandedag-nl.jpg',
              ].map((String url) {
                return GridTile(
                    child: Image.network(url, fit: BoxFit.scaleDown));
              }).toList()),
        ));
  }
}

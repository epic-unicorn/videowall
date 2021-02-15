import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';
import 'package:videowall/models/scorebat.dart';
import 'package:videowall/models/videowall_model.dart';
import 'package:http/http.dart' as http;

class ScorebatApi {
  Future<VideowallModel> getVideo(String query) async {
    var baseUrl = 'https://www.scorebat.com/video-api/v1/';

    try {
      final response = await http.get(baseUrl);

      if (response.statusCode == 200) {
        List<dynamic> test = json.decode(response.body) as List;
        var scorebat = Scorebat.fromJson(test);
        var randomVideo =
            scorebat.games[new Random().nextInt(scorebat.games.length)];

        Element document =
            parse(randomVideo.videos.first.embed).querySelector('div > iframe');

        var embeddedUrl = document.attributes['src'];

        print('Scorebat: ' + embeddedUrl);

        return new VideowallModel(
            videourl: embeddedUrl, title: randomVideo.videos.first.title);
      } else {
        throw Exception('Failed to load Dailymotion videos');
      }
    } catch (e) {
      print('!!! Scorebat API error reading video URLs\n');
      print(e.toString());
    }

    return new VideowallModel(
        videourl: 'assets/static.webm', title: 'Error loading');
  }
}

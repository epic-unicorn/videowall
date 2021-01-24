import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:videowall/models/mediadefinitions.dart';
import 'package:videowall/models/redtube.dart';
import 'package:videowall/models/videowall_model.dart';
import 'package:http/http.dart' as http;

class RedtubeApi {
  Future<VideowallModel> getVideo(String query) async {
    var baseUrl =
        'https://cors-anywhere.herokuapp.com/https://api.redtube.com/?data=redtube.Videos.searchVideos';

    try {
      final response = await http.get(baseUrl);

      if (response.statusCode == 200) {
        var redtubeVideos = RedtubeVideos.fromJson(jsonDecode(response.body));
        var embeddedUrl = 'https://cors-anywhere.herokuapp.com/' +
            redtubeVideos.videos[1].video.embedUrl;

        print(embeddedUrl);
        var client = Client();
        Response res = await client.get(embeddedUrl);

        var startIndex = res.body.indexOf('mediaDefinitions');
        var endIndex = res.body.indexOf('video_unavailable_country');
        var str = res.body.substring(startIndex, endIndex);

        str = str.substring(18, str.length - 2);

        var yes = '{"videos":' + str + '}';

        print(yes);
        var test = Mediadefinitions.fromJson(json.decode(yes));

        print(test.videos[0].videoUrl);
      } else {
        throw Exception('Failed to load Redtube videos');
      }
    } catch (e) {
      print('!!! Redtube API error reading video URLs\n');
      print(e.toString());
    }

    return VideowallModel(videourl: 'assets/static', title: '');
  }
}

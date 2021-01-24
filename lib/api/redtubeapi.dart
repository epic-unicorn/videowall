import 'dart:convert';

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
      } else {
        throw Exception('Failed to load Redtube videos');
      }
    } catch (e) {
      print('!!! Redtube API error reading video URLs\n');
    }

    return VideowallModel(videourl: 'assets/static');
  }
}

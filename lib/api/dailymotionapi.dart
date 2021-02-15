import 'dart:convert';
import 'dart:math';
import 'package:videowall/models/dailymotion.dart';
import 'package:videowall/models/videowall_model.dart';
import 'package:http/http.dart' as http;

class DailymotionApi {
  Future<VideowallModel> getVideo(String query) async {
    var baseUrl =
        'https://api.dailymotion.com/videos?search=$query&sort=recent';

    try {
      final response = await http.get(baseUrl);

      if (response.statusCode == 200) {
        var dailymotionVideos = Dailymotion.fromJson(jsonDecode(response.body));
        var randomVideo = dailymotionVideos
            .list[new Random().nextInt(dailymotionVideos.list.length)];

        String randomVideoId = randomVideo.id;
        print(query);

        var embeddedUrl =
            'https://www.dailymotion.com/embed/video/$randomVideoId?autoplay=1&mute=1';

        print('Dailymotion: ' + embeddedUrl);

        return new VideowallModel(
            videourl: embeddedUrl, title: randomVideo.title);
      } else {
        throw Exception('Failed to load Dailymotion videos');
      }
    } catch (e) {
      print('!!! Dailymotion API error reading video URLs\n');
      print(e.toString());
    }

    return new VideowallModel(
        videourl: 'assets/static.webm', title: 'Error loading');
  }
}

import 'dart:convert';
import 'dart:math';
import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/api/testvideoapi.dart';
import 'package:videowall/models/videowall_model.dart';

class TestVideoAdapter implements VideowallAdapterBase {
  final TestVideoApi _api = TestVideoApi();

  @override
  VideowallModel getVideowallItem() {
    var testVideosJson = _api.getTestVideos();
    var videoList = _parseJson(testVideosJson);
    if (videoList.isNotEmpty)
      return videoList[new Random().nextInt(videoList.length)];
    else
      return null;
  }

  List<VideowallModel> _parseJson(String testVideoJson) {
    var testVideoMap = json.decode(testVideoJson) as Map<String, dynamic>;
    var videosJsonList = testVideoMap['videos'] as List;
    var videosList = videosJsonList
        .map((json) => VideowallModel(
              title: json['title'],
              videourl: json['source'],
            ))
        .toList();

    return videosList;
  }
}

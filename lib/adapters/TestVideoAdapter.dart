import 'dart:convert';

import 'package:videowall/api/TestVideoApi.dart';
import 'package:videowall/interfaces/IVideowallModelAdapter.dart';
import 'package:videowall/models/Videowall_model.dart';

class TestVideoAdapter implements IVideowallModelAdapter {
  final TestVideoApi _api = TestVideoApi();

  @override
  List<VideowallModel> getVideowallItems() {
    var contactsJson = _api.getTestVideos();
    var contactsList = _parseJson(contactsJson);

    return contactsList;
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

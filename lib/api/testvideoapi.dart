import 'dart:convert';
import 'dart:math';

import 'package:videowall/models/videowall_model.dart';

class TestVideoApi {
  final String _testVideos = '''
  {
    "videos" : [ 
		        {
              "source" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
              "title" : "Big Buck Bunny"
            },
            { 
              "source" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
              "title" : "Elephant Dream"
            },
            { 
              "source" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
              "title" : "For Bigger Blazes"
            },
            { 
              "source" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
              "title" : "For Bigger Escape"
            },
            { 
              "source" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
              "title" : "For Bigger Fun"
            },
            { 
              "source" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
              "title" : "For Bigger Joyrides"
            },
            { 
              "source" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
              "title" : "For Bigger Meltdowns"
            },
            { 
              "source" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
              "title" : "Sintel"
            },
            { 
              "source" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
              "title" : "Subaru Outback On Street And Dirt"
            },
            { 
              "source" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
              "title" : "Tears of Steel"
            },
            { 
              "source" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
              "title" : "Volkswagen GTI Review"
            },
            { 
              "source" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
              "title" : "We Are Going On Bullrun"
            },
            { 
              "source" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
              "title" : "What care can you get for a grand?"
            }
    ]
  }
  ''';

  Future<VideowallModel> getTestVideo() async {
    var videoList = _parseJson(_testVideos);
    var randomVideo = videoList[new Random().nextInt(videoList.length)];
    print('Testvideo: ' + randomVideo.videourl);
    return randomVideo;
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

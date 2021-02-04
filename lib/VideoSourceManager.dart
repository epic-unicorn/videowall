import 'package:videowall/adapters/motherlessadapter.dart';
import 'package:videowall/adapters/redtubeadapter.dart';
import 'package:videowall/adapters/testvideoadapter.dart';
import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/adapters/xvideosadapter.dart';
import 'package:videowall/adapters/youtubevideoadapter.dart';

class VideoSource {
  VideowallAdapterBase videowallAdapter;
  String title;
  VideoSource(this.videowallAdapter, this.title);
}

class VideoSourceManager {
  List<VideoSource> _availableVideoSources = [];

  VideoSourceManager() {
    _availableVideoSources
        .add(new VideoSource(new TestVideoAdapter(), "Test videos"));
    _availableVideoSources
        .add(new VideoSource(new XVideosAdapter(), "XVideos"));
    _availableVideoSources
        .add(new VideoSource(new MotherlessAdapter(), "Motherless"));
    _availableVideoSources
        .add(new VideoSource(new RedtubeAdapter(), "Redtube"));
    _availableVideoSources
        .add(new VideoSource(new YoutubeVideoAdapter(), "Youtube"));
  }

  List<VideoSource> getAvailableVideoSources() {
    return _availableVideoSources;
  }
}

import 'package:videowall/adapters/testvideoadapter.dart';
import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/adapters/xvideosadapter.dart';

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
  }

  List<VideoSource> getAvailableVideoSources() {
    return _availableVideoSources;
  }

  static VideowallAdapterBase getSubscribedVideoSource() {
    return new TestVideoAdapter();
  }
}

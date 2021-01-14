import 'package:videowall/adapters/testvideoadapter.dart';
import 'package:videowall/adapters/videowalladapterbase.dart';

class VideoSourceManager {
  static List<VideowallAdapterBase> getAllVideoSources() {
    return new List.empty();
  }

  static VideowallAdapterBase getSubscribedVideoSource() {
    return new TestVideoAdapter();
  }
}

import 'package:videowall/adapters/testvideoadapter.dart';
import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/adapters/xvideosadapter.dart';

class VideoSourceManager {
  static VideowallAdapterBase getSubscribedVideoSource() {
    return new TestVideoAdapter();
  }
}

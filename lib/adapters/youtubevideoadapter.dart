import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/models/videowall_model.dart';

class YoutubeVideoAdapter implements VideowallAdapterBase {
  @override
  VideowallModel getRandomVideowallItem() {
    return new VideowallModel();
  }
}

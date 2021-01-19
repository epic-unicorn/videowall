import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/models/videowall_model.dart';

class YoutubeVideoAdapter implements VideowallAdapterBase {
  @override
  Future<VideowallModel> getRandomVideowallItem() async {
    return new VideowallModel();
  }
}

import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/models/videowall_model.dart';

class YoutubeVideoAdapter implements VideowallAdapterBase {
  @override
  Future<VideowallModel> getRandomVideowallItem() async {
    return new VideowallModel();
  }

  @override
  void setSearchParameter(String query) {
    // TODO: implement setSearchParameter
  }

  @override
  bool canPerformSearch() {
    return false;
  }
}

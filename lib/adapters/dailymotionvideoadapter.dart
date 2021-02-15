import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/api/dailymotionapi.dart';
import 'package:videowall/models/videowall_model.dart';

class DailymotionVideoAdapter implements VideowallAdapterBase {
  final DailymotionApi _api = DailymotionApi();
  String query;

  @override
  Future<VideowallModel> getRandomVideowallItem() async {
    return _api.getVideo(query);
  }

  @override
  void setSearchParameter(String query) {
    this.query = query;
  }

  @override
  bool canPerformSearch() {
    return true;
  }
}

import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/api/redtubeapi.dart';
import 'package:videowall/models/videowall_model.dart';

class RedtubeAdapter implements VideowallAdapterBase {
  final RedtubeApi _api = RedtubeApi();
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

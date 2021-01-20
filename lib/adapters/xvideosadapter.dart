import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/api/xvideosapi.dart';
import 'package:videowall/models/videowall_model.dart';

class XVideosAdapter implements VideowallAdapterBase {
  final XVideosApi _api = XVideosApi();
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

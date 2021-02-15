import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/api/scorebatapi.dart';
import 'package:videowall/models/videowall_model.dart';

class ScorebatVideoAdapter implements VideowallAdapterBase {
  final ScorebatApi _api = ScorebatApi();
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
    return false;
  }
}

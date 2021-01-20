import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/api/motherlessapi.dart';
import 'package:videowall/models/videowall_model.dart';

class MotherlessAdapter implements VideowallAdapterBase {
  final MotherlessApi _api = MotherlessApi();
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

import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/api/testvideoapi.dart';
import 'package:videowall/models/videowall_model.dart';

class TestVideoAdapter implements VideowallAdapterBase {
  final TestVideoApi _api = TestVideoApi();

  @override
  Future<VideowallModel> getRandomVideowallItem() async {
    return _api.getTestVideo();
  }
}

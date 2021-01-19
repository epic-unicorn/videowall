import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/api/xvideosapi.dart';
import 'package:videowall/models/videowall_model.dart';

class XVideosAdapter implements VideowallAdapterBase {
  final XVideosApi _api = XVideosApi();

  @override
  Future<VideowallModel> getRandomVideowallItem() async {
    return _api.getVideo();
  }
}

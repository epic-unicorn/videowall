import 'package:videowall/models/videowall_model.dart';

abstract class VideowallAdapterBase {
  Future<VideowallModel> getRandomVideowallItem();
}

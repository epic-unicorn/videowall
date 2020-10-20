import 'package:videowall/models/videowall_model.dart';

abstract class IVideowallModelAdapter {
  List<VideowallModel> getVideowallItems();
}

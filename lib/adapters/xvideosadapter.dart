import 'dart:convert';
import 'dart:math';
import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/api/xvideosapi.dart';
import 'package:videowall/models/videowall_model.dart';

class XVideosAdapter implements VideowallAdapterBase {
  final XVideosApi _api = XVideosApi();

  @override
  VideowallModel getRandomVideowallItem() {
    var result;

    _api.getVideo().then((value) => {result = value});

    return result;
  }
}

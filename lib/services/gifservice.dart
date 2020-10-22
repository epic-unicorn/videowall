import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:videowall/models/Gif_model.dart';

class GifService {
  static const String url = "http://api.giphy.com/v1/gifs/random?api_key=";
  String apiKey = "0UTRbFtkMxAplrohufYco5IY74U8hOes";

  Future<Gif> fetchImageUrlAsync(String tag) async {
    if (apiKey.isEmpty) {
      apiKey = await rootBundle.loadString("api_key");
    }
    var requestEndpoint = "$url$apiKey&tag=$tag";
    final response = await http.get(requestEndpoint);
    if (response.statusCode == 200) {
      return Gif.fromJson(json.decode(response.body));
    }
    return null;
  }
}

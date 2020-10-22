import 'package:flutter/material.dart';
import 'package:videowall/models/Gif_model.dart';
import 'package:videowall/services/gifservice.dart';

class RandomGif extends StatefulWidget {
  @override
  _RandomGifState createState() => new _RandomGifState();
}

class _RandomGifState extends State<RandomGif> {
  final GifService gifService = GifService();

  String _tag = "fail";

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 620,
        child: FutureBuilder<Gif>(
            future: gifService.fetchImageUrlAsync(_tag), builder: _buildImage));
  }

  Widget _buildImage(_, AsyncSnapshot<Gif> snapshot) {
    if (snapshot.hasData) {
      return Image.network(snapshot.data.url, fit: BoxFit.cover);
    }
    return CircularProgressIndicator();
  }
}

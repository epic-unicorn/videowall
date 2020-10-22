class GifModel {
  String url;

  GifModel.fromJson(Map<String, dynamic> json) {
    url = json['data']['image_url'];
  }
}

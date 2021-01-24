class Mediadefinitions {
  List<Videos> videos;

  Mediadefinitions({this.videos});

  Mediadefinitions.fromJson(Map<String, dynamic> json) {
    if (json['videos'] != null) {
      videos = new List<Videos>();
      json['videos'].forEach((v) {
        videos.add(new Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.videos != null) {
      data['videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  bool defaultQuality;
  String format;
  String quality;
  String videoUrl;

  Videos({this.defaultQuality, this.format, this.quality, this.videoUrl});

  Videos.fromJson(Map<String, dynamic> json) {
    defaultQuality = json['defaultQuality'];
    format = json['format'];
    quality = json['quality'];
    videoUrl = json['videoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['defaultQuality'] = this.defaultQuality;
    data['format'] = this.format;
    data['quality'] = this.quality;
    data['videoUrl'] = this.videoUrl;
    return data;
  }
}

class RedtubeVideos {
  List<Videos> videos;
  int count;

  RedtubeVideos({this.videos, this.count});

  RedtubeVideos.fromJson(Map<String, dynamic> json) {
    if (json['videos'] != null) {
      videos = new List<Videos>();
      json['videos'].forEach((v) {
        videos.add(new Videos.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.videos != null) {
      data['videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Videos {
  Video video;

  Videos({this.video});

  Videos.fromJson(Map<String, dynamic> json) {
    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.video != null) {
      data['video'] = this.video.toJson();
    }
    return data;
  }
}

class Video {
  String duration;
  int views;
  String videoId;
  String rating;
  int ratings;
  String title;
  String url;
  String embedUrl;
  String defaultThumb;
  String thumb;
  String publishDate;
  List<Thumbs> thumbs;
  List<Tags> tags;

  Video(
      {this.duration,
      this.views,
      this.videoId,
      this.rating,
      this.ratings,
      this.title,
      this.url,
      this.embedUrl,
      this.defaultThumb,
      this.thumb,
      this.publishDate,
      this.thumbs,
      this.tags});

  Video.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    views = json['views'];
    videoId = json['video_id'];
    rating = json['rating'];
    ratings = json['ratings'];
    title = json['title'];
    url = json['url'];
    embedUrl = json['embed_url'];
    defaultThumb = json['default_thumb'];
    thumb = json['thumb'];
    publishDate = json['publish_date'];
    if (json['thumbs'] != null) {
      thumbs = new List<Thumbs>();
      json['thumbs'].forEach((v) {
        thumbs.add(new Thumbs.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    data['views'] = this.views;
    data['video_id'] = this.videoId;
    data['rating'] = this.rating;
    data['ratings'] = this.ratings;
    data['title'] = this.title;
    data['url'] = this.url;
    data['embed_url'] = this.embedUrl;
    data['default_thumb'] = this.defaultThumb;
    data['thumb'] = this.thumb;
    data['publish_date'] = this.publishDate;
    if (this.thumbs != null) {
      data['thumbs'] = this.thumbs.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Thumbs {
  String size;
  int width;
  int height;
  String src;

  Thumbs({this.size, this.width, this.height, this.src});

  Thumbs.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    width = json['width'];
    height = json['height'];
    src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['width'] = this.width;
    data['height'] = this.height;
    data['src'] = this.src;
    return data;
  }
}

class Tags {
  String tagName;

  Tags({this.tagName});

  Tags.fromJson(Map<String, dynamic> json) {
    tagName = json['tag_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_name'] = this.tagName;
    return data;
  }
}

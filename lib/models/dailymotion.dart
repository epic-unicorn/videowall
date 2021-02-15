class Dailymotion {
  int page;
  int limit;
  bool explicit;
  int total;
  bool hasMore;
  List<VideoList> list;

  Dailymotion(
      {this.page,
      this.limit,
      this.explicit,
      this.total,
      this.hasMore,
      this.list});

  Dailymotion.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    explicit = json['explicit'];
    total = json['total'];
    hasMore = json['has_more'];
    if (json['list'] != null) {
      list = new List<VideoList>();
      json['list'].forEach((v) {
        list.add(new VideoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['explicit'] = this.explicit;
    data['total'] = this.total;
    data['has_more'] = this.hasMore;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoList {
  String id;
  String title;
  String channel;
  String owner;

  VideoList({this.id, this.title, this.channel, this.owner});

  VideoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    channel = json['channel'];
    owner = json['owner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['channel'] = this.channel;
    data['owner'] = this.owner;
    return data;
  }
}

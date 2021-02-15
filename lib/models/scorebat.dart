// To parse this JSON data, do
//
//     final scorebat = scorebatFromJson(jsonString);

import 'dart:convert';

Scorebat scorebatFromJson(String str) => Scorebat.fromJson(json.decode(str));

String scorebatToJson(Scorebat data) => json.encode(data.toJson());

class Scorebat {
  Scorebat({
    this.games,
  });

  List<Game> games;

  factory Scorebat.fromJson(List<dynamic> parsedJson) {
    List<Game> list = new List<Game>();
    list = parsedJson.map((i) => Game.fromJson(i)).toList();

    return new Scorebat(games: list);
  }

  Map<String, dynamic> toJson() => {
        "Games": List<dynamic>.from(games.map((x) => x.toJson())),
      };
}

class Game {
  Game({
    this.title,
    this.embed,
    this.url,
    this.thumbnail,
    this.date,
    this.side1,
    this.side2,
    this.competition,
    this.videos,
  });

  String title;
  String embed;
  String url;
  String thumbnail;
  String date;
  Side side1;
  Side side2;
  Competition competition;
  List<Video> videos;

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        title: json["title"],
        embed: json["embed"],
        url: json["url"],
        thumbnail: json["thumbnail"],
        date: json["date"],
        side1: Side.fromJson(json["side1"]),
        side2: Side.fromJson(json["side2"]),
        competition: Competition.fromJson(json["competition"]),
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "embed": embed,
        "url": url,
        "thumbnail": thumbnail,
        "date": date,
        "side1": side1.toJson(),
        "side2": side2.toJson(),
        "competition": competition.toJson(),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
      };
}

class Competition {
  Competition({
    this.name,
    this.id,
    this.url,
  });

  String name;
  int id;
  String url;

  factory Competition.fromJson(Map<String, dynamic> json) => Competition(
        name: json["name"],
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "url": url,
      };
}

class Side {
  Side({
    this.name,
    this.url,
  });

  String name;
  String url;

  factory Side.fromJson(Map<String, dynamic> json) => Side(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Video {
  Video({
    this.title,
    this.embed,
  });

  String title;
  String embed;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        title: json["title"],
        embed: json["embed"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "embed": embed,
      };
}

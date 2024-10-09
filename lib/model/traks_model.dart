import 'dart:convert';

List<Tracks> tracksFromJson(String str) => List<Tracks>.from(json.decode(str).map((x) => Tracks.fromJson(x)));

String tracksToJson(List<Tracks> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tracks {
  int? id;
  String? title;
  String? artist;
  String? albumArtUrl;
  String? streamingUrl;

  Tracks({
    this.id,
    this.title,
    this.artist,
    this.albumArtUrl,
    this.streamingUrl,
  });

  factory Tracks.fromJson(Map<String, dynamic> json) => Tracks(
    id: json["id"],
    title: json["title"],
    artist: json["artist"],
    albumArtUrl: json["albumArtUrl"],
    streamingUrl: json["streamingUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "artist": artist,
    "albumArtUrl": albumArtUrl,
    "streamingUrl": streamingUrl,
  };
}

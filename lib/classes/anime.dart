import 'dart:convert';

Anime animeFromJson(String str) {
  final jsonData = json.decode(str);
  return Anime.fromMap(jsonData);
}

String animeToJson(Anime data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Anime {
  int malId;
  int option;
  String title;
  String url;
  String imageUrl;
  double score;

  Anime({
    this.malId,
    this.option,
    this.title,
    this.url,
    this.imageUrl,
    this.score,
  });

  factory Anime.fromMap(Map<String, dynamic> json) => new Anime(
        malId: json['malId'],
        option: json['option'],
        title: json['title'],
        url: json['url'],
        imageUrl: json['imageUrl'],
        score: json['score'],
      );

  Map<String, dynamic> toMap() => {
        'malId': malId,
        'option': option,
        'title': title,
        'url': url,
        'imageUrl': imageUrl,
        'score': score,
      };
}

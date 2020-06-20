class Anime {
  String malId;
  String title;
  String url;
  String imageUrl;
  String episodes;
  String startDate;
  String endDate;
  String score;

  Anime();

  Anime.fromJson(Map<String, dynamic> json)
      : malId = json['malId'],
        title = json['title'],
        url = json['url'],
        imageUrl = json['image_url'],
        episodes = json['episodes'],
        startDate = json['start_date'],
        endDate = json['end_date'],
        score = json['score'];

  Map<String, dynamic> toJson() => {
        'malId': malId,
        'title': title,
        'url': url,
        'image_url': imageUrl,
        'episodes': episodes,
        'start_date': startDate,
        'end_date': endDate,
        'score': score,
      };
}

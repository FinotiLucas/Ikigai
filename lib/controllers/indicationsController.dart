import 'package:jikan_api/jikan_api.dart';
final jikan = Jikan();

Future<Iterable> fetchIndications() async {
  return await Future.wait([
    getTopAnime(),
    getTopMangas(),
  ]);
}

Future getTopAnime() async {
  var top = await jikan.getTop(TopType.anime, subtype: TopSubtype.airing);
  return top;
}

Future getTopMangas() async {
  var top = await jikan.getTop(TopType.manga, subtype: TopSubtype.bypopularity);
  return top;
}

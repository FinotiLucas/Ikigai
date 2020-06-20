import 'package:jikan_api/jikan_api.dart';

int option = 1;
Future getTopAnime() async {
  var jikan = Jikan();
  var top = await jikan.getTop(TopType.anime, subtype: TopSubtype.airing);
  return top;
}

Future getTopMangas() async {
  var jikan = Jikan();
  var top = await jikan.getTop(TopType.manga, subtype: TopSubtype.bypopularity);
  return top;
}

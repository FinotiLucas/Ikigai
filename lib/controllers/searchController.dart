import 'package:jikan_api/jikan_api.dart';

final jikan = Jikan();

Future<Iterable> fetchSearch(String query) async {
  return await Future.wait([
    getAnimeSearch(query),
    getMangaSearch(query),
  ]);
}

Future getAnimeSearch(String query) async {
  var top = await jikan.search(query, SearchType.anime);
  return top;
}

Future getMangaSearch(String query) async {
  var top = await jikan.search(query, SearchType.manga);
  return top;
}

Future getCharacterSearch(String query) async {
  var top = await jikan.search(query, SearchType.character);
  return top;
}

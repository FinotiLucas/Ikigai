import 'package:jikan_api/jikan_api.dart';

Future<Iterable> fetchDescriptions(animeId, option) async {
  return await Future.wait([
    getInfo(
      animeId,
      option,
    ),
    getNews(
      animeId,
      option,
    ),
    getCharacters(
      animeId,
      option,
    ),
    getReviews(
      animeId,
      option,
    ),
  ]);
}

Future getInfo(animeId, option) async {
  var jikan = Jikan();
  var top = option == 1
      ? await jikan.getAnimeInfo(animeId)
      : await jikan.getMangaInfo(animeId);
  return top;
}

Future getNews(animeId, option) async {
  var jikan = Jikan();
  if (option == 1) {
    var anime = await jikan.getAnimeNews(animeId);
    return anime;
  } else {
    var manga = await jikan.getMangaNews(animeId);
    return manga;
  }
}

Future getCharacters(animeId, option) async {
  var jikan = Jikan();
  if (option == 1) {
    var anime = await jikan.getAnimeCharactersStaff(animeId);
    return anime.characters;
  } else {
    var manga = await jikan.getMangaCharacters(animeId);
    return manga;
  }
}

Future getCharactersDetails(characterId) async {
  var jikan = Jikan();
  var character = await jikan.getCharacterInfo(characterId);
  return character;
}

Future getReviews(animeId, option) async {
  var jikan = Jikan();
  if (option == 1) {
    var anime = await jikan.getAnimeReviews(animeId);
    return anime;
  } else {
    var manga = await jikan.getMangaReviews(animeId);
    return manga;
  }
}

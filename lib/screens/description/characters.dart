import 'package:allnihon/screens/description/characterDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';

class CharactersPage extends StatefulWidget {
  CharactersPage({Key key, this.animeId, this.option}) : super(key: key);

  final animeId;
  final int option;
  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
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

  _buildListTitle(String leading, String title, String subtitle, int id) {
    return ListTile(
      leading: CircleAvatar(
        child: Hero(
          tag: leading + title,
          child: CachedNetworkImage(
            imageUrl: leading,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                borderRadius: new BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (BuildContext context) => new CharacterDetails(
              character: id,
              hero: leading + title,
              id: id,
              image: leading,
              name:title,
            ),
          ),
        );
      },
    );
  }

  futureBuilder() {
    return new FutureBuilder(
      future: getCharacters(widget.animeId, widget.option),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return _buildListTitle(
                snapshot.data[index].imageUrl,
                snapshot.data[index].name,
                snapshot.data[index].role,
                snapshot.data[index].malId,
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return futureBuilder();
  }
}

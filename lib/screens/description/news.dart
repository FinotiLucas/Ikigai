import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key, this.animeId, this.option}) : super(key: key);

  final animeId;
  final int option;
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Future getCharacters(animeId, option) async {
    var jikan = Jikan();
    if (option == 1) {
      var anime = await jikan.getAnimeNews(animeId);
      return anime;
    } else {
      var manga = await jikan.getMangaNews(animeId);
      return manga;
    }
  }

  _buildListTitle(String leading, String title, String subtitle) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: ListTile(
        leading: CircleAvatar(
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
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.justify,
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        /*onTap: () async {
          var jikan = Jikan();
          var char = await jikan.getMangaNews(widget.animeId);
          print(char);
        },*/
      ),
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
                snapshot.data[index].title,
                snapshot.data[index].date,
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

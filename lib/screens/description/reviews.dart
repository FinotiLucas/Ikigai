import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:allnihon/utils/string_extension.dart';

class ReviewsPage extends StatefulWidget {
  ReviewsPage({Key key, this.animeId, this.option}) : super(key: key);

  final animeId;
  final int option;
  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  Future getCharacters(animeId, option) async {
    var jikan = Jikan();
    if (option == 1) {
      var anime = await jikan.getAnimeReviews(animeId);
      return anime;
    } else {
      var manga = await jikan.getMangaReviews(animeId);
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
          textAlign: TextAlign.justify,
        ),
        subtitle: Text(
          subtitle.toString().removebl(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.justify,
        ),
        /*onTap: () async {
          var jikan = Jikan();
          var char = await jikan.getAnimeNews(widget.animeId);
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
                snapshot.data[index].reviewer.imageUrl,
                snapshot.data[index].reviewer.username,
                snapshot.data[index].content,
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

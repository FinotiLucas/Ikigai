import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key, this.anime}) : super(key: key);

  final anime;

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
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

  body() {
    return new ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: widget.anime.length,
      itemBuilder: (context, index) {
        return _buildListTitle(
          widget.anime[index].imageUrl,
          widget.anime[index].title,
          widget.anime[index].date,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ikigai/utils/webview.dart';

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

  _launchURL(String title, String selectedUrl) async {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new MyWebView(
          title: title,
          selectedUrl: selectedUrl,
        ),
      ),
    );
  }

  _buildListTitle(String leading, String title, String subtitle, String url) {
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
        onTap: () async {
          _launchURL(title, url);
        },
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
          widget.anime[index].url,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }
}

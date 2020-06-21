import 'package:cached_network_image/cached_network_image.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:ikigai/utils/string_extension.dart';

class ReviewsPage extends StatefulWidget {
  ReviewsPage({Key key, this.anime}) : super(key: key);

  final anime;
  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
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
          textAlign: TextAlign.justify,
        ),
        subtitle: ExpandText(
          subtitle.toString().removebl(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.justify,
          expandOnGesture: false,
          hideArrowOnExpanded: true,
        ),
        /*onTap: () async {
          var jikan = Jikan();
          var char = await jikan.getAnimeNews(widget.animeId);
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
          widget.anime[index].reviewer.imageUrl,
          widget.anime[index].reviewer.username,
          widget.anime[index].content,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }
}

import 'package:ikigai/screens/description/characterDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharactersPage extends StatefulWidget {
  CharactersPage({Key key, this.anime}) : super(key: key);

  final anime;
  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  @override
  void initState() {
    super.initState();
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
              name: title,
            ),
          ),
        );
      },
    );
  }

  body() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: widget.anime.length,
      itemBuilder: (context, index) {
        return _buildListTitle(
          widget.anime[index].imageUrl,
          widget.anime[index].name,
          widget.anime[index].role,
          widget.anime[index].malId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }
}

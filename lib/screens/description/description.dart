import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ikigai/classes/anime.dart';
import 'package:ikigai/database/database.dart';
import 'package:mdi/mdi.dart';

class AnimesDescription extends StatefulWidget {
  AnimesDescription(
      {Key key, this.heroTag, this.anime, this.option, this.isFavorite})
      : super(key: key);

  final String heroTag;
  final anime;
  final int option;
  final bool isFavorite;

  @override
  AnimesDescriptionState createState() => AnimesDescriptionState();
}

class AnimesDescriptionState extends State<AnimesDescription> {
  bool hasImg;
  double _height;
  double _width;
  double radius = 30;
  String title;

  var _isFavorite;

  @override
  void initState() {
    _isFavorite = widget.isFavorite;
    super.initState();
  }

  _addToDataBase() async {
    Anime anime = Anime(
      malId: widget.anime.malId,
      option: widget.option,
      title: widget.anime.title,
      url: widget.anime.url,
      imageUrl: widget.anime.imageUrl,
      score: widget.anime.score,
    );
    
    await DBProvider.db.newAnime(anime);
    setState(() {
      _isFavorite = true;
    });
    _displaySnackBar("Added to favorites");
  }

  removeFromDataBase() async {
    await DBProvider.db.deleteAnime(widget.anime.malId);
    setState(() {
      _isFavorite = false;
    });
    _displaySnackBar("Removed from favorites");
  }

  void _displaySnackBar(String text) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(seconds: 1),
      ),
    );
  }

  animeImage(animeInfo) {
    return new Container(
      width: _width,
      height: _height * 0.65,
      child: Hero(
        tag: widget.heroTag,
        child: CachedNetworkImage(
          imageUrl: animeInfo.imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              borderRadius: new BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              ),
            ),
          ),
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  animeTitle(animeInfo) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Center(
        child: Text(
          animeInfo.title,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  animeRating(animeInfo) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Mdi.star,
            size: 30,
            color: Colors.yellow,
          ),
          Text(
            animeInfo.score.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  animeStatus(animeInfo) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Wrap(
        runAlignment: WrapAlignment.start,
        alignment: WrapAlignment.start,
        children: <Widget>[
          Text(
            'Current Status: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            animeInfo.status.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  animeDescription(animeInfo) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Wrap(
        runAlignment: WrapAlignment.start,
        alignment: WrapAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'Synopsis: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Center(
            child: Text(
              animeInfo.synopsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  body(animeInfo) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          animeImage(animeInfo),
          animeTitle(animeInfo),
          animeRating(animeInfo),
          animeStatus(animeInfo),
          animeDescription(animeInfo),
          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }

  floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        _isFavorite ? removeFromDataBase() : _addToDataBase();
      },
      tooltip: 'Adcionar um novo anime ou Manga',
      backgroundColor:
          _isFavorite ? Colors.green : Theme.of(context).primaryColor,
      child: _isFavorite ? Icon(Icons.check) : Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: body(widget.anime),
      floatingActionButton: floatingActionButton(),
    );
  }
}

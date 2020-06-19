import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:mdi/mdi.dart';

class AnimesDescription extends StatefulWidget {
  AnimesDescription({Key key, this.anime, this.option}) : super(key: key);

  final anime;
  final int option;

  @override
  AnimesDescriptionState createState() => AnimesDescriptionState();
}

class AnimesDescriptionState extends State<AnimesDescription> {
  bool hasImg;
  double _height;
  double _width;
  double radius = 30;

  String title;

  @override
  void initState() {
    //widget.img
    //"https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fvignette.wikia.nocookie.net%2Ffategrandorder%2Fimages%2F1%2F1d%2FError404.png%2Frevision%2Flatest%3Fcb%3D20170204102207&f=1&nofb=1"
    super.initState();
  }

  Future getTop(animeId, option) async {
    var jikan = Jikan();
    var top = option == 1
        ? await jikan.getAnimeInfo(animeId)
        : await jikan.getMangaInfo(animeId);
    return top;
  }

  animeImage(animeInfo) {
    return new Container(
      width: _width,
      height: _height * 0.65,
      child: Hero(
        tag: widget.anime.title + widget.anime.imageUrl,
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
      onPressed: () async {
        var jikan = Jikan();
        var top = await jikan.getAnimeCharactersStaff(widget.anime.malId);
        print(top.characters);
        return top;
      },
      tooltip: 'Adcionar um novo anime ou Manga',
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(Icons.add),
    );
  }

  futureBuilder() {
    return new FutureBuilder(
      future: getTop(widget.anime.malId, widget.option),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return body(snapshot.data);
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
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: futureBuilder(),
      floatingActionButton: floatingActionButton(),
    );
  }
}

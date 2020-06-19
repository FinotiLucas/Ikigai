import 'package:allnihon/widgets/mainAppBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:allnihon/utils/string_extension.dart';

class CharacterDetails extends StatefulWidget {
  CharacterDetails(
      {Key key, this.character, this.hero, this.id, this.image, this.name})
      : super(key: key);

  final character;
  final String hero;
  final int id;
  final String image;
  final String name;

  @override
  CharacterDetailsState createState() => CharacterDetailsState();
}

class CharacterDetailsState extends State<CharacterDetails> {
  bool hasImg;
  double _height;
  double _width;
  double radius = 30;

  @override
  void initState() {
    //widget.img
    //"https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fvignette.wikia.nocookie.net%2Ffategrandorder%2Fimages%2F1%2F1d%2FError404.png%2Frevision%2Flatest%3Fcb%3D20170204102207&f=1&nofb=1"
    super.initState();
  }

  Future getCharactersDetails(characterId) async {
    var jikan = Jikan();
    var character = await jikan.getCharacterInfo(characterId);
    return character;
  }

  Future setAppBarTitle(character) {
    return null;
  }

  characterImage(characterInfo) {
    return new Container(
      width: _width,
      height: _height * 0.65,
      child: Hero(
        tag: widget.hero,
        child: CachedNetworkImage(
          imageUrl: widget.image,
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

  characterTitle(characterInfo) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Center(
        child: Text(
          "${characterInfo.name}, ${characterInfo.nameKanji}",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  characterDescription(characterInfo) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Wrap(
        runAlignment: WrapAlignment.start,
        alignment: WrapAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'About: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Center(
            child: Text(
              characterInfo.about.toString().removebl(),
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

  body(characterInfo) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          characterImage(characterInfo),
          characterTitle(characterInfo),
          characterDescription(characterInfo),
          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }

  futureBuilder() {
    return new FutureBuilder(
      future: getCharactersDetails(widget.id),
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
      appBar: mainAppBar(context, widget.name),
    );
  }
}

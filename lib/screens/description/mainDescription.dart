import 'package:ikigai/controllers/descriptionController.dart';
import 'package:ikigai/database/database.dart';
import 'package:ikigai/screens/description/characters.dart';
import 'package:ikigai/screens/description/description.dart';
import 'package:ikigai/screens/description/news.dart';
import 'package:ikigai/screens/description/reviews.dart';
import 'package:ikigai/widgets/mainAppBar.dart';
import 'package:flutter/material.dart';

class MainDescriptionPage extends StatefulWidget {
  MainDescriptionPage({Key key, this.anime, this.option}) : super(key: key);

  final anime;
  final int option;

  @override
  _MainDescriptionPageState createState() => _MainDescriptionPageState();
}

class _MainDescriptionPageState extends State<MainDescriptionPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>(); // Para o Drawer

  Future _future;
  bool isFavorite;
  @override
  void initState() {
    _isFavorite();
    _future = fetchDescriptions(widget.anime.malId, widget.option);
    super.initState();
  }

  _isFavorite() async {
    var favorite = await DBProvider.db.getAnime(widget.anime.malId);
    setState(() {
      isFavorite = favorite == null ? false : true;
    });
  }

  String _setHeroTag() {
    if (isFavorite) {
      return widget.anime.title + widget.anime.imageUrl + widget.anime.title;
    } else {
      return widget.anime.title + widget.anime.imageUrl;
    }
  }

  Widget _buildTab(String text) {
    return Tab(
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  body(data) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            //unselectedLabelColor: unselectedTabLabelColor,
            labelColor: Theme.of(context).primaryColor,
            indicatorColor: Colors.white,
            //indicatorColor: transparency,
            tabs: <Widget>[
              _buildTab("Info"),
              _buildTab("News"),
              _buildTab("Characters"),
              _buildTab("Reviews"),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: TabBarView(
            children: [
              AnimesDescription(
                heroTag: _setHeroTag(),
                anime: data[0],
                option: widget.option,
                isFavorite: isFavorite,
              ),
              NewsPage(
                anime: data[1],
              ),
              CharactersPage(
                anime: data[2],
              ),
              ReviewsPage(
                anime: data[3],
              ),
            ],
          ),
        ),
      ],
    );
  }

  futureBuilder() {
    return new FutureBuilder(
      future: _future,
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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: mainAppBar(context, widget.anime.title),
        body: futureBuilder(),
      ),
    );
  }
}

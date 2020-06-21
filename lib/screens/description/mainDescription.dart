import 'package:ikigai/controllers/descriptionController.dart';
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
  @override
  void initState() {
    _future = fetchDescriptions(widget.anime.malId, widget.option);
    super.initState();
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
                heroTag: widget.anime.title +  widget.anime.imageUrl,
                anime: data[0],
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

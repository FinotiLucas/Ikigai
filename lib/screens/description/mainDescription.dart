import 'package:allnihon/screens/description/characters.dart';
import 'package:allnihon/screens/description/description.dart';
import 'package:allnihon/screens/description/news.dart';
import 'package:allnihon/screens/description/reviews.dart';
import 'package:allnihon/widgets/mainAppBar.dart';
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

  @override
  void initState() {
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

  body() {
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
                anime: widget.anime,
                option: widget.option,
              ),
              NewsPage(
                animeId: widget.anime.malId,
                option: widget.option,
              ),
              CharactersPage(
                animeId: widget.anime.malId,
                option: widget.option,
              ),
              ReviewsPage(
                animeId: widget.anime.malId,
                option: widget.option,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: mainAppBar(context, widget.anime.title),
        body: body(),
      ),
    );
  }
}

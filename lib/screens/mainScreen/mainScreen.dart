import 'package:ikigai/controllers/indicationsController.dart';
import 'package:ikigai/screens/anime/animeCategories.dart';
import 'package:ikigai/screens/home/home.dart';
import 'package:ikigai/screens/indications/indications.dart';
import 'package:ikigai/screens/manga/mangaCategories.dart';
import 'package:ikigai/widgets/drawer.dart';
import 'package:ikigai/widgets/mainAppBar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({
    Key key,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>(); // Para o Drawer
  Future _future;

  @override
  void initState() {
    _future = fetchIndications();
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
              _buildTab("Home"),
              _buildTab("Indications"),
              _buildTab("Animes"),
              _buildTab("Mangas"),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: TabBarView(
            children: [
              HomePage(),
              IndicationsPage(
                data: data,
              ),
              AnimesCategoriesPage(),
              MangasCategoriesPage(),
            ],
          ),
        ),
      ],
    );
  }

  futureBuilder() {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return DefaultTabController(
            length: 4,
            child: Scaffold(
              key: _scaffoldKey,
              appBar: mainAppBar(context, "Ikigai"),
              body: body(snapshot.data),
              drawer: DrawerView(),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return futureBuilder();
  }
}

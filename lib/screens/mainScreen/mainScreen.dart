import 'package:allnihon/screens/anime/animeCategories.dart';
import 'package:allnihon/screens/indications/indications.dart';
import 'package:allnihon/screens/manga/mangaCategories.dart';
import 'package:allnihon/widgets/mainAppBar.dart';
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
              //_buildTab("Início"),
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
              //Container(),
              IndicationsPage(),
              AnimesCategoriesPage(),
              MangasCategoriesPage(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: mainAppBar(context, "All Nihon"),
        body: body(),
        //drawer: DrawerView(),
      ),
    );
  }
}

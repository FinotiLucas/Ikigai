import 'package:ikigai/widgets/mainAppBar.dart';
import 'package:ikigai/widgets/myGridView.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';

class SeasonPage extends StatefulWidget {
  SeasonPage({Key key}) : super(key: key);

  @override
  _SeasonPageState createState() => _SeasonPageState();
}

class _SeasonPageState extends State<SeasonPage> {
  int option = 1;
  Future _future;
  String seasonName = "";
  String seasonYear = "";

  @override
  void initState() {
    _future = getSeason();
    super.initState();
  }

  Future getSeason() async {
    var jikan = Jikan();
    var anime = await jikan.getSeason();
    setState(() {
      seasonName = anime.seasonName;
      seasonYear = anime.seasonYear.toString();
    });
    return anime;
  }

  futureBuilder() {
    return new FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return myGridView(snapshot.data.anime, option, false);
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
    /*_height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;*/
    return Scaffold(
      body: futureBuilder(),
      appBar: mainAppBar(context, " $seasonName $seasonYear"),
    );
  }
}

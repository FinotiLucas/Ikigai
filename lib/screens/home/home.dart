import 'package:ikigai/database/database.dart';
import 'package:ikigai/utils/utils.dart';
import 'package:ikigai/widgets/myGridView.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int option = 1;
  Future _future;
  @override
  void initState() {
    _future = DBProvider.db.getAllAnimes();
    super.initState();
  }

  noSearchImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          child: Image.asset(
            AvailableImages.home,
          ),
        ),
      ],
    );
  }

  futureBuilder() {
    return new FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return snapshot.data.isEmpty
              ? noSearchImage()
              : MyGridView(
                  animes: snapshot.data,
                  option: option,
                  isFavorite: false,
                );
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
    return Scaffold(
      body: futureBuilder(),
    );
  }
}

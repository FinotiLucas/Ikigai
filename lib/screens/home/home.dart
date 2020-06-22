import 'package:ikigai/database/database.dart';
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
            'assets/images/home.png',
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
              : myGridView(snapshot.data, option, true);
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
    );
  }
}

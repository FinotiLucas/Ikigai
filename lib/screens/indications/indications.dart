import 'package:ikigai/controllers/indicationsController.dart';
import 'package:ikigai/widgets/myGridView.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class IndicationsPage extends StatefulWidget {
  IndicationsPage({Key key}) : super(key: key);

  @override
  _IndicationsPageState createState() => _IndicationsPageState();
}

class _IndicationsPageState extends State<IndicationsPage> {
  Future _future;

  @override
  void initState() {
    _future = getTopAnime();
    super.initState();
  }

  body() {
    return new Column(
      children: <Widget>[
        Container(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                color: Theme.of(context).primaryColor,
                icon: Icon(Mdi.televisionClassic, color: Colors.white),
                label:
                    Text('Top Animes', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    option = 1;
                    _future = getTopAnime();
                  });
                },
              ),
              FlatButton.icon(
                color: Theme.of(context).primaryColor,
                icon: Icon(Mdi.bookOpen, color: Colors.white),
                label:
                    Text('Top Mangas', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    option = 2;
                    _future = getTopMangas();
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return myGridView(snapshot.data, option);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    /*_height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;*/
    return Scaffold(
      body: body(),
    );
  }
}

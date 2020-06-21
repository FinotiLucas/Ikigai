import 'package:ikigai/widgets/myGridView.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class IndicationsPage extends StatefulWidget {
  IndicationsPage({Key key, this.data}) : super(key: key);

  final data;
  @override
  _IndicationsPageState createState() => _IndicationsPageState();
}

class _IndicationsPageState extends State<IndicationsPage> {
  int option = 1;

  @override
  void initState() {
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
                    //_future = getTopAnime();
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
                    //_future = getTopMangas();
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: option == 1
              ? myGridView(widget.data[0], option)
              : myGridView(widget.data[1], option),
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

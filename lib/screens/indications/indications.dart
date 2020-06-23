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
  double radius = 10;
  Color selectButtonColor;

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
                color: option == 1 ? selectButtonColor : Colors.grey,
                icon: Icon(
                  Mdi.televisionClassic,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                ),
                label:
                    Text('Top Animes', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    option = 1;
                  });
                },
              ),
              FlatButton.icon(
                color: option == 2 ? selectButtonColor : Colors.grey,
                icon: Icon(Mdi.bookOpen, color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                ),
                label:
                    Text('Top Mangas', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    option = 2;
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: option == 1
              ? myGridView(widget.data[0], option, false)
              : myGridView(widget.data[1], option, false),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    selectButtonColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: body(),
    );
  }
}

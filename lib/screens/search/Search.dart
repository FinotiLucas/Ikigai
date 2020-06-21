import 'package:ikigai/controllers/searchController.dart';
import 'package:ikigai/widgets/myGridView.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = new TextEditingController();

  var _search;
  Future _future;
  int type;

  @override
  void initState() {
    type = 1;
    _search = null;
    super.initState();
  }

  body() {
    return new Column(
      children: <Widget>[
        new Container(
          color: Theme.of(context).primaryColor,
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Card(
              child: new ListTile(
                leading: new Icon(Icons.search),
                title: new TextField(
                  controller: controller,
                  decoration: new InputDecoration(
                      hintText: 'Search for a anime, manga or character',
                      border: InputBorder.none),
                ),
                trailing: new IconButton(
                  icon: new Icon(Icons.done),
                  onPressed: () async {
                    setState(() {
                      _search = controller.text;
                      _future = fetchSearch(controller.text);
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                color: Theme.of(context).primaryColor,
                icon: Icon(Mdi.televisionClassic, color: Colors.white),
                label: Text('Search for Animes',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    type = 1;
                  });
                },
              ),
              FlatButton.icon(
                color: Theme.of(context).primaryColor,
                icon: Icon(Mdi.bookOpen, color: Colors.white),
                label: Text('Search for Mangas',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    type = 2;
                  });
                },
              ),
              /*FlatButton.icon(
                color: Theme.of(context).primaryColor,
                icon: Icon(Mdi.accountMultiple, color: Colors.white),
                label:
                    Text('Characters', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    type = 3;
                    _future = getCharacterSearch(controller.text);
                  });
                },
              ),*/
            ],
          ),
        ),
        _search == null
            ? noSearchImage()
            : Expanded(
                child: futureBuilder(),
              ),
      ],
    );
  }

  noSearchImage() {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            child: Image.asset(
              'assets/images/seach.jpg',
            ),
          ),
        ],
      ),
    );
  }

  futureBuilder() {
    return new FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return type == 1
              ? myGridView(snapshot.data[0], type)
              : myGridView(snapshot.data[1], type);
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
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: new Text('Search'),
        elevation: 0.0,
      ),
      body: body(),
    );
  }
}

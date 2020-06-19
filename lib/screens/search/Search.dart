import 'package:allnihon/widgets/myGridView.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';
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

  Future getAnimeSearch(String query) async {
    var jikan = Jikan();
    var top = await jikan.search(query, SearchType.anime);
    return top;
  }

  Future getMangaSearch(String query) async {
    var jikan = Jikan();
    var top = await jikan.search(query, SearchType.manga);
    return top;
  }

  Future getCharacterSearch(String query) async {
    var jikan = Jikan();
    var top = await jikan.search(query, SearchType.character);
    return top;
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
                      hintText: 'Pesquisar', border: InputBorder.none),
                ),
                trailing: new IconButton(
                  icon: new Icon(Icons.done),
                  onPressed: () async {
                    setState(() {
                      _search = controller.text;
                      if (type == 1) {
                        _future = getAnimeSearch(controller.text);
                      } else if (type == 2) {
                        _future = getMangaSearch(controller.text);
                      } else {
                        _future = getCharacterSearch(controller.text);
                      }
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
                label: Text('Animes', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    type = 1;
                    _future = getAnimeSearch(controller.text);
                  });
                },
              ),
              FlatButton.icon(
                color: Theme.of(context).primaryColor,
                icon: Icon(Mdi.bookOpen, color: Colors.white),
                label: Text('Mangas', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    type = 2;
                    _future = getMangaSearch(controller.text);
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
            ? Container()
            : Expanded(
                child: futureBuilder(),
              ),
      ],
    );
  }

  futureBuilder() {
    return new FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return myGridView(snapshot.data, 1);
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
      appBar: new AppBar(
        title: new Text('Pesquisa'),
        elevation: 0.0,
      ),
      body: body(),
    );
  }
}

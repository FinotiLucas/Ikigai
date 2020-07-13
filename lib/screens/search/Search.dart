import 'package:ikigai/controllers/searchController.dart';
import 'package:ikigai/utils/utils.dart';
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
  Color selectButtonColor;
  double radius = 10;

  @override
  void initState() {
    type = 1;
    _search = null;
    super.initState();
  }

  _getSearch(value) {
    setState(() {
      _search = value;
      _future = fetchSearch(value);
      FocusScope.of(context).requestFocus(FocusNode());
    });
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
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) async {
                    _getSearch(value);
                  },
                  textInputAction: TextInputAction.search,
                ),
                trailing: new IconButton(
                  icon: new Icon(Icons.done),
                  onPressed: () async {
                    _getSearch(controller.text);
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
                color: type == 1 ? selectButtonColor : Colors.grey,
                icon: Icon(
                  Mdi.televisionClassic,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                ),
                label: Text(
                  'Search for Animes',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    type = 1;
                  });
                },
              ),
              FlatButton.icon(
                color: type == 2 ? selectButtonColor : Colors.grey,
                icon: Icon(
                  Mdi.bookOpen,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                ),
                label: Text(
                  'Search for Mangas',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    type = 2;
                  });
                },
              ),
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
      child: Image.asset(
        AvailableImages.seach,
        fit: BoxFit.fill,
      ),
    );
  }

  futureBuilder() {
    return new FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return type == 1
              ? MyGridView(
                  animes: snapshot.data[0],
                  option: type,
                  isFavorite: false,
                )
              : MyGridView(
                  animes: snapshot.data[1],
                  option: type,
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
    selectButtonColor = Theme.of(context).primaryColor;
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

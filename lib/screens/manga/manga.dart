import 'package:ikigai/widgets/mainAppBar.dart';
import 'package:ikigai/widgets/myGridView.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:ikigai/utils/string_extension.dart';

class MangasListPage extends StatefulWidget {
  MangasListPage({Key key, this.genre, this.categorie}) : super(key: key);
  final Genre genre;
  final categorie;

  @override
  _MangasListPageState createState() => _MangasListPageState();
}

class _MangasListPageState extends State<MangasListPage> {
  Future getTop() async {
    var jikan = Jikan();
    var top = await jikan.getGenre(GenreType.manga, widget.genre);
    return top;
  }

  @override
  void initState() {
    super.initState();
  }

  double radius = 15;
  body() {
    return new FutureBuilder(
      future: getTop(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return myGridView(snapshot.data.manga, 2, false);
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
    var title = widget.categorie.toString().capitalize();
    return Scaffold(
      appBar: mainAppBar(context,"$title Mangas"),
      body: body(),
    );
  }
}

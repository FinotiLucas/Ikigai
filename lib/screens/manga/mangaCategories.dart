import 'package:ikigai/screens/manga/manga.dart';
import 'package:ikigai/utils/genreLists.dart';
import 'package:ikigai/utils/string_extension.dart';
import 'package:flutter/material.dart';

class MangasCategoriesPage extends StatefulWidget {
  MangasCategoriesPage({Key key}) : super(key: key);

  @override
  _MangasCategoriesPageState createState() => _MangasCategoriesPageState();
}

class _MangasCategoriesPageState extends State<MangasCategoriesPage> {
  @override
  void initState() {
    super.initState();
  }

  double radius = 15;
  body() {
    return GridView.builder(
      itemCount: categoriesList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return new GestureDetector(
          onTap: () async {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (BuildContext context) => new MangasListPage(
                  genre: genres[index],
                  categorie: categoriesList[index]

                ),
              ),
            );
          },
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: new BorderRadius.all(
                      Radius.circular(radius),
                    ),
                  ),
                ),
                Center(
                  //padding: EdgeInsets.all(5),
                  child: Text(
                    categoriesList[index].toString().capitalize(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
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

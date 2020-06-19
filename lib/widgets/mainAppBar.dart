import 'package:allnihon/screens/search/Search.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

Widget mainAppBar(BuildContext context, String title) {
  return AppBar(
    elevation: 0,
    title: Text(
      title,
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Mdi.magnify,
          size: 30,
        ),
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) => new SearchPage(),
            ),
          );
        },
      ),
    ],
    centerTitle: false,
  );
}
//SearchPage

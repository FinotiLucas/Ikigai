import 'package:google_fonts/google_fonts.dart';
import 'package:ikigai/routers/routersName.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

Widget mainAppBar(BuildContext context, String title) {
  return AppBar(
    elevation: 0,
    title: title == "Ikigai"
        ? Text(
            "IKIGAI",
            style: GoogleFonts.architectsDaughter(
              textStyle: TextStyle(
                color: Colors.white,
              ),
              fontSize: 28,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          )
        : Text(
            title,
          ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Mdi.magnify,
          size: 30,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(RoutersName.searchRoute);
        },
      ),
    ],
    centerTitle: false,
  );
}
//SearchPage

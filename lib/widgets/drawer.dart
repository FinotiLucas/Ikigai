import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class DrawerView extends StatefulWidget {
  DrawerView({Key key}) : super(key: key);

  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  BuildContext _context;
  bool isLogged;
  @override
  void initState() {
    isLogged = false;
    super.initState();
  }

  void goToScreen(Widget page) {
    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (_context) => page,
      ),
    );
  }

  listTitle(String title, bool hasIcon, Widget leading, Widget page) {
    return hasIcon
        ? ListTile(
            title: Text(title),
            leading: leading,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => page,
                ),
              );
            },
          )
        : ListTile(
            title: Text(title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => page,
                ),
              );
            },
          );
  }

  drawerHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      height: 100,
      /*child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Text(
              "Please login",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "or sign up",
              style: TextStyle(
                color: Color.fromRGBO(255, 249, 244, 0.8),
              ),
            ),
            leading: Icon(Mdi.account,
                size: 40, color: Color.fromRGBO(255, 249, 244, 0.8)),
            onTap: () {
              print("Hello from DrawerHeader");
            },
          ),
        ],
      ),*/
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  drawer() {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          drawerHeader(),
          //listTitle("favorites", true, Icon(Mdi.cardsHeart), null),
          listTitle("Season", true, Icon(Mdi.clipboardTextPlay), null),
          listTitle("Schedule", true, Icon(Mdi.clockTimeSeven), null),
          listTitle("Magazine", true, Icon(Mdi.newspaperVariant), null),
          Divider(
            height: 10,
            thickness: 2,
          ),
          listTitle("Share us with your friends", true, Icon(Mdi.share), null),
          listTitle("About", true, Icon(Mdi.information), null),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return SafeArea(
      child: drawer(),
    );
  }
}

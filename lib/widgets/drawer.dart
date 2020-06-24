import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ikigai/screens/schedule/schedule.dart';
import 'package:ikigai/screens/season/season.dart';
import 'package:mdi/mdi.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

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

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _share() async {
    //https://github.com/FinotiLucas/Ikigai/releases
    Share.share(
      'Check this app out https://github.com/FinotiLucas/Ikigai/releases',
      subject: 'Check out Ikigai, Anime and Manga encyclopedia',
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

  listTitleUrl(String title, bool hasIcon, Widget leading, String url) {
    return ListTile(
      title: Text(title),
      leading: leading,
      onTap: () {
        _launchURL(url);
      },
    );
  }

  listTitleShare(String title, bool hasIcon, Widget leading) {
    return ListTile(
      title: Text(title),
      leading: leading,
      onTap: () {
        _share();
      },
    );
  }

  drawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "IKIGAI",
            style: GoogleFonts.architectsDaughter(
              textStyle: TextStyle(
                color: Colors.white,
              ),
              fontSize: 48,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
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
          listTitle("Season", true, Icon(Mdi.clipboardTextPlay), SeasonPage()),
          listTitle("Schedule", true, Icon(Mdi.clockTimeSeven), SchedulePage()),
          //listTitle("Configurations", true, Icon(Mdi.cog), SchedulePage()),
          Divider(
            height: 10,
            thickness: 2,
          ),
          listTitleShare("Share us with your friends", true, Icon(Mdi.share)),
          listTitleUrl(
            "About",
            true,
            Icon(Mdi.information),
            "https://github.com/FinotiLucas/Ikigai",
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return drawer();
  }
}

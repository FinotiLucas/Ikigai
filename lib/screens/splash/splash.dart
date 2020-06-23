import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({
    Key key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget body(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor, //Color.fromRGBO(25, 23, 39, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Ikigai",
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "Lobster",
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Expanded(
            child: Image.asset('assets/images/splash.png'),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "From",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "Lobster",
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Aliati",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Lobster",
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Software",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: body(context),
    );
  }
}

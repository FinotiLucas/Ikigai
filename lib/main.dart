import 'package:flutter/services.dart';
import 'package:ikigai/routers/routersName.dart';
import 'package:ikigai/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:ikigai/utils/utils.dart';

void main() {
  runApp(MyApp());
  _portraitModeOnly();
}

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: generateRoute,
      initialRoute: RoutersName.homeRoute,
    );
  }
}
